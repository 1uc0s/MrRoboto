"""
Robot Configuration Module
Defines all robot parameters, constraints, and coupling relationships.
"""

import numpy as np
from typing import Dict, Tuple, Optional

class RobotConfig:
    """Configuration for 4-DOF planar robot arm with shoulder-elbow coupling."""
    
    def __init__(self):
        # Link Lengths (mm) - Update these after physical measurement
        # Set to None if not yet measured, or provide estimated values
        self.L0 = 250.0  # Base height (ground to shoulder pivot)
        self.L1 = 190.0  # Upper arm length (shoulder to elbow)
        self.L2 = 190.0  # Forearm length (elbow to wrist)
        self.L3 = 10.0   # End effector length (wrist to gripper center)
        
        # Gear Ratios (steps per degree) - Measured from calibration
        # Motor base: 7.5° step angle = 48 steps/revolution
        # Shoulder/Elbow: 96 steps = 18.5° movement → 5.189 steps/degree
        self.gear_ratios = {
            'base': 48.0 / 360.0,      # Placeholder: 0.133 steps/degree (to be calibrated)
            'shoulder': 5.189,          # Measured: 96 steps = 18.5°
            'elbow': 5.189,             # Measured: 96 steps = 18.5°
            'wrist': 48.0 / 360.0       # To be calibrated
        }
        
        # Joint Limits (degrees) - Based on home position at mechanical limits
        # Home position: all motors at limits (stable configuration)
        # Define as (min, max) from home position
        self.joint_limits = {
            'base': (-180.0, 180.0),      # Full rotation
            'shoulder': (0.0, 135.0),     # From home (arm up) to forward
            'elbow': (0.0, 135.0),        # From home to fully bent
            'wrist': (-90.0, 90.0)        # Pitch range
        }
        
        # Coupling Parameters
        # Shoulder-elbow coupling: tendon-actuated mechanism (ONE-WAY coupling)
        # When shoulder moves forward (+18.5°), tendon pulls elbow backward (-18.5°)
        # The arms close together when shoulder moves forward
        # IMPORTANT: Coupling is ONE-WAY only:
        #   - Shoulder movement affects elbow (ratio = -1.0)
        #   - Elbow can move independently without affecting shoulder
        # Model: When shoulder moves, theta3_coupled = coupling_ratio * theta2 + theta3_independent
        self.coupling_enabled = True
        self.coupling_ratio = -1.0  # Negative for opposite directions (measured)
        self.coupling_offset = 0.0  # No offset (measured)
        
        # Home Position (degrees) - All motors at mechanical limits
        self.home_position = {
            'base': 0.0,       # Center position
            'shoulder': 0.0,   # Arm pointing up (at limit)
            'elbow': 0.0,      # Fully extended (at limit)
            'wrist': 0.0       # Level orientation
        }
        
        # Serial Communication Settings
        # Windows: Use 'COMx' (e.g., 'COM3', 'COM4') - Check Device Manager > Ports (COM & LPT)
        # macOS: Use '/dev/tty.usbserial-xxxx' 
        # Linux: Use '/dev/ttyUSBx' (e.g., '/dev/ttyUSB0')
        # Note: EasyPIC Pro 7 uses FT232RL USB-UART converter (requires FTDI drivers)
        #       Ensure SW5.1 (RC6) and SW5.2 (RC7) are ON to enable USB-UART
        self.serial_config = {
            'port': 'COM3',  # Windows COM port - adjust number as needed
            'baudrate': 9600,  # Standard baud rate for UART communication
            'timeout': 1.0,
            'write_timeout': 1.0
        }
        
        # Safety Parameters
        self.max_reach = None  # Calculated from link lengths
        self.min_reach = None  # Minimum reachable radius
        self.workspace_z_min = None  # Minimum Z height
        self.workspace_z_max = None  # Maximum Z height
        
        # Calculate derived parameters
        self._calculate_workspace()
    
    def _calculate_workspace(self):
        """Calculate workspace boundaries from link lengths."""
        if self.L0 is not None and self.L1 is not None and self.L2 is not None:
            # Maximum reach (arm fully extended horizontally)
            self.max_reach = self.L1 + self.L2 + self.L3
            
            # Minimum reach (arm fully folded, depends on coupling)
            # Conservative estimate: difference of links
            self.min_reach = abs(self.L1 - self.L2)
            
            # Z workspace (vertical range)
            # Maximum: arm pointing up
            self.workspace_z_max = self.L0 + self.L1 + self.L2 + self.L3
            
            # Minimum: arm pointing down (if mechanically possible)
            # For now, assume can't go below base significantly
            self.workspace_z_min = self.L0 - (self.L1 + self.L2)
            
    def apply_coupling(self, theta2: float) -> float:
        """
        Calculate theta3 from theta2 using coupling relationship.
        
        Scissor mechanism: when shoulder moves back, elbow closes.
        
        Args:
            theta2: Shoulder angle (degrees)
            
        Returns:
            theta3: Coupled elbow angle (degrees)
        """
        if not self.coupling_enabled:
            raise ValueError("Coupling is disabled, theta3 must be specified independently")
        
        # Linear coupling model: theta3 = ratio * theta2 + offset
        # For scissor: when theta2 increases (shoulder down), theta3 increases (elbow bends)
        theta3 = self.coupling_ratio * theta2 + self.coupling_offset
        
        # Clamp to joint limits
        min_theta3, max_theta3 = self.joint_limits['elbow']
        theta3 = np.clip(theta3, min_theta3, max_theta3)
        
        return theta3
    
    def inverse_coupling(self, theta3: float) -> float:
        """
        Calculate theta2 from theta3 (inverse of coupling relationship).
        
        Args:
            theta3: Elbow angle (degrees)
            
        Returns:
            theta2: Corresponding shoulder angle (degrees)
        """
        if not self.coupling_enabled or self.coupling_ratio == 0:
            raise ValueError("Cannot invert coupling relationship")
        
        theta2 = (theta3 - self.coupling_offset) / self.coupling_ratio
        
        # Clamp to joint limits
        min_theta2, max_theta2 = self.joint_limits['shoulder']
        theta2 = np.clip(theta2, min_theta2, max_theta2)
        
        return theta2
    
    def is_position_reachable(self, rho: float, z: float) -> Tuple[bool, str]:
        """
        Check if a position in cylindrical coordinates is reachable.
        
        Args:
            rho: Radial distance from base axis (mm)
            z: Height above base (mm)
            
        Returns:
            (reachable, reason): Boolean and explanation string
        """
        # Check if within workspace boundaries
        if self.max_reach is None:
            return False, "Workspace not calculated (link lengths not set)"
        
        # Distance from shoulder joint
        z_from_shoulder = z - self.L0
        distance = np.sqrt(rho**2 + z_from_shoulder**2)
        
        # Check reach limits
        if distance > self.max_reach:
            return False, f"Target too far: {distance:.1f}mm > {self.max_reach:.1f}mm max reach"
        
        if distance < self.min_reach:
            return False, f"Target too close: {distance:.1f}mm < {self.min_reach:.1f}mm min reach"
        
        # Check Z limits
        if z > self.workspace_z_max:
            return False, f"Target too high: {z:.1f}mm > {self.workspace_z_max:.1f}mm max height"
        
        if z < self.workspace_z_min:
            return False, f"Target too low: {z:.1f}mm < {self.workspace_z_min:.1f}mm min height"
        
        return True, "Position is reachable"
    
    def angles_to_steps(self, angles: Dict[str, float]) -> Dict[str, int]:
        """
        Convert joint angles (degrees) to motor steps.
        
        Args:
            angles: Dictionary of joint angles {'base': θ1, 'shoulder': θ2, ...}
            
        Returns:
            Dictionary of motor steps for each joint
        """
        steps = {}
        for joint, angle in angles.items():
            if joint in self.gear_ratios:
                steps[joint] = int(angle * self.gear_ratios[joint])
        return steps
    
    def steps_to_angles(self, steps: Dict[str, int]) -> Dict[str, float]:
        """
        Convert motor steps to joint angles (degrees).
        
        Args:
            steps: Dictionary of motor steps
            
        Returns:
            Dictionary of joint angles in degrees
        """
        angles = {}
        for joint, step_count in steps.items():
            if joint in self.gear_ratios and self.gear_ratios[joint] != 0:
                angles[joint] = step_count / self.gear_ratios[joint]
        return angles
    
    def update_link_lengths(self, L0: float, L1: float, L2: float, L3: float):
        """Update link lengths and recalculate workspace."""
        self.L0 = L0
        self.L1 = L1
        self.L2 = L2
        self.L3 = L3
        self._calculate_workspace()
    
    def update_coupling(self, ratio: float, offset: float = 0.0):
        """Update coupling parameters."""
        self.coupling_ratio = ratio
        self.coupling_offset = offset
    
    def update_gear_ratio(self, joint: str, ratio: float):
        """Update gear ratio for a specific joint."""
        if joint in self.gear_ratios:
            self.gear_ratios[joint] = ratio
    
    def __repr__(self):
        """String representation of robot configuration."""
        return f"""RobotConfig:
  Link Lengths: L0={self.L0}, L1={self.L1}, L2={self.L2}, L3={self.L3}
  Max Reach: {self.max_reach}mm
  Coupling: ratio={self.coupling_ratio}, offset={self.coupling_offset}
  Gear Ratios: {self.gear_ratios}
  Joint Limits: {self.joint_limits}
"""


# Global configuration instance
config = RobotConfig()

