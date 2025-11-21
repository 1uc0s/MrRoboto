"""
Serial Interface for PIC18 Communication
Handles PySerial communication with the PIC18 microcontroller.
"""

import serial
import time
import threading
from typing import Dict, Optional, Callable
from robot_config import RobotConfig


class SerialInterface:
    """Serial communication interface for robot control."""
    
    def __init__(self, config: RobotConfig, debug: bool = False):
        """
        Initialize serial interface.
        
        Args:
            config: RobotConfig instance with serial settings
            debug: Enable debug output
        """
        self.config = config
        self.debug = debug
        self.serial_port: Optional[serial.Serial] = None
        self.connected = False
        
        # Response callback for async communication
        self.response_callback: Optional[Callable] = None
        
        # Background reader thread
        self.reader_thread: Optional[threading.Thread] = None
        self.running = False
        
    def connect(self) -> bool:
        """
        Open serial connection to PIC18.
        
        Returns:
            True if connection successful
        """
        try:
            self.serial_port = serial.Serial(
                port=self.config.serial_config['port'],
                baudrate=self.config.serial_config['baudrate'],
                timeout=self.config.serial_config['timeout'],
                write_timeout=self.config.serial_config['write_timeout']
            )
            
            # Wait for connection to stabilize
            time.sleep(2)
            
            # Clear any startup garbage
            self.serial_port.reset_input_buffer()
            self.serial_port.reset_output_buffer()
            
            self.connected = True
            
            if self.debug:
                print(f"Connected to {self.config.serial_config['port']} at {self.config.serial_config['baudrate']} baud")
            
            # Start background reader
            self._start_reader_thread()
            
            return True
            
        except serial.SerialException as e:
            if self.debug:
                print(f"Failed to connect: {e}")
            self.connected = False
            return False
    
    def disconnect(self):
        """Close serial connection."""
        self.running = False
        
        if self.reader_thread and self.reader_thread.is_alive():
            self.reader_thread.join(timeout=1.0)
        
        if self.serial_port and self.serial_port.is_open:
            self.serial_port.close()
            if self.debug:
                print("Disconnected from serial port")
        
        self.connected = False
    
    def _start_reader_thread(self):
        """Start background thread to read responses."""
        self.running = True
        self.reader_thread = threading.Thread(target=self._read_loop, daemon=True)
        self.reader_thread.start()
    
    def _read_loop(self):
        """Background loop to read serial responses."""
        while self.running and self.serial_port and self.serial_port.is_open:
            try:
                if self.serial_port.in_waiting > 0:
                    line = self.serial_port.readline().decode('ascii', errors='ignore').strip()
                    if line and self.debug:
                        print(f"← Received: {line}")
                    
                    if self.response_callback:
                        self.response_callback(line)
                else:
                    time.sleep(0.01)  # Small delay to avoid busy waiting
                    
            except (serial.SerialException, OSError) as e:
                if self.debug:
                    print(f"Read error: {e}")
                time.sleep(0.1)
    
    def send_command(self, command: str, wait_for_response: bool = False, 
                    timeout: float = 5.0) -> Optional[str]:
        """
        Send command to PIC18.
        
        Args:
            command: Command string (without newline)
            wait_for_response: Block until response received
            timeout: Response timeout (seconds)
            
        Returns:
            Response string if wait_for_response=True, else None
        """
        if not self.connected or not self.serial_port:
            if self.debug:
                print("Not connected to serial port")
            return None
        
        try:
            # Format command with newline
            cmd = f"{command}\n"
            
            if self.debug:
                print(f"→ Sending: {command}")
            
            self.serial_port.write(cmd.encode('ascii'))
            
            if wait_for_response:
                start_time = time.time()
                while (time.time() - start_time) < timeout:
                    if self.serial_port.in_waiting > 0:
                        response = self.serial_port.readline().decode('ascii', errors='ignore').strip()
                        if self.debug:
                            print(f"← Response: {response}")
                        return response
                    time.sleep(0.01)
                
                if self.debug:
                    print("Response timeout")
                return None
            
            return None
            
        except (serial.SerialException, OSError) as e:
            if self.debug:
                print(f"Send error: {e}")
            return None
    
    def move_to_angles(self, angles: Dict[str, float], 
                      wait_completion: bool = False) -> bool:
        """
        Send MOVE command with joint angles.
        
        Args:
            angles: Dictionary with keys 'base', 'shoulder', 'elbow', 'wrist' (degrees)
            wait_completion: Wait for "OK" response
            
        Returns:
            True if command sent successfully (and OK received if waiting)
        """
        # Format: MOVE <theta1> <theta2> <theta3> <theta4>
        command = f"MOVE {angles['base']:.2f} {angles['shoulder']:.2f} {angles['elbow']:.2f} {angles['wrist']:.2f}"
        
        if wait_completion:
            response = self.send_command(command, wait_for_response=True)
            return response == "OK"
        else:
            self.send_command(command)
            return True
    
    def move_to_steps(self, steps: Dict[str, int], 
                     wait_completion: bool = False) -> bool:
        """
        Send STEP command with motor step counts.
        
        Args:
            steps: Dictionary with motor step counts
            wait_completion: Wait for "OK" response
            
        Returns:
            True if command sent successfully
        """
        # Format: STEP <base_steps> <shoulder_steps> <elbow_steps> <wrist_steps>
        command = f"STEP {steps['base']} {steps['shoulder']} {steps['elbow']} {steps['wrist']}"
        
        if wait_completion:
            response = self.send_command(command, wait_for_response=True)
            return response == "OK"
        else:
            self.send_command(command)
            return True
    
    def home(self, wait_completion: bool = True) -> bool:
        """
        Send HOME command to move all motors to limit positions.
        
        Args:
            wait_completion: Wait for "OK" response
            
        Returns:
            True if homing successful
        """
        response = self.send_command("HOME", wait_for_response=wait_completion, timeout=30.0)
        
        if wait_completion:
            return response == "OK"
        return True
    
    def stop(self) -> bool:
        """
        Send STOP command to halt all motors immediately.
        
        Returns:
            True if command sent
        """
        self.send_command("STOP")
        return True
    
    def get_status(self) -> Optional[Dict[str, float]]:
        """
        Query current joint angles from PIC18.
        
        Returns:
            Dictionary of current angles or None if failed
        """
        response = self.send_command("STATUS", wait_for_response=True)
        
        if response:
            try:
                # Expected format: "STATUS <theta1> <theta2> <theta3> <theta4>"
                parts = response.split()
                if len(parts) == 5 and parts[0] == "STATUS":
                    return {
                        'base': float(parts[1]),
                        'shoulder': float(parts[2]),
                        'elbow': float(parts[3]),
                        'wrist': float(parts[4])
                    }
            except (ValueError, IndexError):
                if self.debug:
                    print(f"Failed to parse status response: {response}")
        
        return None
    
    def set_speed(self, speed: int) -> bool:
        """
        Set motor speed (steps per second).
        
        Args:
            speed: Steps per second (1-1000)
            
        Returns:
            True if command sent
        """
        command = f"SPEED {speed}"
        response = self.send_command(command, wait_for_response=True)
        return response == "OK"
    
    def calibrate_joint(self, joint: str, steps: int) -> bool:
        """
        Move a single joint for calibration.
        
        Args:
            joint: Joint name ('base', 'shoulder', 'elbow', 'wrist')
            steps: Number of steps to move (positive or negative)
            
        Returns:
            True if command sent
        """
        joint_map = {
            'base': 0,
            'shoulder': 1,
            'elbow': 2,
            'wrist': 3
        }
        
        if joint not in joint_map:
            return False
        
        command = f"CAL {joint_map[joint]} {steps}"
        response = self.send_command(command, wait_for_response=True, timeout=30.0)
        return response == "OK"
    
    def set_response_callback(self, callback: Callable[[str], None]):
        """
        Set callback function for async responses.
        
        Args:
            callback: Function to call with each received line
        """
        self.response_callback = callback
    
    def __enter__(self):
        """Context manager entry."""
        self.connect()
        return self
    
    def __exit__(self, exc_type, exc_val, exc_tb):
        """Context manager exit."""
        self.disconnect()


class MockSerialInterface(SerialInterface):
    """Mock serial interface for testing without hardware."""
    
    def __init__(self, config: RobotConfig, debug: bool = False):
        """Initialize mock interface."""
        super().__init__(config, debug)
        self.current_angles = config.home_position.copy()
        
    def connect(self) -> bool:
        """Simulate connection."""
        if self.debug:
            print("Mock: Connected to virtual robot")
        self.connected = True
        return True
    
    def disconnect(self):
        """Simulate disconnect."""
        if self.debug:
            print("Mock: Disconnected from virtual robot")
        self.connected = False
    
    def send_command(self, command: str, wait_for_response: bool = False,
                    timeout: float = 5.0) -> Optional[str]:
        """Simulate command processing."""
        if self.debug:
            print(f"Mock → {command}")
        
        parts = command.split()
        
        if not parts:
            return None
        
        cmd = parts[0]
        
        if cmd == "MOVE" and len(parts) == 5:
            # Update mock state
            self.current_angles = {
                'base': float(parts[1]),
                'shoulder': float(parts[2]),
                'elbow': float(parts[3]),
                'wrist': float(parts[4])
            }
            time.sleep(0.1)  # Simulate movement delay
            return "OK" if wait_for_response else None
        
        elif cmd == "HOME":
            self.current_angles = self.config.home_position.copy()
            time.sleep(0.5)  # Simulate homing delay
            return "OK" if wait_for_response else None
        
        elif cmd == "STATUS":
            response = f"STATUS {self.current_angles['base']:.2f} {self.current_angles['shoulder']:.2f} {self.current_angles['elbow']:.2f} {self.current_angles['wrist']:.2f}"
            return response if wait_for_response else None
        
        elif cmd == "STOP":
            return "OK" if wait_for_response else None
        
        elif cmd == "SPEED":
            return "OK" if wait_for_response else None
        
        elif cmd == "CAL":
            time.sleep(0.2)
            return "OK" if wait_for_response else None
        
        return "ERROR" if wait_for_response else None

