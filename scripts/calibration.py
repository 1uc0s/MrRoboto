"""
Calibration Tools for Robot Arm
Interactive wizard for measuring link lengths, gear ratios, and coupling parameters.
"""

import time
import json
from typing import Optional
import numpy as np
from robot_config import RobotConfig
from serial_interface import SerialInterface, MockSerialInterface


class CalibrationWizard:
    """Interactive calibration wizard for robot parameters."""
    
    def __init__(self, robot_config: RobotConfig, serial: SerialInterface):
        """
        Initialize calibration wizard.
        
        Args:
            robot_config: RobotConfig instance to update
            serial: SerialInterface for robot control
        """
        self.config = robot_config
        self.serial = serial
        self.measurements = {}
    
    def run_full_calibration(self):
        """Run complete calibration procedure."""
        print("=" * 60)
        print("Robot Arm Calibration Wizard")
        print("=" * 60)
        print()
        
        # Check connection
        if not self.serial.connected:
            print("ERROR: Not connected to robot. Connect first.")
            return False
        
        # Step 1: Home robot
        print("Step 1: Homing Robot")
        print("-" * 60)
        if not self._home_robot():
            return False
        
        # Step 2: Measure link lengths
        print("\nStep 2: Measure Link Lengths")
        print("-" * 60)
        self._measure_link_lengths()
        
        # Step 3: Calibrate gear ratios
        print("\nStep 3: Calibrate Gear Ratios")
        print("-" * 60)
        self._calibrate_gear_ratios()
        
        # Step 4: Measure coupling relationship
        print("\nStep 4: Measure Shoulder-Elbow Coupling")
        print("-" * 60)
        self._calibrate_coupling()
        
        # Step 5: Determine joint limits
        print("\nStep 5: Determine Joint Limits")
        print("-" * 60)
        self._measure_joint_limits()
        
        # Step 6: Save calibration
        print("\nStep 6: Save Calibration Data")
        print("-" * 60)
        self._save_calibration()
        
        print("\n" + "=" * 60)
        print("Calibration Complete!")
        print("=" * 60)
        print()
        print("Updated Configuration:")
        print(self.config)
        
        return True
    
    def _home_robot(self) -> bool:
        """Home robot to reference position."""
        print("Moving robot to home position (all motors at limits)...")
        print("This may take 20-30 seconds.")
        
        success = self.serial.home(wait_completion=True)
        
        if success:
            print("✓ Homing complete")
            return True
        else:
            print("✗ Homing failed")
            return False
    
    def _measure_link_lengths(self):
        """Guide user through measuring link lengths."""
        print("\nYou will need a ruler or measuring tape (mm).")
        print("\nMeasure the following distances:")
        print()
        
        # L0: Base height
        print("L0 - Base Height:")
        print("  Measure from ground/base to shoulder pivot point")
        L0 = self._get_float_input("  L0 (mm)", default=self.config.L0)
        self.measurements['L0'] = L0
        
        # L1: Upper arm
        print("\nL1 - Upper Arm Length:")
        print("  Measure from shoulder pivot to elbow pivot")
        L1 = self._get_float_input("  L1 (mm)", default=self.config.L1)
        self.measurements['L1'] = L1
        
        # L2: Forearm
        print("\nL2 - Forearm Length:")
        print("  Measure from elbow pivot to wrist pivot")
        L2 = self._get_float_input("  L2 (mm)", default=self.config.L2)
        self.measurements['L2'] = L2
        
        # L3: End effector
        print("\nL3 - End Effector Length:")
        print("  Measure from wrist pivot to gripper center/reference point")
        L3 = self._get_float_input("  L3 (mm)", default=self.config.L3)
        self.measurements['L3'] = L3
        
        # Update config
        self.config.update_link_lengths(L0, L1, L2, L3)
        
        print("\n✓ Link lengths recorded")
        print(f"  L0={L0}mm, L1={L1}mm, L2={L2}mm, L3={L3}mm")
        print(f"  Maximum reach: {self.config.max_reach:.1f}mm")
    
    def _calibrate_gear_ratios(self):
        """Calibrate gear ratios by measuring actual joint rotation."""
        print("\nCalibrating gear ratios...")
        print("For each joint, we will:")
        print("  1. Command a specific number of motor steps")
        print("  2. You measure the actual joint rotation in degrees")
        print("  3. Calculate steps-per-degree ratio")
        print()
        
        joints = ['base', 'shoulder', 'elbow', 'wrist']
        test_steps = 480  # 10 full motor rotations (48 steps each)
        
        for joint in joints:
            print(f"\nCalibrating {joint.upper()} joint:")
            print(f"  Will command {test_steps} motor steps")
            
            input(f"  Press Enter to move {joint}...")
            
            # Move joint
            self.serial.calibrate_joint(joint, test_steps)
            
            print(f"  Joint should have moved.")
            measured_degrees = self._get_float_input(
                f"  How many degrees did {joint} rotate? (estimate)", 
                default=test_steps * 360.0 / 48.0  # Assume no gearhead initially
            )
            
            # Calculate ratio
            if measured_degrees != 0:
                ratio = test_steps / measured_degrees
                self.measurements[f'{joint}_gear_ratio'] = ratio
                self.config.update_gear_ratio(joint, ratio)
                
                # Calculate gear reduction
                motor_steps_per_rev = 48
                joint_rotations = measured_degrees / 360.0
                motor_rotations = test_steps / motor_steps_per_rev
                gear_reduction = motor_rotations / joint_rotations if joint_rotations > 0 else 1.0
                
                print(f"  ✓ Gear ratio: {ratio:.4f} steps/degree")
                print(f"    Gear reduction: {gear_reduction:.2f}:1")
            
            # Return to home
            print("  Returning to home...")
            self.serial.home(wait_completion=True)
            time.sleep(1)
        
        print("\n✓ Gear ratios calibrated")
    
    def _calibrate_coupling(self):
        """Measure shoulder-elbow coupling relationship."""
        print("\nMeasuring shoulder-elbow coupling...")
        print("\nThe shoulder and elbow are mechanically coupled.")
        print("We will move the shoulder and measure corresponding elbow movement.")
        print()
        
        # Collect multiple data points
        shoulder_angles = []
        elbow_angles = []
        
        num_samples = 5
        print(f"Will collect {num_samples} measurement points.")
        print()
        
        for i in range(num_samples):
            print(f"\nMeasurement {i+1}/{num_samples}:")
            
            # Command shoulder angle
            test_angle = i * 30.0  # 0, 30, 60, 90, 120 degrees
            print(f"  Moving shoulder to approximately {test_angle}°...")
            
            # Calculate steps
            steps = int(test_angle * self.config.gear_ratios['shoulder'])
            self.serial.calibrate_joint('shoulder', steps)
            
            time.sleep(2)  # Let it settle
            
            # Measure actual angles
            shoulder_actual = self._get_float_input(
                "  Measure actual shoulder angle (degrees from home)",
                default=test_angle
            )
            elbow_actual = self._get_float_input(
                "  Measure corresponding elbow angle (degrees from home)",
                default=test_angle
            )
            
            shoulder_angles.append(shoulder_actual)
            elbow_angles.append(elbow_actual)
            
            print(f"  Recorded: shoulder={shoulder_actual}°, elbow={elbow_actual}°")
        
        # Return home
        print("\n  Returning to home...")
        self.serial.home(wait_completion=True)
        
        # Fit linear relationship: elbow = ratio * shoulder + offset
        if len(shoulder_angles) >= 2:
            coeffs = np.polyfit(shoulder_angles, elbow_angles, 1)
            ratio = coeffs[0]
            offset = coeffs[1]
            
            self.measurements['coupling_ratio'] = ratio
            self.measurements['coupling_offset'] = offset
            self.config.update_coupling(ratio, offset)
            
            print(f"\n✓ Coupling calibrated:")
            print(f"  theta3 = {ratio:.3f} * theta2 + {offset:.3f}")
            
            # Show fit quality
            predicted = np.array(shoulder_angles) * ratio + offset
            errors = np.array(elbow_angles) - predicted
            rms_error = np.sqrt(np.mean(errors**2))
            print(f"  RMS error: {rms_error:.2f}°")
        else:
            print("  ✗ Not enough data points for fitting")
    
    def _measure_joint_limits(self):
        """Determine safe joint angle limits."""
        print("\nDetermining joint limits...")
        print("For each joint, we'll find the safe range of motion from home position.")
        print()
        
        joints = ['base', 'shoulder', 'elbow', 'wrist']
        
        for joint in joints:
            print(f"\n{joint.upper()} joint limits:")
            
            # Minimum angle (negative from home)
            min_angle = self._get_float_input(
                f"  Minimum {joint} angle from home (negative/CCW, degrees)",
                default=self.config.joint_limits[joint][0]
            )
            
            # Maximum angle (positive from home)
            max_angle = self._get_float_input(
                f"  Maximum {joint} angle from home (positive/CW, degrees)",
                default=self.config.joint_limits[joint][1]
            )
            
            self.config.joint_limits[joint] = (min_angle, max_angle)
            self.measurements[f'{joint}_limit_min'] = min_angle
            self.measurements[f'{joint}_limit_max'] = max_angle
            
            print(f"  ✓ {joint}: [{min_angle:.1f}°, {max_angle:.1f}°]")
        
        print("\n✓ Joint limits recorded")
    
    def _save_calibration(self):
        """Save calibration data to file."""
        filename = input("\nSave calibration to file (default: calibration.json): ").strip()
        if not filename:
            filename = "calibration.json"
        
        if not filename.endswith('.json'):
            filename += '.json'
        
        # Prepare calibration data
        calib_data = {
            'timestamp': time.strftime('%Y-%m-%d %H:%M:%S'),
            'link_lengths': {
                'L0': self.config.L0,
                'L1': self.config.L1,
                'L2': self.config.L2,
                'L3': self.config.L3
            },
            'gear_ratios': self.config.gear_ratios,
            'joint_limits': self.config.joint_limits,
            'coupling': {
                'enabled': self.config.coupling_enabled,
                'ratio': self.config.coupling_ratio,
                'offset': self.config.coupling_offset
            },
            'workspace': {
                'max_reach': self.config.max_reach,
                'min_reach': self.config.min_reach,
                'z_min': self.config.workspace_z_min,
                'z_max': self.config.workspace_z_max
            },
            'raw_measurements': self.measurements
        }
        
        # Save to file
        try:
            with open(filename, 'w', encoding='utf-8') as f:
                json.dump(calib_data, f, indent=2)
            print(f"✓ Calibration saved to {filename}")
        except IOError as e:
            print(f"✗ Failed to save: {e}")
    
    def load_calibration(self, filename: str) -> bool:
        """
        Load calibration from file.
        
        Args:
            filename: Path to calibration JSON file
            
        Returns:
            True if successful
        """
        try:
            with open(filename, 'r', encoding='utf-8') as f:
                calib_data = json.load(f)
            
            # Update config
            if 'link_lengths' in calib_data:
                L = calib_data['link_lengths']
                self.config.update_link_lengths(L['L0'], L['L1'], L['L2'], L['L3'])
            
            if 'gear_ratios' in calib_data:
                for joint, ratio in calib_data['gear_ratios'].items():
                    self.config.update_gear_ratio(joint, ratio)
            
            if 'joint_limits' in calib_data:
                for joint, limits in calib_data['joint_limits'].items():
                    self.config.joint_limits[joint] = tuple(limits)
            
            if 'coupling' in calib_data:
                c = calib_data['coupling']
                self.config.update_coupling(c['ratio'], c['offset'])
                self.config.coupling_enabled = c['enabled']
            
            print(f"✓ Calibration loaded from {filename}")
            timestamp = calib_data.get('timestamp', 'unknown')
            print(f"  Calibrated on: {timestamp}")
            return True
            
        except (IOError, json.JSONDecodeError) as e:
            print(f"✗ Failed to load calibration: {e}")
            return False
    
    def _get_float_input(self, prompt: str, default: Optional[float] = None) -> float:
        """
        Get float input from user with default.
        
        Args:
            prompt: Input prompt
            default: Default value if user presses Enter
            
        Returns:
            User input as float
        """
        while True:
            try:
                if default is not None:
                    user_input = input(f"{prompt} [{default:.2f}]: ").strip()
                else:
                    user_input = input(f"{prompt}: ").strip()
                
                if not user_input and default is not None:
                    return default
                
                value = float(user_input)
                return value
                
            except ValueError:
                print("  Invalid input. Please enter a number.")


def quick_calibration(robot_config: RobotConfig) -> RobotConfig:
    """
    Quick manual calibration without hardware.
    
    Args:
        robot_config: RobotConfig to update
        
    Returns:
        Updated config
    """
    print("Quick Manual Calibration")
    print("=" * 60)
    
    # Just get link lengths
    print("\nEnter link lengths (mm):")
    L0 = float(input("  L0 (base height) [100]: ") or 100)
    L1 = float(input("  L1 (upper arm) [150]: ") or 150)
    L2 = float(input("  L2 (forearm) [120]: ") or 120)
    L3 = float(input("  L3 (end effector) [80]: ") or 80)
    
    robot_config.update_link_lengths(L0, L1, L2, L3)
    
    print("\nEnter coupling parameters:")
    ratio = float(input("  Coupling ratio [1.0]: ") or 1.0)
    offset = float(input("  Coupling offset [0.0]: ") or 0.0)
    
    robot_config.update_coupling(ratio, offset)
    
    print("\n✓ Quick calibration complete")
    print(robot_config)
    
    return robot_config


if __name__ == '__main__':
    from robot_config import config
    
    # Demo: quick calibration without hardware
    print("Running quick calibration demo (no hardware required)")
    print()
    quick_calibration(config)

