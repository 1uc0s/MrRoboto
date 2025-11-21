"""
Inverse Kinematics Solver for 4-DOF Planar Robot Arm
Solves IK with cylindrical coordinate input and shoulder-elbow coupling constraint.
"""

import numpy as np
from typing import Tuple, Dict, Optional
from robot_config import RobotConfig


class IKSolver:
    """Inverse kinematics solver for coupled 4-DOF planar robot arm."""
    
    def __init__(self, config: RobotConfig):
        """
        Initialize IK solver with robot configuration.
        
        Args:
            config: RobotConfig instance with robot parameters
        """
        self.config = config
        
    def solve(self, rho: float, phi: float, z: float, 
              desired_pitch: float = 0.0,
              elbow_up: bool = True) -> Tuple[bool, Optional[Dict[str, float]], str]:
        """
        Solve inverse kinematics for cylindrical coordinates.
        
        Args:
            rho: Radial distance from base axis (mm)
            phi: Azimuthal angle (degrees)
            z: Height above base (mm)
            desired_pitch: Desired end effector pitch angle (degrees)
            elbow_up: Prefer elbow-up configuration (vs elbow-down)
            
        Returns:
            (success, angles, message): 
                - success: Boolean indicating if solution found
                - angles: Dict with keys 'base', 'shoulder', 'elbow', 'wrist' (degrees)
                - message: Success/error message
        """
        # Step 1: Base angle (trivial in cylindrical coordinates)
        theta1 = phi
        
        # Step 2: Check reachability
        reachable, reason = self.config.is_position_reachable(rho, z)
        if not reachable:
            return False, None, f"Unreachable: {reason}"
        
        # Step 3: Solve planar 2-DOF problem with coupling constraint
        # The arm operates in the (rho, z) plane after base rotation
        # Shoulder is at height L0, we need to reach (rho, z)
        
        # Transform to shoulder frame
        z_rel = z - self.config.L0  # Height relative to shoulder
        
        # Distance from shoulder to target
        D = np.sqrt(rho**2 + z_rel**2)
        
        # With coupling, this is effectively a 1-DOF problem
        # We need to find theta2 such that the coupled system reaches (rho, z_rel)
        
        # For a coupled system where theta3 = coupling_ratio * theta2 + coupling_offset
        # We solve using forward kinematics and search/optimization
        
        if self.config.coupling_enabled:
            # Use numerical search to find theta2
            theta2, theta3 = self._solve_coupled_2dof(rho, z_rel, D, elbow_up)
            
            if theta2 is None:
                return False, None, "No valid solution with coupling constraints"
        else:
            # Standard 2R planar arm solution (uncoupled)
            success, theta2, theta3, msg = self._solve_2r_planar(rho, z_rel, D, elbow_up)
            if not success:
                return False, None, msg
        
        # Step 4: Wrist angle to maintain desired pitch
        # theta4 keeps end effector at desired orientation
        theta4 = desired_pitch - theta2 - theta3
        
        # Validate joint limits
        if not self._check_joint_limits(theta1, theta2, theta3, theta4):
            return False, None, "Solution violates joint limits"
        
        angles = {
            'base': theta1,
            'shoulder': theta2,
            'elbow': theta3,
            'wrist': theta4
        }
        
        return True, angles, "IK solution found"
    
    def _solve_2r_planar(self, x: float, y: float, D: float, 
                         elbow_up: bool) -> Tuple[bool, Optional[float], Optional[float], str]:
        """
        Solve standard 2R planar arm (uncoupled).
        
        Args:
            x: Horizontal distance (rho)
            y: Vertical distance (z relative to shoulder)
            D: Distance to target
            elbow_up: Prefer elbow-up configuration
            
        Returns:
            (success, theta2, theta3, message)
        """
        L1 = self.config.L1
        L2 = self.config.L2 + self.config.L3  # Effective length including wrist
        
        # Check triangle inequality
        if D > (L1 + L2):
            return False, None, None, f"Target too far: {D:.1f} > {L1+L2:.1f}"
        if D < abs(L1 - L2):
            return False, None, None, f"Target too close: {D:.1f} < {abs(L1-L2):.1f}"
        
        # Law of cosines for elbow angle
        cos_theta3 = (D**2 - L1**2 - L2**2) / (2 * L1 * L2)
        
        # Clamp to valid range (numerical errors)
        cos_theta3 = np.clip(cos_theta3, -1.0, 1.0)
        
        # Two solutions: elbow up (positive) or elbow down (negative)
        if elbow_up:
            theta3 = np.arccos(cos_theta3)
        else:
            theta3 = -np.arccos(cos_theta3)
        
        # Shoulder angle using atan2
        alpha = np.arctan2(y, x)
        beta = np.arctan2(L2 * np.sin(theta3), L1 + L2 * np.cos(theta3))
        theta2 = alpha - beta
        
        # Convert to degrees
        theta2_deg = np.degrees(theta2)
        theta3_deg = np.degrees(theta3)
        
        return True, theta2_deg, theta3_deg, "2R solution found"
    
    def _solve_coupled_2dof(self, x: float, y: float, D: float,  # pylint: disable=unused-argument
                            elbow_up: bool) -> Tuple[Optional[float], Optional[float]]:  # pylint: disable=unused-argument
        """
        Solve 2-DOF problem with shoulder-elbow coupling.
        
        Uses forward kinematics search to find theta2 that reaches target.
        
        Args:
            x: Horizontal distance (rho)
            y: Vertical distance (z relative to shoulder)
            D: Distance to target
            elbow_up: Prefer elbow-up configuration
            
        Returns:
            (theta2, theta3): Joint angles in degrees, or (None, None) if no solution
        """
        L1 = self.config.L1
        L2 = self.config.L2
        L3 = self.config.L3
        
        min_theta2, max_theta2 = self.config.joint_limits['shoulder']
        
        # Search over valid theta2 range
        theta2_range = np.linspace(min_theta2, max_theta2, 200)
        
        best_error = float('inf')
        best_theta2 = None
        best_theta3 = None
        
        for theta2_deg in theta2_range:
            # Get coupled theta3
            theta3_deg = self.config.apply_coupling(theta2_deg)
            
            # Check if theta3 is within limits
            min_theta3, max_theta3 = self.config.joint_limits['elbow']
            if not (min_theta3 <= theta3_deg <= max_theta3):
                continue
            
            # Forward kinematics to find end effector position
            theta2 = np.radians(theta2_deg)
            theta3 = np.radians(theta3_deg)
            
            # Shoulder to elbow
            x1 = L1 * np.cos(theta2)
            y1 = L1 * np.sin(theta2)
            
            # Elbow to wrist (theta3 is relative to horizontal)
            x2 = x1 + L2 * np.cos(theta2 + theta3)
            y2 = y1 + L2 * np.sin(theta2 + theta3)
            
            # Wrist to end effector (assuming wrist maintains direction)
            x3 = x2 + L3 * np.cos(theta2 + theta3)
            y3 = y2 + L3 * np.sin(theta2 + theta3)
            
            # Error from target
            error = np.sqrt((x3 - x)**2 + (y3 - y)**2)
            
            if error < best_error:
                best_error = error
                best_theta2 = theta2_deg
                best_theta3 = theta3_deg
        
        # Accept solution if error is small enough (< 1mm)
        if best_error < 1.0:
            return best_theta2, best_theta3
        else:
            return None, None
    
    def _check_joint_limits(self, theta1: float, theta2: float, 
                           theta3: float, theta4: float) -> bool:
        """
        Check if all joint angles are within limits.
        
        Args:
            theta1, theta2, theta3, theta4: Joint angles in degrees
            
        Returns:
            True if all angles within limits
        """
        joints = [
            ('base', theta1),
            ('shoulder', theta2),
            ('elbow', theta3),
            ('wrist', theta4)
        ]
        
        for name, angle in joints:
            min_angle, max_angle = self.config.joint_limits[name]
            if not (min_angle <= angle <= max_angle):
                return False
        
        return True
    
    def forward_kinematics(self, theta1: float, theta2: float, 
                          theta3: float, theta4: float) -> Tuple[float, float, float]:  # pylint: disable=unused-argument
        """
        Compute forward kinematics: joint angles → end effector position.
        
        Args:
            theta1, theta2, theta3, theta4: Joint angles in degrees
            
        Returns:
            (rho, phi, z): Cylindrical coordinates (mm, degrees, mm)
        """
        # Convert to radians
        t2 = np.radians(theta2)
        t3 = np.radians(theta3)
        
        L0, L1, L2, L3 = self.config.L0, self.config.L1, self.config.L2, self.config.L3
        
        # Position in shoulder frame (rho-z plane)
        # Shoulder to elbow
        x1 = L1 * np.cos(t2)
        z1 = L1 * np.sin(t2)
        
        # Elbow to wrist
        x2 = x1 + L2 * np.cos(t2 + t3)
        z2 = z1 + L2 * np.sin(t2 + t3)
        
        # Wrist to end effector
        x3 = x2 + L3 * np.cos(t2 + t3)
        z3 = z2 + L3 * np.sin(t2 + t3)
        
        # Convert to cylindrical coordinates
        rho = x3
        phi = theta1  # Base rotation
        z = L0 + z3   # Add base height
        
        return rho, phi, z
    
    def validate_coupling(self, theta2: float, theta3: float, 
                         tolerance: float = 1.0) -> Tuple[bool, float]:
        """
        Check if theta2 and theta3 satisfy coupling constraint.
        
        Args:
            theta2: Shoulder angle (degrees)
            theta3: Elbow angle (degrees)
            tolerance: Acceptable error (degrees)
            
        Returns:
            (valid, error): Boolean and error magnitude
        """
        if not self.config.coupling_enabled:
            return True, 0.0
        
        expected_theta3 = self.config.apply_coupling(theta2)
        error = abs(theta3 - expected_theta3)
        valid = error <= tolerance
        
        return valid, error


# Convenience function
def solve_ik(rho: float, phi: float, z: float, 
            config: RobotConfig,
            desired_pitch: float = 0.0) -> Tuple[bool, Optional[Dict[str, float]], str]:
    """
    Convenience function to solve IK.
    
    Args:
        rho: Radial distance (mm)
        phi: Azimuthal angle (degrees)
        z: Height (mm)
        config: Robot configuration
        desired_pitch: End effector pitch (degrees)
        
    Returns:
        (success, angles, message)
    """
    solver = IKSolver(config)
    return solver.solve(rho, phi, z, desired_pitch)

