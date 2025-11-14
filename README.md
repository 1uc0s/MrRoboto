# MrRoboto

Repository for developing a simple robot arm using stepper motors with a PIC18 microprocessor board.

## Project Overview

This project is based on the MicroprocessorsLab repository and extends it to control a robot arm using stepper motors. The codebase includes PIC18 assembly programs and documentation for interfacing with the EasyPIC Pro v7 development board.

## Hardware Components

### Robot Arm Architecture
The robot arm consists of 6 stepper motors organized into 4 independently controllable motor units:
- **Claw Motor** (PORT E): Single motor for gripper control
- **Base Motor** (PORT F): Single motor for base rotation
- **Wrist Motors** (PORT G): Pair of motors moving together for wrist articulation
- **Elbow Motors** (PORT H): Pair of motors moving together for elbow articulation

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
- **Quantity:** 4 units (one per motor)
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
1. Connect 4× ULN2003A ICs to breadboard
2. Wire EasyPIC GPIO pins (PORTA-PORTD) to ULN2003A inputs
3. Connect external 8-12V supply to ULN2003A COM pins
4. Connect motors to ULN2003A outputs
5. Ensure common ground between all components
6. Program microcontroller with step sequence code

## Documentation

### Hardware Documentation
- **[ULN2003A Hardware Setup Guide](docs/ULN2003A_Hardware_Setup.md)** - Complete integration guide for 4-motor setup
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
- Interleaved stepping for smooth coordinated motion
- Configurable step count via `BIDIR_TEST_STEPS` constant
- Independent step tracking for each motor unit
- Bidirectional test routine

**🔄 Future Expansion:**
- Wrist motor pair control (PORT G)
- Elbow motor pair control (PORT H)
- Individual motor control functions
- Complex motion sequences

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

To add Wrist or Elbow motor control, follow the existing pattern in `motor_control.s`:

1. Add step index variable: `wristStepIndex EQU 0x12`
2. Create step functions: `Wrist_StepForward`, `Wrist_StepBackward`
3. Update `Motor_Init` to initialize the new motor
4. Output to appropriate PORT (G for Wrist, H for Elbow)
5. Create/update interleaved functions as needed

This pattern keeps the code simple, maintainable, and easy to debug.
