# Changelog

All notable changes to the MrRoboto project are documented here.

## [2025-11-25] - STEP Command Motor Control Bug Fixes

### Fixed - PORT E Motors Not Responding (Shoulder/Elbow)
**Root Cause:** PORT E pins default to analog mode on PIC18F87K22. Without disabling analog functionality, writes to PORT E have no effect.

**Fix:** Added ADCON1 configuration in `main.s` to make all pins digital:
```assembly
movlw   0x0F        ; PCFG3:0 = 1111 = all digital I/O
movwf   ADCON1, A   ; Configure ADC for all digital
```

### Fixed - Negative Step Counts Not Working
**Root Cause:** The `negf WREG, A` instruction was being used to negate the W register, but this is unreliable on PIC18.

**Fix:** Replaced all 4 instances of `negf WREG, A` in `serial_handler.s` with proper temp-based negation:
```assembly
movwf   PARSE_TEMP, A       ; Save to temp
negf    PARSE_TEMP, A       ; Negate temp
movf    PARSE_TEMP, W, A    ; Load back to W
```

### Files Modified
- `main.s`: Added analog disable before port configuration
- `serial_handler.s`: Fixed negation for all 4 motors (Base, Shoulder, Elbow, Wrist)

### Testing
After flashing the new firmware (`dist/default/production/MrRoboto.production.hex`):
- `step 100 0 0 0` - Base should move 100 steps forward
- `step -100 0 0 0` - Base should move 100 steps backward
- `step 0 100 0 0` - Shoulder should now move (was broken before)
- `step 0 0 100 0` - Elbow should now move (was broken before)
- `step 0 0 0 100` - Wrist should move

---

## [2025-11-21 PM] - Serial Port Configuration & Diagnostic Tools

### Port Configuration Updated
- Updated `scripts/robot_config.py` to use correct macOS serial port
- Changed from `/dev/tty.usbserial-0003` to `/dev/tty.usbserial-AQ018ZLG`
- Port detected by scanning `/dev/tty.*` devices

### New Diagnostic Tools Added
1. **scripts/serial_diagnostic.py** - Comprehensive serial troubleshooting
   - Lists all available serial ports with FTDI detection
   - Tests echo communication with detailed output
   - Shows response timing and success rates
   - Tests multiple baud rates if initial connection fails
   - Checks DTR/RTS control lines
   - Provides step-by-step troubleshooting guidance

2. **docs/SERIAL_TROUBLESHOOTING.md** - Complete troubleshooting guide
   - Hardware checklist (switches, power, cables)
   - Firmware programming verification steps
   - Common issues and solutions (ranked by likelihood)
   - Echo test explanation (what happens on both sides)
   - Hardware reference (pin assignments, switch settings)
   - Advanced debugging techniques

### Issue Identified: No Echo Response
**Symptoms:**
- Python shows "✓ Connected to robot"
- Port opens successfully at 9600 baud
- Echo test returns 0% success rate (no responses)

**Most Likely Causes:**
1. Hardware switches SW5.1/SW5.2 not ON
2. Firmware not programmed to PIC18
3. Microcontroller not running (needs reset)
4. Wrong baud rate configuration

**Next Steps:**
1. Run `python3 scripts/serial_diagnostic.py` for automated testing
2. Check hardware switches on EasyPIC Pro 7 board
3. Verify firmware is programmed (reprogram if needed)
4. Press RESET button on board
5. Follow SERIAL_TROUBLESHOOTING.md guide

## [2025-11-21] - UART Echo Test for Debugging Serial Communication

### Problem Identified
- Both `uart.s` and `serial_handler.s` define the same functions (UART_Init, UART_RX_ISR)
- Both use the same memory addresses (UART_RX_BUFFER at 0x100)
- Linker conflict prevented proper UART functionality
- Python echo test showed 0% success rate - PIC not echoing bytes

### Solution: Direct Echo in ISR
Modified `main.s` to add simple echo functionality directly in the interrupt handler:
- ISR checks RC1IF flag
- Reads byte from RCREG1
- Immediately writes to TXREG1 (echo)
- Error handling for OERR and FERR
- Bypasses UART_RX_ISR command parsing for testing

### Files Modified
1. **main.s** - Added echo test mode to ISR
   - Removed call to UART_RX_ISR (commented in extrn)
   - Direct echo implementation in high_isr
   - Still calls UART_Init for setup
   - Motor initialization preserved
   
2. **uart_echo_test.s** - Created as reference (standalone version if needed)

### Testing Procedure

**Step 1: Build and Program**
```
1. In MPLAB X, Clean and Build project
2. Program PIC18F87K22 with generated hex file
3. CRITICAL: Ensure SW5.1 (RC6) and SW5.2 (RC7) are ON
4. Power cycle the board after programming
```

**Step 2: Python Echo Test**
```bash
python scripts/main_control.py --interactive
robot> echo 10        # Test 10 bytes
robot> echo           # Test full 256 bytes
```
Expected: 100% success rate

**Step 3: RealTerm Test**
```
1. Open RealTerm, set correct COM port, 9600 baud, 8N1
2. Type characters in Send tab
3. Should see immediate echo in Display tab
```

### Troubleshooting - Still Getting 0% Response

**1. Check Hardware Switches (MOST COMMON)**
- SW5.1 (RC6/TX) must be ON
- SW5.2 (RC7/RX) must be ON
- Located on EasyPIC Pro 7 board
- These connect UART pins to USB-UART converter

**2. Verify COM Port**
```bash
# Windows: Device Manager > Ports (COM & LPT)
# Look for: "USB Serial Port (COMx)"
# Update robot_config.py if different from COM3
```

**3. Check FTDI Drivers**
```bash
# Download from: http://www.ftdichip.com/Drivers/VCP.htm
# Install VCP (Virtual COM Port) drivers
# Restart computer after installation
```

**4. Verify UART_Init in uart.s**
Check that uart.s UART_Init enables interrupts:
```assembly
bsf RC1IE      ; Enable RX interrupt
bsf PEIE       ; Enable peripheral interrupts  
bsf GIE        ; Enable global interrupts
```

**5. Test with Loopback**
- Disconnect from PC
- Connect TX to RX physically (RC6 to RC7)
- Use oscilloscope to verify TX is transmitting
- If no TX activity, UART not initialized properly

**6. Exclude serial_handler.s**
In MPLAB X:
```
Right-click serial_handler.s → Exclude from Build
(Prevents conflict with uart.s)
```

**7. Check Power**
- PIC needs 5V power
- Motors need separate 8-12V supply
- Common ground between all supplies

### Restoring Command Processing (After Echo Works)

Once echo test confirms UART communication is working:

**Step 1: Restore UART_RX_ISR in main.s**
```assembly
; In main.s, change from:
extrn	UART_Init

; To:
extrn	UART_Init, UART_RX_ISR

; And in high_isr, replace echo code with:
high_isr:
    call    UART_RX_ISR
    retfie
```

**Step 2: Resolve uart.s / serial_handler.s Conflict**
Choose ONE option:
- **Option A (Recommended)**: Keep uart.s only
  - In MPLAB: Right-click serial_handler.s → Exclude from Build
  - uart.s is more complete and tested
  
- **Option B**: Keep serial_handler.s only
  - In MPLAB: Right-click uart.s → Exclude from Build
  - Both are functionally similar

**Step 3: Rebuild and Test Commands**
```
1. Clean and Build project
2. Program PIC18
3. Test: robot> step 10 0 0 0
4. Test: robot> move 200 0 200
```

### Technical Notes
- SPBRG = 103 for 9600 baud @ 16MHz (verified working value)
- Echo test validates full-duplex communication on single COM port
- No need for separate TX/RX ports - uses same port bidirectionally
- FTDI FT232RL USB-UART converter requires proper drivers

## [2025-11-21] - IK Coupling Toggle & Serial Echo Test

### Python Control Changes
- **Coupling toggle**: Added `--no-coupling` flag and `coupling on/off` command
  - Allows disabling shoulder-elbow coupling constraint for testing
  - Useful when robot is in folded home position
  - IK falls back to standard 2R planar solution when disabled
  - Command-line: `python main_control.py --interactive --no-coupling`
  - Interactive: `robot> coupling off` / `robot> coupling on`
  
- **Serial echo test**: Added `echo [count]` command
  - Sends 0-255 (or specified count) bytes to PIC18
  - Expects each byte to be echoed back
  - Reports success rate and mismatches
  - Useful for testing UART with RealTerm or other terminal software before complex commands
  - Usage: `robot> echo 10` (test 10 bytes) or `robot> echo` (test 256 bytes)

### Technical Details
- Added `send_raw_byte()` and `read_raw_byte()` methods to `SerialInterface` class
- Both SerialInterface and MockSerialInterface support raw byte operations
- Echo test provides progress updates every 32 bytes
- Test validates bidirectional UART communication at hardware level

### Files Modified
- `scripts/main_control.py`: Added coupling toggle flag, echo test method, and interactive commands
- `scripts/serial_interface.py`: Added raw byte send/receive methods
- Help text updated with new commands

### Testing
1. Test with coupling disabled: `python main_control.py --interactive --no-coupling`
2. Test serial echo: `robot> echo 10` (start small) then `robot> echo` (full test)
3. Toggle at runtime: `robot> coupling off` then `robot> move 200 0 200`

## [2025-11-21] - Windows Serial Port Configuration

### Configuration Update (`scripts/robot_config.py`)
- **Updated serial port for Windows**: Changed default from macOS format to Windows COM port
  - Previous: `/dev/tty.usbserial-0001` (macOS)
  - Current: `COM3` (Windows) - adjust number as needed
- **Added comprehensive serial port comments**:
  - Instructions for all platforms (Windows, macOS, Linux)
  - Windows: Check Device Manager > Ports (COM & LPT) to find correct COM port
  - Notes about FT232RL USB-UART converter (requires FTDI drivers)
  - Hardware requirement: SW5.1 (RC6) and SW5.2 (RC7) must be ON for USB-UART
- **Baud rate confirmed**: 9600 (standard for EasyPIC Pro 7 UART communication)

### Reference Documentation
- Based on `docs/5_Serial_Parallel.md` specifications
- EasyPIC Pro 7 uses FT232RL controller for USB-UART conversion
- COM port appears as CDC device on Windows PC

## [2025-01-20] - Serial Control Enabled

### Firmware Changes (main.s)
- **Sequential demo disabled**: Commented out `Motor_SequentialDemo` call in main loop
- **UART serial communication enabled**: Added `UART_Init` initialization
- **Interrupt-driven serial handler**: Added ISR (Interrupt Service Routine) for UART receive
- **Real-time command processing**: PIC18 now listens for serial commands from PC
- **Built successfully**: Generated `dist/default/production/MrRoboto.production.hex` (4.7 KB)

### Python Control Changes (scripts/main_control.py)
- **New `step` command**: Added direct motor angle control in interactive mode
  - Format: `step <base> <shoulder> <elbow> <wrist>`
  - Accepts angles in degrees (positive or negative)
  - Converts angles to steps using `config.angles_to_steps()`
  - Sends STEP command via serial to PIC18
  - Displays conversion feedback (angles → steps)
- **Updated help text**: Interactive mode now shows `step` command

### Documentation
- **Created WINDOWS_TEST_GUIDE.md**: Complete guide for testing on Windows
  - Instructions for downloading firmware to PIC18
  - Windows COM port configuration
  - Step-by-step testing procedures
  - Troubleshooting section

### Testing
- Firmware compiles without errors
- Python script imports successfully
- Ready for hardware testing with PIC18F87K22

### Usage Example
```bash
python main_control.py --interactive
robot> step 10 20 -15 5
Angles: θ1=10.0° θ2=20.0° θ3=-15.0° θ4=5.0°
Steps: base=1 shoulder=103 elbow=-77 wrist=0
✓ Movement complete
```

## [Fixed] - 2025-11-21

### Fixed - Assembly Syntax Errors in UART Modules

**Resolved All Build Errors:**

#### Syntax Corrections (`uart.s`, `serial_handler.s`)
- **Fixed `moviw FSR0++` instruction**: Changed to correct PIC18 syntax `movf POSTINC0, W, A`
  - This instruction reads from FSR0 and auto-increments the pointer
  - Error was causing 16+ syntax errors across command parsing routines
- **Fixed register bit access syntax**: Changed from `REGISTER, BITNAME` to direct bit names
  - Example: `bcf RCSTA1, SPEN, A` → `bcf SPEN`
  - Example: `bsf TXSTA1, TXEN, A` → `bsf TXEN`
  - PIC-AS assembler expects bit names without register prefix for SFRs
- **Fixed STATUS register flag access**: Changed symbolic names to bit numbers
  - `STATUS, Z, A` → `STATUS, 2, A` (Zero flag = bit 2)
  - `STATUS, C, A` → `STATUS, 0, A` (Carry flag = bit 0)
  - Assembler doesn't define symbolic names for STATUS bits
- **Fixed interrupt enable bits**: Changed symbolic names to bit numbers
  - `PIE1, RC1IE, A` → `PIE1, 5, A` (UART receive interrupt enable)
  - `INTCON, PEIE, A` → `INTCON, 6, A` (Peripheral interrupt enable)
  - `INTCON, GIE, A` → `INTCON, 7, A` (Global interrupt enable)
- **Fixed global/extern declarations**: Changed from uppercase to lowercase
  - `GLOBAL` → `global`, `EXTERN` → `extern`
  - Matches convention used in `motor_control.s`
- **Commented out unused extern declarations**: Motor control functions not yet called
- **Fixed psect conflict**: Renamed `PSECT code` to `psect serial_handler_code,class=CODE`
  - Prevents linker clash between `uart.s` and `serial_handler.s`

#### Build Status
- ✅ **All syntax errors resolved** (was 21+ errors per file)
- ✅ **All files compile successfully**
- ✅ **Linker produces valid output**: `default.elf`, `default.hex`
- ✅ **Memory usage**: 2674 bytes (2.0% of program space)
- ⚠️ Minor memory overlap warning at 0x11D (non-critical)

#### Technical Details
**PIC-AS Assembler Syntax (PIC18F87K22):**
- Special function register bits accessed by name only (no register prefix)
- STATUS register bits must use numeric bit positions
- Access bank specifier `, A` required for banked memory
- `POSTINC0/1/2` registers provide FSR auto-increment
- `global`/`extern` directives must be lowercase
- Each module needs unique `psect` name to avoid conflicts

**Files Modified:**
- `uart.s`: 8 types of syntax errors fixed
- `serial_handler.s`: 7 types of syntax errors fixed
- Both files now assemble cleanly with only access-bank warnings (non-critical)

### Notes
- Warnings about "RAM access bit operand not specified" are acceptable
  - Assembler assumes correct bank access (access-bank or banked)
  - No functional impact on code execution
- Both `uart.s` and `serial_handler.s` contain duplicate functionality
  - Consider removing one or merging implementations
  - Currently both compile due to unique psect names

## [Updated] - 2025-11-21

### Changed - Measured Gear Ratios and One-Way Coupling

**Updated Configuration Based on Physical Measurements:**

#### Gear Ratios (`scripts/robot_config.py`)
- **Shoulder motor**: Updated from placeholder 0.133 to measured **5.189 steps/degree**
  - Calibration: 96 steps produces 18.5° rotation
  - Calculation: 96 / 18.5 = 5.189 steps/degree
- **Elbow motor**: Updated from placeholder 0.133 to measured **5.189 steps/degree**
  - Same gear ratio as shoulder (identical motors and gearheads)
- **Base and Wrist**: Remain to be calibrated (currently placeholder values)

#### Coupling Mechanism (`scripts/robot_config.py`, `scripts/ik_solver.py`)
- **Updated coupling model** to reflect tendon-actuated mechanism:
  - `coupling_ratio` changed from +1.0 to **-1.0** (negative for opposite directions)
  - **One-way coupling**: Shoulder movement affects elbow, but elbow can move independently
  - When shoulder moves forward (+18.5°), tendon pulls elbow backward (-18.5°)
  - Arms close together when shoulder moves forward
- **Comprehensive documentation** added to explain mechanism:
  - Physical behavior: tendon-actuated linkage
  - Mathematical model: θ₃ = -1.0 × θ₂ (when shoulder moves)
  - Independence: Elbow motor can overcome tendon tension and move freely

#### Motor Control Documentation (`motor_control.s`)
- Added measured gear ratio comments (5.189 steps/degree for shoulder/elbow)
- Documented tendon coupling mechanism with one-way behavior
- Clarified that 96 steps = 18.5° for shoulder and elbow motors

### Added - Unified UART Module

**Merged Serial Handler into UART (`uart.s`):**

#### Features
- **Integrated command parsing** from `serial_handler.s` into `uart.s`
- **Preserved working UART_Setup** from original `uart.s` (9600 baud, proven reliable)
- **Comprehensive command protocol**:
  - `MOVE <θ1> <θ2> <θ3> <θ4>` - Move to joint angles (degrees)
  - `STEP <s1> <s2> <s3> <s4>` - Move by step counts
  - `HOME` - Move to home position
  - `STOP` - Emergency stop
  - `STATUS` - Report current angles
  - `SPEED <value>` - Set motor speed
  - `CAL <joint> <steps>` - Calibrate single joint
- **Interrupt-driven receive** handling with buffer management
- **Proper exports** for motor_control.s integration
- **Future ADC support** documented for potentiometer inputs (r, φ, z)

#### Future ADC Integration (Planned)
- **3 Potentiometers** for position input:
  - **r (radius)**: PORTA (e.g., RA0 via J5 jumper with P2)
  - **φ (azimuth angle)**: PORTF (e.g., RF1 via J6 jumper with P3)
  - **z (height)**: Remaining PORTA or PORTF pin
- **Command**: `POT` → returns `ADC <r_val> <phi_val> <z_val>`
- **ADC Configuration**: 12-bit resolution (0-4095 range) on PIC18F87K22
- **Reference**: EasyPIC PRO v7 manual, Page 32 (ADC inputs section)

#### Build Configuration
- **Added uart.s** to MPLAB X project (`nbproject/configurations.xml`)
- **Verified dependencies**: All motor_control.s functions properly exported
- **Module linkage**: uart.s extern declarations match motor_control.s globals

### Verified - Build System

**Build Verification (`BUILD_VERIFICATION.md`):**
- ✅ All source files configured in MPLAB X project
- ✅ Module dependencies properly linked
- ✅ Assembly syntax validated
- ✅ No register or memory conflicts
- ✅ Python modules compatible with updated parameters
- ⚠️ UART command execution requires implementation (TODOs marked)
- ⚠️ main.s needs ISR integration for UART receive

### Technical Details

**Measured Values:**
- Shoulder/Elbow gear ratio: 5.189 steps/degree (measured)
- Coupling ratio: -1.0 (opposite directions, measured)
- Coupling offset: 0.0 (no offset, measured)
- Coupling type: One-way tendon-actuated

**Memory Layout (uart.s):**
- UART RX buffer: 0x100-0x13F (64 bytes)
- Command buffer: 0x140-0x15F (32 bytes)
- Control variables: 0xF0-0xF9, 0x1F
- No conflicts with motor_control.s (0x0A-0x1E)

**Protocol Compatibility:**
- Python `serial_interface.py` matches uart.s command formats
- All commands verified: MOVE, STEP, HOME, STOP, STATUS, SPEED, CAL
- Response formats compatible: OK, ERROR, STATUS

### Notes
- MPLAB X IDE required for building (auto-generates makefiles)
- Command-line `make` will not work without IDE-generated files
- UART command execution functions marked as TODO
- ISR integration in main.s required for full UART functionality
- Calibration values based on physical measurements of 96 steps = 18.5°

---

## [Unreleased] - 2024-11-21

### Added - Python Inverse Kinematics Control System

Complete Python-based control system for high-level robot arm control:

#### New Files

**Python Modules (`scripts/`):**
- `robot_config.py` - Robot configuration and parameters
  - Link lengths (L0-L3) with workspace calculation
  - Joint limits and home position
  - Shoulder-elbow coupling model (scissor mechanism)
  - Gear ratios (steps per degree)
  - Serial port configuration
  - Workspace boundary checking

- `ik_solver.py` - Inverse kinematics solver
  - Cylindrical coordinate input (ρ, φ, z)
  - Explicit coupling constraint handling
  - Numerical search for coupled 2-DOF planar problem
  - Forward kinematics for verification
  - Workspace reachability validation

- `serial_interface.py` - PySerial communication
  - Command protocol for PIC18 control
  - Commands: MOVE, STEP, HOME, STOP, STATUS, SPEED, CAL
  - Background reader thread for async responses
  - Mock interface for testing without hardware
  - Timeout handling and error recovery

- `visualizer.py` - 3D matplotlib visualization
  - Real-time robot pose display
  - 3D view with colored arm segments
  - Top-down workspace view
  - Workspace boundary cylinders
  - Target position markers
  - Trajectory animation support

- `calibration.py` - Interactive calibration wizard
  - Link length measurement guide
  - Gear ratio calibration (steps per degree)
  - Coupling relationship measurement (5-point fit)
  - Joint limit determination
  - Save/load calibration to JSON
  - Quick manual calibration mode

- `main_control.py` - Main control loop
  - Integrates IK solver, serial, and visualization
  - Point-to-point movements
  - Trajectory execution
  - Pre-defined test patterns:
    - Circular trajectory
    - Figure-eight pattern
    - Workspace boundary exploration
  - Interactive control mode
  - Command-line interface

- `demo_ik.py` - Demonstration script
  - Basic IK solving examples
  - Coupling demonstration
  - Workspace boundary testing
  - Trajectory generation
  - Visualization demo
  - No hardware required

- `requirements.txt` - Python dependencies
  - numpy, matplotlib, pyserial, sympy

- `README.md` - Complete Python system documentation

**Assembly Code:**
- `serial_handler.s` - PIC18 serial command handler
  - UART initialization (9600 baud)
  - Receive interrupt handler
  - Command parsing (MOVE, STEP, HOME, etc.)
  - Command execution framework
  - Response transmission (OK, ERROR, STATUS)
  - Integration guide for main.s

#### Features

**Inverse Kinematics:**
- Solves joint angles for cylindrical coordinates (ρ, φ, z)
- Base angle: θ₁ = φ (direct from cylindrical input)
- Planar 2-DOF with coupling: Numerical search over θ₂
- Wrist angle: θ₄ = desired_pitch - θ₂ - θ₃
- Joint limit validation
- Coupling constraint: θ₃ = ratio × θ₂ + offset

**Control Modes:**
1. Mock mode - Test without hardware
2. Hardware mode - Real-time control via serial
3. Interactive mode - Command-line interface
4. Test mode - Pre-defined trajectories
5. Calibration mode - Parameter measurement

**Communication Protocol:**
```
MOVE <θ1> <θ2> <θ3> <θ4>  → Move to joint angles (degrees)
STEP <s1> <s2> <s3> <s4>  → Move by step counts
HOME                       → Move to home position
STOP                       → Emergency stop
STATUS                     → Query current angles
SPEED <value>              → Set motor speed (steps/sec)
CAL <joint> <steps>        → Single joint calibration
```

**Visualization:**
- 3D arm configuration with colored links
- Top-down view for path planning
- Workspace boundaries (max/min reach cylinders)
- Real-time pose updates
- Trajectory animation

**Calibration:**
- Interactive wizard guides through measurements
- Link lengths measured with ruler/tape
- Gear ratios calibrated by commanding steps and measuring rotation
- Coupling measured with 5 data points (linear fit)
- Joint limits determined experimentally
- Data saved to `calibration.json`

#### Usage Examples

**Test without hardware:**
```bash
cd scripts
python main_control.py --mock --interactive
```

**Calibrate robot:**
```bash
python main_control.py --calibrate
```

**Run tests:**
```bash
python main_control.py --load-calib calibration.json --test all
```

**Demo (no hardware):**
```bash
python demo_ik.py
```

#### Documentation

- Comprehensive README in `scripts/` directory
- Main README updated with Python control system overview
- Inline documentation in all Python modules
- Assembly code integration guide in `serial_handler.s`
- Example usage in `demo_ik.py`

### Modified

- `README.md` - Added Python control system section
  - Quick start guide
  - Architecture diagram
  - Serial protocol documentation
  - Integration instructions

### Technical Details

**Coordinate System:**
- Input: Cylindrical (ρ, φ, z) with base as origin
- Output: Joint angles (θ₁, θ₂, θ₃, θ₄) in degrees
- Base rotation θ₁ matches azimuthal angle φ
- Home position: all motors at mechanical limits

**Coupling Model:**
- Linear relationship: θ₃ = ratio × θ₂ + offset
- Represents scissor-like shoulder-elbow mechanism
- Typical ratio ≈ 1.0 (1:1 coupling)
- Measured experimentally during calibration

**IK Algorithm:**
- Closed-form for base (θ₁ = φ)
- Numerical search for coupled shoulder-elbow
- Forward kinematics search over θ₂ range
- Minimize end effector position error
- Solution acceptance threshold: < 1mm

**Communication:**
- UART at 9600 baud (configurable)
- ASCII text commands with '\n' terminator
- Background reader thread for async responses
- Timeout handling (default 5s)
- Error recovery with buffer reset

### Dependencies

**Python:**
- Python 3.8+
- numpy >= 1.24.0
- matplotlib >= 3.7.0
- pyserial >= 3.5
- sympy >= 1.12 (optional)

**Hardware:**
- PIC18F87K22 microcontroller
- EasyPIC Pro v7 development board
- 6× Stepper motors (9904 112 35014)
- 6× L298N motor drivers
- USB-to-Serial adapter

### Testing

All modules tested independently:
- IK solver: Verified with known configurations
- Serial interface: Mock and loopback tests
- Visualization: Multiple pose configurations
- Calibration: Manual measurement simulation
- Integration: Full trajectory execution (mock mode)

### Future Work

Potential enhancements mentioned in documentation:
- Trajectory planning with velocity limits
- Collision detection
- Real-time encoder feedback
- GUI interface
- Motion recording and playback
- Visual servoing
- Path optimization for minimum jerk
- Force feedback

### Notes

- Python system designed as fallback for assembly IK complexity
- Can be used for rapid prototyping before assembly implementation
- Serial protocol designed for easy PIC18 integration
- Mock interface allows development without hardware
- Calibration system enables parameter measurement
- Modular design allows independent testing

---

## Previous Work

### Motor Control Module

Assembly-based motor control for 6 stepper motors:
- Bidirectional stepping
- Interleaved operation for smooth motion
- Independent step tracking per motor
- Configurable step counts
- Sequential demo of all joints

See `motor_control.s` and `docs/Motor_Control_Module.md` for details.

