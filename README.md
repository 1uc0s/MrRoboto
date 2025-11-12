# MrRoboto

Repository for developing a simple robot arm using stepper motors with a PIC18 microprocessor board.

## Project Overview

This project is based on the MicroprocessorsLab repository and extends it to control a robot arm using stepper motors. The codebase includes PIC18 assembly programs and documentation for interfacing with the EasyPIC Pro v7 development board.

## Hardware Components

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
- **Driver:** ULN2003A Darlington Array (4 motors × 4 ULN2003A modules)
- **Power Requirements:** External 8-12V power supply (1.5A+ recommended)

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
- **[Assembly Programming Guide](docs/3_Assembly_2.md)** - PIC18 assembly language basics
- **[Electronics and DAC](docs/4_Electronics-DAC.md)** - Digital-to-analog conversion
- **[Serial and Parallel Communication](docs/5_Serial_Parallel.md)** - Communication protocols
- **[LCD Display Usage](docs/6_Using_the_LCD.md)** - Character LCD interfacing
- **[Keypad Interfacing](docs/7_Keypad.md)** - Matrix keypad integration
- **[ADC Devices](docs/8_Devices-ADC.md)** - Analog-to-digital conversion
- **[Timers and Interrupts](docs/9_Devices-Timers-Interrupts.md)** - Timer configuration and ISRs

## Development

The initial codebase is based on the master branch of MicroprocessorsLab. The main program (`main.s`) will be modified to interface with stepper motor drivers for robot arm control.
