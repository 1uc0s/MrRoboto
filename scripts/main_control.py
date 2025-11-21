"""
Main Control Loop for Robot Arm
Integrates IK solver, serial communication, and visualization.
"""

import time
import numpy as np
import matplotlib.pyplot as plt
from typing import List, Dict, Tuple, Optional
import argparse

from robot_config import RobotConfig, config
from ik_solver import IKSolver
from serial_interface import SerialInterface, MockSerialInterface
from visualizer import RobotVisualizer
from calibration import CalibrationWizard


class RobotController:
    """Main controller integrating all robot subsystems."""
    
    def __init__(self, config: RobotConfig, use_mock: bool = False, 
                 visualize: bool = True, debug: bool = False):
        """
        Initialize robot controller.
        
        Args:
            config: Robot configuration
            use_mock: Use mock serial interface (for testing without hardware)
            visualize: Enable visualization
            debug: Enable debug output
        """
        self.config = config
        self.debug = debug
        
        # Initialize subsystems
        self.ik_solver = IKSolver(config)
        
        if use_mock:
            self.serial = MockSerialInterface(config, debug=debug)
            print("Using MOCK serial interface (no hardware)")
        else:
            self.serial = SerialInterface(config, debug=debug)
        
        self.visualizer = RobotVisualizer(config) if visualize else None
        
        # Current state
        self.current_angles = config.home_position.copy()
        self.connected = False
    
    def connect(self) -> bool:
        """Connect to robot."""
        if self.serial.connect():
            self.connected = True
            print("✓ Connected to robot")
            return True
        else:
            print("✗ Failed to connect")
            return False
    
    def disconnect(self):
        """Disconnect from robot."""
        self.serial.disconnect()
        self.connected = False
        print("Disconnected")
    
    def home(self) -> bool:
        """Move robot to home position."""
        print("Homing robot...")
        success = self.serial.home(wait_completion=True)
        
        if success:
            self.current_angles = self.config.home_position.copy()
            if self.visualizer:
                self.visualizer.update_pose(self.current_angles)
            print("✓ Homing complete")
            return True
        else:
            print("✗ Homing failed")
            return False
    
    def move_to_position(self, rho: float, phi: float, z: float,
                        desired_pitch: float = 0.0,
                        wait: bool = True) -> bool:
        """
        Move end effector to cylindrical coordinates.
        
        Args:
            rho: Radial distance (mm)
            phi: Azimuthal angle (degrees)
            z: Height (mm)
            desired_pitch: End effector pitch (degrees)
            wait: Wait for movement completion
            
        Returns:
            True if successful
        """
        # Solve IK
        success, angles, message = self.ik_solver.solve(rho, phi, z, desired_pitch)
        
        if not success:
            print(f"IK failed: {message}")
            return False
        
        print(f"Target: (ρ={rho:.1f}, φ={phi:.1f}°, z={z:.1f})")
        print(f"Angles: θ1={angles['base']:.1f}° θ2={angles['shoulder']:.1f}° "
              f"θ3={angles['elbow']:.1f}° θ4={angles['wrist']:.1f}°")
        
        # Validate coupling
        if self.config.coupling_enabled:
            valid, error = self.ik_solver.validate_coupling(
                angles['shoulder'], angles['elbow']
            )
            if self.debug:
                print(f"Coupling validation: valid={valid}, error={error:.2f}°")
        
        # Update visualization
        if self.visualizer:
            self.visualizer.set_target(rho, phi, z)
            self.visualizer.update_pose(angles)
            plt.pause(0.1)
        
        # Send to robot
        if self.connected:
            success = self.serial.move_to_angles(angles, wait_completion=wait)
            if success:
                self.current_angles = angles
                print("✓ Movement complete")
                return True
            else:
                print("✗ Movement failed")
                return False
        else:
            # Just update state if not connected
            self.current_angles = angles
            return True
    
    def execute_trajectory(self, waypoints: List[Tuple[float, float, float]],
                          delay: float = 1.0):
        """
        Execute trajectory through multiple waypoints.
        
        Args:
            waypoints: List of (rho, phi, z) tuples
            delay: Time between waypoints (seconds)
        """
        print(f"\nExecuting trajectory with {len(waypoints)} waypoints...")
        
        for i, (rho, phi, z) in enumerate(waypoints):
            print(f"\nWaypoint {i+1}/{len(waypoints)}: ({rho:.1f}, {phi:.1f}°, {z:.1f})")
            
            success = self.move_to_position(rho, phi, z, wait=True)
            
            if not success:
                print(f"Failed at waypoint {i+1}, aborting trajectory")
                return False
            
            if i < len(waypoints) - 1:  # Don't delay after last waypoint
                time.sleep(delay)
        
        print("\n✓ Trajectory complete")
        return True
    
    def test_point_to_point(self):
        """Test with simple point-to-point movements."""
        print("\n" + "="*60)
        print("Test: Point-to-Point Movements")
        print("="*60)
        
        test_points = [
            (200, 0, 200, "Front, medium height"),
            (150, 45, 250, "Front-right, high"),
            (180, 90, 150, "Right side, low"),
            (200, -45, 220, "Front-left, medium"),
            (150, 0, 180, "Front, centered")
        ]
        
        for rho, phi, z, description in test_points:
            print(f"\n→ {description}")
            self.move_to_position(rho, phi, z)
            time.sleep(2)
        
        print("\n✓ Point-to-point test complete")
    
    def test_circular_trajectory(self, radius: float = 180, 
                                 center_z: float = 200,
                                 num_points: int = 12):
        """
        Test with circular trajectory in XY plane.
        
        Args:
            radius: Circle radius (mm)
            center_z: Height of circle (mm)
            num_points: Number of points in circle
        """
        print("\n" + "="*60)
        print(f"Test: Circular Trajectory (r={radius}mm, z={center_z}mm)")
        print("="*60)
        
        # Generate circle waypoints
        angles = np.linspace(0, 360, num_points, endpoint=False)
        waypoints = [(radius, angle, center_z) for angle in angles]
        
        # Close the loop
        waypoints.append(waypoints[0])
        
        self.execute_trajectory(waypoints, delay=0.5)
    
    def test_figure_eight(self, size: float = 80, 
                         center_rho: float = 200,
                         center_z: float = 200,
                         num_points: int = 24):
        """
        Test with figure-eight trajectory.
        
        Args:
            size: Size of figure-eight (mm)
            center_rho: Center radial position (mm)
            center_z: Center height (mm)
            num_points: Number of points in trajectory
        """
        print("\n" + "="*60)
        print(f"Test: Figure-Eight Trajectory (size={size}mm)")
        print("="*60)
        
        # Parametric figure-eight: Lemniscate of Gerono
        t = np.linspace(0, 2*np.pi, num_points)
        
        # Generate in Cartesian, convert to cylindrical
        waypoints = []
        for ti in t:
            # Lemniscate equations
            x_offset = size * np.cos(ti)
            y_offset = size * np.sin(ti) * np.cos(ti)
            
            # Convert to cylindrical (assuming figure-eight in XY plane at fixed Z)
            x = center_rho + x_offset
            y = y_offset
            
            rho = np.sqrt(x**2 + y**2)
            phi = np.degrees(np.arctan2(y, x))
            z = center_z
            
            waypoints.append((rho, phi, z))
        
        # Close loop
        waypoints.append(waypoints[0])
        
        self.execute_trajectory(waypoints, delay=0.3)
    
    def test_workspace_boundary(self, num_points: int = 16):
        """
        Test movement along workspace boundary.
        
        Args:
            num_points: Number of test points
        """
        print("\n" + "="*60)
        print("Test: Workspace Boundary Exploration")
        print("="*60)
        
        if not self.config.max_reach:
            print("Max reach not defined, skipping")
            return
        
        # Test at maximum reach
        radius = self.config.max_reach * 0.95  # 95% of max for safety
        
        waypoints = []
        
        # Horizontal circle at mid-height
        mid_z = (self.config.workspace_z_min + self.config.workspace_z_max) / 2
        for angle in np.linspace(0, 360, num_points, endpoint=False):
            waypoints.append((radius, angle, mid_z))
        
        self.execute_trajectory(waypoints, delay=0.5)
    
    def interactive_mode(self):
        """Interactive control mode."""
        print("\n" + "="*60)
        print("Interactive Mode")
        print("="*60)
        print("\nCommands:")
        print("  move <rho> <phi> <z>  - Move to position")
        print("  home                  - Return to home")
        print("  status                - Show current position")
        print("  test <name>           - Run test (point|circle|eight|boundary)")
        print("  quit                  - Exit")
        print()
        
        while True:
            try:
                cmd = input("robot> ").strip().lower()
                
                if not cmd:
                    continue
                
                parts = cmd.split()
                
                if parts[0] == 'quit' or parts[0] == 'exit':
                    break
                
                elif parts[0] == 'move' and len(parts) >= 4:
                    rho = float(parts[1])
                    phi = float(parts[2])
                    z = float(parts[3])
                    self.move_to_position(rho, phi, z)
                
                elif parts[0] == 'home':
                    self.home()
                
                elif parts[0] == 'status':
                    print(f"Current angles: {self.current_angles}")
                    # Compute forward kinematics
                    rho, phi, z = self.ik_solver.forward_kinematics(
                        self.current_angles['base'],
                        self.current_angles['shoulder'],
                        self.current_angles['elbow'],
                        self.current_angles['wrist']
                    )
                    print(f"Position: (ρ={rho:.1f}, φ={phi:.1f}°, z={z:.1f})")
                
                elif parts[0] == 'test' and len(parts) >= 2:
                    test_name = parts[1]
                    if test_name == 'point':
                        self.test_point_to_point()
                    elif test_name == 'circle':
                        self.test_circular_trajectory()
                    elif test_name == 'eight':
                        self.test_figure_eight()
                    elif test_name == 'boundary':
                        self.test_workspace_boundary()
                    else:
                        print(f"Unknown test: {test_name}")
                
                else:
                    print("Unknown command or invalid arguments")
                
            except KeyboardInterrupt:
                print("\nInterrupted")
                break
            except Exception as e:
                print(f"Error: {e}")
        
        print("\nExiting interactive mode")
    
    def run_all_tests(self):
        """Run complete test suite."""
        print("\n" + "="*60)
        print("Running Complete Test Suite")
        print("="*60)
        
        # Home first
        if not self.home():
            print("Failed to home, aborting tests")
            return
        
        time.sleep(2)
        
        # Run tests
        self.test_point_to_point()
        time.sleep(2)
        
        self.test_circular_trajectory()
        time.sleep(2)
        
        self.test_figure_eight()
        time.sleep(2)
        
        self.test_workspace_boundary()
        
        # Return home
        print("\nReturning home...")
        self.home()
        
        print("\n" + "="*60)
        print("All Tests Complete")
        print("="*60)


def main():
    """Main entry point."""
    parser = argparse.ArgumentParser(description='Robot Arm Controller')
    parser.add_argument('--mock', action='store_true', 
                       help='Use mock serial interface (no hardware)')
    parser.add_argument('--no-viz', action='store_true',
                       help='Disable visualization')
    parser.add_argument('--debug', action='store_true',
                       help='Enable debug output')
    parser.add_argument('--calibrate', action='store_true',
                       help='Run calibration wizard')
    parser.add_argument('--load-calib', type=str,
                       help='Load calibration from file')
    parser.add_argument('--test', type=str, choices=['point', 'circle', 'eight', 'boundary', 'all'],
                       help='Run specific test')
    parser.add_argument('--interactive', action='store_true',
                       help='Start interactive mode')
    
    args = parser.parse_args()
    
    # Load calibration if specified
    if args.load_calib:
        wizard = CalibrationWizard(config, MockSerialInterface(config))
        wizard.load_calibration(args.load_calib)
    
    # Create controller
    controller = RobotController(
        config,
        use_mock=args.mock,
        visualize=not args.no_viz,
        debug=args.debug
    )
    
    # Connect
    if not controller.connect():
        print("Failed to connect to robot")
        return 1
    
    try:
        # Run calibration
        if args.calibrate:
            wizard = CalibrationWizard(config, controller.serial)
            wizard.run_full_calibration()
            return 0
        
        # Run test
        if args.test:
            controller.home()
            time.sleep(1)
            
            if args.test == 'point':
                controller.test_point_to_point()
            elif args.test == 'circle':
                controller.test_circular_trajectory()
            elif args.test == 'eight':
                controller.test_figure_eight()
            elif args.test == 'boundary':
                controller.test_workspace_boundary()
            elif args.test == 'all':
                controller.run_all_tests()
        
        # Interactive mode
        elif args.interactive:
            controller.interactive_mode()
        
        # Default: run all tests
        else:
            print("No action specified. Use --interactive, --test, or --calibrate")
            print("Running demo with mock interface...")
            controller.run_all_tests()
        
        # Keep visualization open
        if controller.visualizer:
            print("\nClose visualization window to exit")
            plt.show()
    
    finally:
        controller.disconnect()
    
    return 0


if __name__ == '__main__':
    exit(main())

