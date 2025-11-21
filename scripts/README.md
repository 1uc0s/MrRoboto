# Robot Arm Python Control System

Python-based inverse kinematics solver and control system for the 4-DOF robot arm with PySerial communication to the PIC18 microcontroller.

## Overview

This system provides:
- **Inverse Kinematics**: Solve joint angles for cylindrical coordinates (ρ, φ, z)
- **Coupling Support**: Explicit modeling of shoulder-elbow mechanical coupling
- **Serial Communication**: Command protocol for PIC18 control
- **3D Visualization**: Real-time visualization of robot pose and workspace
- **Calibration Tools**: Interactive wizard for measuring robot parameters
- **Test Trajectories**: Pre-defined motion patterns for validation

## Installation

### Requirements

Python 3.8+ with the following packages:

```bash
pip install -r requirements.txt
```

Or manually:
```bash
pip install numpy>=1.24.0 matplotlib>=3.7.0 pyserial>=3.5 sympy>=1.12
```

### Hardware Setup

1. Connect PIC18 EasyPIC board to computer via USB-to-Serial adapter
2. Note the serial port (e.g., `/dev/tty.usbserial-0001` on macOS, `COM3` on Windows)
3. Update port in `robot_config.py` or pass as command-line argument

## Quick Start

### 1. Test Without Hardware (Mock Mode)

Run with mock serial interface to test IK solver and visualization:

```bash
python main_control.py --mock --interactive
```

This starts interactive mode where you can enter commands like:
```
robot> move 200 0 200     # Move to (ρ=200mm, φ=0°, z=200mm)
robot> test circle        # Run circular trajectory test
robot> test eight         # Run figure-eight test
robot> home               # Return to home position
robot> quit               # Exit
```

### 2. Calibrate Robot (With Hardware)

First time setup - measure robot parameters:

```bash
python main_control.py --calibrate
```

This launches an interactive wizard that guides you through:
- Measuring link lengths (L0, L1, L2, L3)
- Calibrating gear ratios
- Measuring shoulder-elbow coupling relationship
- Determining joint angle limits

Calibration data is saved to `calibration.json`.

### 3. Run Tests (With Hardware)

After calibration, test the robot:

```bash
# Run all tests
python main_control.py --load-calib calibration.json --test all

# Run specific test
python main_control.py --load-calib calibration.json --test circle
```

Available tests:
- `point` - Point-to-point movements
- `circle` - Circular trajectory in XY plane
- `eight` - Figure-eight pattern
- `boundary` - Workspace boundary exploration
- `all` - Complete test suite

### 4. Interactive Control (With Hardware)

Real-time control:

```bash
python main_control.py --load-calib calibration.json --interactive
```

## Module Documentation

### `robot_config.py`

Configuration class containing all robot parameters:
- Link lengths (L0-L3)
- Gear ratios (steps per degree)
- Joint limits
- Coupling parameters
- Workspace boundaries
- Serial port settings

**Key Methods:**
- `apply_coupling(theta2)` - Calculate coupled elbow angle
- `is_position_reachable(rho, z)` - Check if position is within workspace
- `angles_to_steps(angles)` - Convert angles to motor steps
- `update_link_lengths(L0, L1, L2, L3)` - Update and recalculate workspace

### `ik_solver.py`

Inverse kinematics solver with coupling constraint.

**Key Class: `IKSolver`**

```python
solver = IKSolver(config)
success, angles, message = solver.solve(rho, phi, z, desired_pitch=0.0)

if success:
    print(f"Joint angles: {angles}")
    # angles = {'base': θ1, 'shoulder': θ2, 'elbow': θ3, 'wrist': θ4}
```

**Algorithm:**
1. Base angle: θ₁ = φ (direct from cylindrical coordinates)
2. Planar 2-DOF problem with coupling constraint (numerical search)
3. Wrist angle: θ₄ = desired_pitch - θ₂ - θ₃

**Methods:**
- `solve(rho, phi, z, desired_pitch)` - Main IK solver
- `forward_kinematics(theta1, theta2, theta3, theta4)` - FK for verification
- `validate_coupling(theta2, theta3)` - Check coupling constraint

### `serial_interface.py`

PySerial communication with PIC18 microcontroller.

**Key Class: `SerialInterface`**

```python
from robot_config import config
from serial_interface import SerialInterface

serial = SerialInterface(config, debug=True)
serial.connect()

# Send commands
angles = {'base': 0, 'shoulder': 30, 'elbow': 30, 'wrist': 0}
serial.move_to_angles(angles, wait_completion=True)

serial.home()
status = serial.get_status()
serial.disconnect()
```

**Protocol Commands:**
- `MOVE <θ1> <θ2> <θ3> <θ4>` - Move to joint angles (degrees)
- `STEP <s1> <s2> <s3> <s4>` - Move by step counts
- `HOME` - Move to home position
- `STOP` - Emergency stop
- `STATUS` - Query current angles
- `SPEED <value>` - Set motor speed
- `CAL <joint> <steps>` - Single joint movement for calibration

**Mock Interface:**

For testing without hardware:
```python
from serial_interface import MockSerialInterface
serial = MockSerialInterface(config, debug=True)
```

### `visualizer.py`

3D visualization using matplotlib.

**Key Class: `RobotVisualizer`**

```python
from robot_config import config
from visualizer import RobotVisualizer
import matplotlib.pyplot as plt

viz = RobotVisualizer(config)

# Update pose
angles = {'base': 45, 'shoulder': 30, 'elbow': 30, 'wrist': 0}
viz.update_pose(angles)

# Set target
viz.set_target(rho=200, phi=45, z=250)

# Show
viz.show()
```

**Features:**
- 3D view with arm segments colored by link
- Top-down view for workspace visualization
- Workspace boundary cylinders
- Target position markers
- Real-time updates

### `calibration.py`

Interactive calibration wizard.

**Key Class: `CalibrationWizard`**

```python
from robot_config import config
from serial_interface import SerialInterface
from calibration import CalibrationWizard

serial = SerialInterface(config)
serial.connect()

wizard = CalibrationWizard(config, serial)
wizard.run_full_calibration()  # Interactive wizard

# Save/load
wizard._save_calibration()  # Saves to calibration.json
wizard.load_calibration('calibration.json')
```

**Calibration Steps:**
1. Home robot to reference position
2. Measure link lengths with ruler
3. Calibrate gear ratios by moving and measuring
4. Measure coupling relationship (5 data points)
5. Determine joint angle limits
6. Save calibration data

### `main_control.py`

Main control loop integrating all modules.

**Key Class: `RobotController`**

```python
from robot_config import config
from main_control import RobotController

controller = RobotController(config, use_mock=False, visualize=True)
controller.connect()
controller.home()

# Move to position
controller.move_to_position(rho=200, phi=45, z=250)

# Execute trajectory
waypoints = [(200, 0, 200), (200, 90, 200), (200, 180, 200)]
controller.execute_trajectory(waypoints, delay=1.0)

controller.disconnect()
```

**Command-Line Interface:**

```bash
# Show help
python main_control.py --help

# Common options
--mock              # Use mock serial (no hardware)
--no-viz            # Disable visualization
--debug             # Enable debug output
--calibrate         # Run calibration wizard
--load-calib FILE   # Load calibration from file
--test TEST         # Run test (point|circle|eight|boundary|all)
--interactive       # Interactive control mode
```

## Coordinate System

**Cylindrical Coordinates (Input):**
- **ρ (rho)**: Radial distance from base axis (mm)
- **φ (phi)**: Azimuthal angle, 0° = forward, positive = counter-clockwise (degrees)
- **z**: Height above base (mm)

**Joint Angles (Output):**
- **θ₁ (base)**: Base rotation, matches φ
- **θ₂ (shoulder)**: Shoulder pitch, 0° = arm up (home)
- **θ₃ (elbow)**: Elbow pitch, coupled to θ₂
- **θ₄ (wrist)**: Wrist pitch for end effector orientation

**Coupling Relationship:**
```
θ₃ = coupling_ratio × θ₂ + coupling_offset
```

For scissor-like mechanism, typically `coupling_ratio ≈ 1.0` (1:1 coupling).

## Architecture

```
User Input (ρ, φ, z)
    ↓
IK Solver (Python)
    ↓
Joint Angles (θ₁, θ₂, θ₃, θ₄)
    ↓
Serial Interface (PySerial)
    ↓
UART Commands
    ↓
PIC18 Serial Handler (Assembly)
    ↓
Motor Control (Assembly)
    ↓
Stepper Motors
```

## Troubleshooting

### Serial Connection Issues

**Problem:** Cannot connect to serial port

**Solutions:**
1. Check port name: `ls /dev/tty.*` (macOS/Linux) or Device Manager (Windows)
2. Update port in `robot_config.py`: `config.serial_config['port'] = '/dev/tty.usbserial-XXX'`
3. Check permissions: `sudo chmod 666 /dev/tty.usbserial-XXX`
4. Try different baud rate: `config.serial_config['baudrate'] = 19200`

### IK Solver Failures

**Problem:** "Unreachable" or "No valid solution"

**Solutions:**
1. Check if target is within workspace: `config.is_position_reachable(rho, z)`
2. Verify link lengths are correct: `print(config)`
3. Try position closer to center of workspace
4. Check coupling parameters are calibrated

### Visualization Issues

**Problem:** Arm looks wrong in visualization

**Solutions:**
1. Verify link lengths in `robot_config.py`
2. Check joint angle signs (may need to negate)
3. Update forward kinematics in `visualizer.py` if DH convention differs

### Motor Movement Issues

**Problem:** Motors don't move or move incorrectly

**Solutions:**
1. Check gear ratios are calibrated: `print(config.gear_ratios)`
2. Verify coupling relationship: `print(config.coupling_ratio, config.coupling_offset)`
3. Check joint limits: `print(config.joint_limits)`
4. Test single joint with CAL command: `serial.calibrate_joint('shoulder', 100)`

## Examples

### Example 1: Simple Movement

```python
from robot_config import config
from main_control import RobotController

# Initialize
controller = RobotController(config, use_mock=True, visualize=True)
controller.connect()
controller.home()

# Move to position
controller.move_to_position(rho=200, phi=0, z=200)
time.sleep(2)

# Move to another position
controller.move_to_position(rho=180, phi=45, z=250)

# Clean up
controller.disconnect()
```

### Example 2: Custom Trajectory

```python
import numpy as np

# Create spiral trajectory
num_points = 20
radii = np.linspace(150, 250, num_points)
angles = np.linspace(0, 720, num_points)  # Two full rotations
heights = np.linspace(150, 300, num_points)

waypoints = [(r, phi, z) for r, phi, z in zip(radii, angles, heights)]

# Execute
controller.execute_trajectory(waypoints, delay=0.5)
```

### Example 3: IK Solver Only

```python
from robot_config import config
from ik_solver import IKSolver

solver = IKSolver(config)

# Solve for multiple positions
positions = [(200, 0, 200), (150, 90, 250), (180, -45, 180)]

for rho, phi, z in positions:
    success, angles, msg = solver.solve(rho, phi, z)
    
    if success:
        print(f"Position ({rho}, {phi}°, {z}): {angles}")
    else:
        print(f"Failed: {msg}")
```

## File Structure

```
scripts/
├── requirements.txt         # Python dependencies
├── README.md               # This file
├── robot_config.py         # Robot parameters and configuration
├── ik_solver.py            # Inverse kinematics solver
├── serial_interface.py     # PySerial communication
├── visualizer.py           # 3D matplotlib visualization
├── calibration.py          # Calibration wizard
├── main_control.py         # Main control loop
└── calibration.json        # Saved calibration data (generated)
```

## Integration with PIC18

The Python system communicates with the PIC18 microcontroller via the serial protocol. The PIC18 side must implement:

1. **UART initialization** at 9600 baud
2. **Serial receive interrupt handler**
3. **Command parser** for protocol commands
4. **Motor control integration** with `motor_control.s`

See `../serial_handler.s` for the PIC18 assembly implementation.

## Future Enhancements

- [ ] Trajectory planning with velocity/acceleration limits
- [ ] Collision detection with workspace obstacles
- [ ] Real-time position feedback from encoders
- [ ] GUI interface with sliders and buttons
- [ ] Record and playback motion sequences
- [ ] Integration with camera for visual servoing
- [ ] Path optimization for minimum jerk
- [ ] Force feedback for compliant control

## References

- Project proposal: `../../MicroLabWriteups/ProjectProposal/proposal_outline.pdf`
- Motor control module: `../motor_control.s`
- Hardware setup: `../docs/ULN2003A_Hardware_Setup.md`
- IK plan: `../docs/Inverse_Kinematics_Plan.md`

## License

Part of the MrRoboto project for Imperial College London Year 3 Microprocessors Lab.

