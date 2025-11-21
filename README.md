# MrRoboto

Repository for developing a simple robot arm using stepper motors with a PIC18 microprocessor board.

## Project Overview

This project is based on the MicroprocessorsLab repository and extends it to control a robot arm using stepper motors. The codebase includes PIC18 assembly programs and documentation for interfacing with the EasyPIC Pro v7 development board.

### Control Architecture

The robot can be controlled in two modes:

1. **Direct Assembly Control**: Low-level motor control via PIC18 assembly (`motor_control.s`)
2. **Python IK Control**: High-level inverse kinematics with PySerial communication (`scripts/`)

The Python control system provides:
- Inverse kinematics solver for cylindrical coordinates (ρ, φ, z)
- Explicit modeling of shoulder-elbow mechanical coupling
- Serial communication protocol for PIC18 control
- 3D visualization and trajectory planning
- Interactive calibration wizard

**Quick Start (Python IK):**
```bash
cd scripts
pip install -r requirements.txt
python main_control.py --mock --interactive  # Test without hardware
```

See [scripts/README.md](scripts/README.md) for complete Python system documentation.

## Hardware Components

### Robot Arm Architecture
The robot arm consists of 6 stepper motors:
- **Base Motor**: Single motor for base rotation
- **Shoulder Motor**: Single motor for shoulder articulation
- **Elbow Motor**: Single motor for elbow articulation
- **Wrist Motors**: Two motors for wrist articulation (pitch and roll)
- **Claw Motor**: Single motor for claw actuation

### Stepper Motor
- **Model:** 9904 112 35014 (from 9904 112 35 series)
- **Specifications:**
  - Step angle: 7.5°
  - Holding torque: 8.5 Ncm (85 mNm)
  - Rotor inertia: 0.045 Kgcm²
  - Resistance per phase: 47Ω
  - Current per phase: 0.24A (240mA)
  - Inductance per phase: 400mH
  - Terminals: 6 terminals (unipolar/bipolar capable)
  - Weight: 300g
- **Driver:** L298N Motor Driver (currently using unipolar configuration)
- **Power Requirements:** External 8-12V power supply (2A+ recommended for multiple motors)

### Development Board
- **Model:** EasyPIC PRO v7
- **Microcontroller:** PIC18F87K22 (default)
- **Features:** 69 GPIO pins, 3.3V/5V operation, mikroBUS sockets
- **Documentation:** [EasyPIC PRO v7 Manual](docs/easypic-pro-v7-manual-v101.md)

### Motor Driver ICs
- **Model:** ULN2003A Darlington Transistor Array
- **Quantity:** 6 units (one per motor)
- **Current Rating:** 500mA per channel
- **Features:** Built-in flyback diodes for inductive loads
- **Documentation:** [ULN2003A Datasheet](docs/Uln2003a%20Darlington%20Transistor%20Array.md)

### Power Supply
- **External Motor Supply:** 8-12V DC, 2-3A regulated
- **Control Logic:** 5V from EasyPIC PRO v7
- **Note:** Motors require external power supply (EasyPIC board cannot power motors directly)

## Hardware Setup

**Complete wiring guide and assembly instructions:** [ULN2003A Hardware Setup Guide](docs/ULN2003A_Hardware_Setup.md)

This guide includes:
- ✅ Hardware compatibility verification
- 📋 Complete bill of materials
- 🔌 Detailed pin assignments and wiring diagrams
- 💻 Assembly code examples for motor control
- 🔧 Testing procedures and troubleshooting
- ⚡ Power supply requirements and safety guidelines

**Quick Start:**
1. Connect 6× ULN2003A ICs to breadboard
2. Wire EasyPIC GPIO pins to ULN2003A inputs
3. Connect external 8-12V supply to ULN2003A COM pins
4. Connect motors to ULN2003A outputs
5. Ensure common ground between all components
6. Program microcontroller with step sequence code

## Documentation

### Hardware Documentation
- **[ULN2003A Hardware Setup Guide](docs/ULN2003A_Hardware_Setup.md)** - Complete integration guide for motor setup
- **[ULN2003A Datasheet](docs/Uln2003a%20Darlington%20Transistor%20Array.md)** - Driver IC specifications
- **[EasyPIC PRO v7 Manual](docs/easypic-pro-v7-manual-v101.md)** - Development board manual
- **[330510 Motor Specifications](docs/330510%20Motor.md)** - Stepper motor datasheet (9904 112 series)
- **[Leadshine DM542 Stepper Driver](docs/Leadshine%20DM542%20Stepper%20Driver.md)** - Alternative driver documentation

### Software Documentation
- **[Motor Control Module](docs/Motor_Control_Module.md)** - Complete documentation for stepper motor control with L298N driver
- **[L298N Unipolar Wiring Guide](docs/L298N_Unipolar_Wiring.md)** - Hardware wiring and troubleshooting
- **[Assembly Programming Guide](docs/3_Assembly_2.md)** - PIC18 assembly language basics
- **[Electronics and DAC](docs/4_Electronics-DAC.md)** - Digital-to-analog conversion
- **[Serial and Parallel Communication](docs/5_Serial_Parallel.md)** - Communication protocols
- **[LCD Display Usage](docs/6_Using_the_LCD.md)** - Character LCD interfacing
- **[Keypad Interfacing](docs/7_Keypad.md)** - Matrix keypad integration
- **[ADC Devices](docs/8_Devices-ADC.md)** - Analog-to-digital conversion
- **[Timers and Interrupts](docs/9_Devices-Timers-Interrupts.md)** - Timer configuration and ISRs

## Development

The initial codebase is based on the master branch of MicroprocessorsLab. The main program (`main.s`) interfaces with stepper motor drivers for robot arm control.

### Current Implementation Status

**✅ Implemented:**
- Dual motor simultaneous control (Claw + Base motors)
- Independent Shoulder motor control (RE0-3)
- Independent Elbow motor control (RE4-7)
- Paired Wrist motor control (Pitch + Roll)
- Interleaved stepping for smooth coordinated motion
- Configurable step count via `BIDIR_TEST_STEPS` constant
- Independent step tracking for each motor unit
- Bidirectional test routine
- Sequential demo of all joints

**🔄 Future Expansion:**
- Complex motion sequences
- ~~Inverse kinematics~~ ✅ **Implemented in Python** (see `scripts/`)
- **Stuck Motor Detection**: Current monitoring system to detect when motors are stuck or overloaded
  - **Hardware**: Shunt resistor (e.g., 0.1Ω precision) placed in series with power supply return path. Voltage drop across shunt amplified via op-amp (LM358) or current-sense amplifier (INA180) to bring signal into ADC range (0-4.096V). Amplified signal fed to unused analog input (AN2 or AN3; AN0/AN1 reserved for joystick).
  - **Software**: Periodic ADC polling during motor operations. Compare reading against calibrated threshold. If current exceeds threshold (indicating stuck motor or overload), trigger emergency shutdown routine that immediately stops all motors and halts program execution.
  - **Design Considerations**: 
    - Shunt value: 0.1Ω provides ~0.2-0.3V drop at 2-3A, requiring ~10-15× amplification for full ADC range
    - Threshold calibration: Measure normal operating current (typically 1-2A for multiple motors) and set threshold at ~150-200% of normal (e.g., 2.5-3A)
    - Polling frequency: Check current every 10-50ms during active motor operations to catch spikes quickly
    - Low-side sensing (between load and ground) is simpler but loses ground reference; high-side sensing requires differential measurement

### Motor Control Architecture

The motor control system (`motor_control.s`) follows a scalable, debuggable pattern:

1. **Each motor unit has:**
   - Dedicated step index variable (e.g., `clawStepIndex`, `baseStepIndex`)
   - Individual forward/backward step functions (e.g., `Claw_StepForward`)
   - PORT assignment (E, F, G, or H)

2. **Interleaved operation:**
   - `Both_StepForward` and `Both_StepBackward` coordinate multiple motors
   - Single delay applied after all motors step
   - Creates smooth synchronized motion

3. **Easy configuration:**
   - Change `BIDIR_TEST_STEPS` constant to adjust rotation amount
   - Currently set to 0x120 (288 steps = 3 full rotations)

### Adding New Motor Units

To add Shoulder, Elbow, or Wrist motor control, follow the existing pattern in `motor_control.s`:

1. Add step index variable: `shoulderStepIndex EQU 0x12`
2. Create step functions: `Shoulder_StepForward`, `Shoulder_StepBackward`
3. Update `Motor_Init` to initialize the new motor
4. Output to appropriate PORT
5. Create/update interleaved functions as needed

This pattern keeps the code simple, maintainable, and easy to debug.

### Python Control System (Inverse Kinematics)

The `scripts/` directory contains a complete Python-based control system for high-level robot control:

**Architecture:**
```
Python (IK Solver + Control)  ←→  PySerial  ←→  PIC18 (Motor Control)
```

**Key Features:**
- **Inverse Kinematics**: Solve joint angles from cylindrical coordinates (ρ, φ, z)
- **Coupling Support**: Models shoulder-elbow mechanical coupling (scissor linkage)
- **Serial Protocol**: Command-based communication with PIC18
- **3D Visualization**: Real-time matplotlib visualization of robot pose
- **Calibration**: Interactive wizard for measuring robot parameters
- **Test Trajectories**: Circle, figure-eight, workspace boundary tests

**Quick Start:**
```bash
cd scripts
pip install -r requirements.txt

# Test without hardware
python main_control.py --mock --interactive

# With hardware (after calibration)
python main_control.py --calibrate              # First time
python main_control.py --load-calib calibration.json --test all
```

**Serial Communication Protocol:**

The Python system sends commands to the PIC18 via UART (9600 baud):
- `MOVE <θ1> <θ2> <θ3> <θ4>` - Move to joint angles
- `HOME` - Return to home position
- `STOP` - Emergency stop
- `STATUS` - Query current angles

The PIC18 assembly handler (`serial_handler.s`) receives commands and controls motors.

**Integration:**
1. Include `serial_handler.s` in PIC18 project
2. Call `UART_Init` in main initialization
3. Add `UART_RX_ISR` to interrupt service routine
4. Link serial commands to `motor_control.s` functions

See [scripts/README.md](scripts/README.md) for complete documentation.
