# Motor Control Module Documentation

## Overview

The Motor Control Module (`motor_control.s`) provides complete control functionality for a unipolar stepper motor (9904 112 35014) using an L298N motor driver module. The module implements wave drive sequencing for precise step-by-step motor control.

## Hardware Configuration

### Motor Specifications
- **Model**: 9904 112 35014
- **Type**: Unipolar stepper motor (4-phase, 6 terminals)
- **Step Angle**: 7.5° per step (48 steps per full rotation)
- **Current per Phase**: 240mA (0.24A)
- **Voltage**: 8-12V (external supply recommended)
- **Resistance**: 47Ω per phase
- **Inductance**: 400mH per phase

### L298N Driver Configuration
- **Driver Module**: L298N Dual H-Bridge Motor Driver
- **Control Method**: Using L298N outputs to drive individual coils (not as H-bridges)
- **Enable Pins**: ENA/ENB connected to +5V (always enabled)
- **Power Supply**: External 8-12V supply required (not from PIC board)

### Pin Connections
```
PIC18F87K22 PORT E → L298N Module → Motor Coils
─────────────────────────────────────────────────
RE0 (PORTE bit 0) → IN1 → OUT1 → Green wire (Coil 1)
RE1 (PORTE bit 1) → IN2 → OUT2 → Purple wire (Coil 2)
RE2 (PORTE bit 2) → IN3 → OUT3 → Blue wire (Coil 3)
RE3 (PORTE bit 3) → IN4 → OUT4 → Grey wire (Coil 4)
─────────────────────────────────────────────────
External +V (8-12V) → White wire (Center tap/common) ⚠️ CRITICAL!
Common GND → All GND connections
```

**Important**: The white wire (center tap) MUST be connected to the +V supply (8-12V). Without this connection, the motor cannot complete the circuit and will not operate correctly.

## Software Architecture

### Module Structure
The motor control module is organized into several functional components:

1. **Initialization**: Sets up motor to known state
2. **Step Execution**: Single step forward/backward functions
3. **Multi-Step Execution**: Execute multiple steps with delays
4. **Step Sequence Lookup**: Maps step index to coil pattern
5. **Timing Control**: Delay functions for step timing

### Register Usage
```
Address  Register Name      Purpose
─────────────────────────────────────────────
0x0A     stepIndex          Current step position (0-3)
0x0B     stepCount          Counter for multi-step operations
0x0C     stepDelayH         Delay counter high byte (unused in current impl)
0x0D     stepDelayL         Delay counter low byte (inner loop)
0x0E     pauseDelayH        Pause delay counter high byte
0x0F     pauseDelayL        Pause delay counter low byte / temp storage
0x10     pauseOuter         Outer loop counter for delays
```

## Step Sequence Algorithm

### Wave Drive Sequence
The module implements **wave drive** (also called "one-phase-on" or "single-coil excitation") sequencing:

```
Step Index  Coil Pattern  PORTE Value  Coil Energized
───────────────────────────────────────────────────────
    0           0x01         0b0001      Coil 1 (Green)
    1           0x04         0b0100      Coil 3 (Blue)
    2           0x02         0b0010      Coil 2 (Purple)
    3           0x08         0b1000      Coil 4 (Grey)
```

**Sequence**: 1 → 3 → 2 → 4 → 1... (forward)
**Reverse**:  1 → 4 → 2 → 3 → 1... (backward)

This sequence is based on the Philips Stepping Motors documentation and is the standard wave drive pattern for 4-phase unipolar motors.

### Why This Sequence?
- **Wave drive** energizes one coil at a time, providing:
  - Simple control logic
  - Lower power consumption
  - Good step resolution
  - Reduced torque (~30% less than full-step, but acceptable for most applications)

## Function Reference

### `Motor_Init`
**Purpose**: Initialize motor control system  
**Parameters**: None  
**Returns**: None  
**Side Effects**: 
- Sets `stepIndex` to 0
- Outputs STEP1 pattern to PORTE (Coil 1 energized)
- Assumes PORTE is already configured as output in main program

**Usage**:
```assembly
call Motor_Init  ; Initialize motor to step 0
```

### `Motor_StepForward`
**Purpose**: Execute one step forward in the sequence  
**Parameters**: None (uses global `stepIndex`)  
**Returns**: None  
**Side Effects**:
- Increments `stepIndex` (wraps 3→0)
- Updates PORTE with new step pattern
- Advances motor shaft by 7.5°

**Algorithm**:
1. Load current `stepIndex`
2. Increment by 1
3. Mask to 0-3 range (wrap around)
4. Save new `stepIndex`
5. Look up step pattern via `GetStepValue`
6. Output pattern to PORTE

**Usage**:
```assembly
call Motor_StepForward  ; Move one step forward
```

### `Motor_StepBackward`
**Purpose**: Execute one step backward in the sequence  
**Parameters**: None (uses global `stepIndex`)  
**Returns**: None  
**Side Effects**:
- Decrements `stepIndex` (wraps 0→3)
- Updates PORTE with new step pattern
- Moves motor shaft backward by 7.5°

**Algorithm**:
1. Load current `stepIndex`
2. Add 3 (equivalent to subtracting 1, with wrap)
3. Mask to 0-3 range
4. Save new `stepIndex`
5. Look up step pattern via `GetStepValue`
6. Output pattern to PORTE

**Usage**:
```assembly
call Motor_StepBackward  ; Move one step backward
```

### `GetStepValue`
**Purpose**: Convert step index (0-3) to PORTE output pattern  
**Parameters**: W register = step index (0-3)  
**Returns**: W register = step pattern value (STEP1-STEP4)  
**Side Effects**: Uses `pauseDelayL` as temporary storage

**Step Pattern Mapping**:
- Index 0 → STEP1 (0x01) = Coil 1
- Index 1 → STEP2 (0x04) = Coil 3
- Index 2 → STEP3 (0x02) = Coil 2
- Index 3 → STEP4 (0x08) = Coil 4

**Implementation**: Uses conditional branches (XOR comparisons) instead of computed jumps for reliability.

**Usage**: Called internally by step functions, not typically called directly.

### `Motor_StepDelay`
**Purpose**: Provide delay between steps (~1 second)  
**Parameters**: None  
**Returns**: None  
**Side Effects**: Consumes CPU time (blocking delay)

**Timing Calculation**:
- **System Clock**: 16MHz crystal × PLL x4 = 64MHz
- **Instruction Rate**: 64MHz / 4 = 16 MIPS
- **Target Delay**: 1 second = 16,000,000 instruction cycles
- **Implementation**: Triple nested loop
  - Outer: 250 iterations
  - Middle: 250 iterations
  - Inner: 128 iterations
  - Total: 250 × 250 × 128 = 8,000,000 iterations
  - Cycles: 8,000,000 × 2 cycles/iteration ≈ 16,000,000 cycles ≈ 1.0 second

**Usage**: Called automatically by multi-step functions, or manually:
```assembly
call Motor_StepDelay  ; Wait ~1 second
```

### `Motor_StepsForward`
**Purpose**: Execute multiple steps forward with delays  
**Parameters**: W register = number of steps to execute  
**Returns**: None  
**Side Effects**: 
- Uses `stepCount` register
- Moves motor forward by (steps × 7.5°)
- Takes approximately (steps × 1 second)

**Usage**:
```assembly
movlw 0x0C      ; 12 steps = 90°
call Motor_StepsForward
```

### `Motor_StepsBackward`
**Purpose**: Execute multiple steps backward with delays  
**Parameters**: W register = number of steps to execute  
**Returns**: None  
**Side Effects**: 
- Uses `stepCount` register
- Moves motor backward by (steps × 7.5°)
- Takes approximately (steps × 1 second)

**Usage**:
```assembly
movlw 0x0C      ; 12 steps = 90°
call Motor_StepsBackward
```

### `Motor_Pause`
**Purpose**: Long pause between direction changes  
**Parameters**: None  
**Returns**: None  
**Side Effects**: Consumes significant CPU time (several seconds)

**Timing**: Approximately 5 × 0xFFFF × 0xFFFF iterations = several seconds

**Usage**: Called automatically by `Motor_BidirectionalTest`, or manually:
```assembly
call Motor_Pause  ; Long pause
```

### `Motor_BidirectionalTest`
**Purpose**: Test motor with bidirectional rotation  
**Parameters**: None  
**Returns**: None  
**Behavior**:
1. Rotates forward 12 steps (90°)
2. Pauses
3. Rotates backward 12 steps (returns to start)
4. Pauses
5. Repeats

**Usage**:
```assembly
call Motor_BidirectionalTest  ; Execute one test cycle
```

## Timing Characteristics

### Step Timing
- **Delay per step**: ~1 second (configurable via `Motor_StepDelay`)
- **Steps per second**: ~1 step/sec (at default delay)
- **Rotation speed**: 7.5° per second = 48 seconds per full rotation

### Adjusting Speed
To change step speed, modify the inner loop count in `Motor_StepDelay`:
- **Faster**: Reduce inner loop iterations (e.g., 13 iterations ≈ 0.1 seconds)
- **Slower**: Increase inner loop iterations (e.g., 256 iterations ≈ 2 seconds)

**Formula**: For delay `D` seconds at 16 MIPS:
- Required iterations = (D × 16,000,000) / 2
- Inner loop iterations = Required iterations / (250 × 250)

## Troubleshooting

### Motor Not Moving
1. **Check white wire connection**: Center tap MUST be connected to +V supply
2. **Verify power supply**: 8-12V external supply required
3. **Check L298N enable pins**: ENA/ENB should be HIGH (+5V)
4. **Verify PORTE configuration**: Must be set as output (TRISE = 0x00)
5. **Check oscilloscope**: Verify signals on RE0-RE3 are changing

### Motor Stuck on One Step
**Symptom**: Motor keeps looping on one forward step after certain rotations

**Possible Causes**:
1. **Register conflict**: `stepIndex` or step pattern registers corrupted
2. **Sequence logic error**: Step index not wrapping correctly
3. **Timing issue**: Delay function interfering with step sequence

**Solution**: The code uses `pauseDelayL` instead of `stepDelayL` in `GetStepValue` to avoid register conflicts. If issue persists:
- Verify `stepIndex` is not being modified elsewhere
- Check that interrupts are not interfering
- Ensure delay functions complete before next step

### Incorrect Step Sequence
**Symptom**: Motor steps but in wrong order or direction

**Check**:
1. Verify wire connections match documentation (Green=1, Purple=2, Blue=3, Grey=4)
2. Confirm step sequence constants match hardware wiring
3. Check that `stepIndex` wraps correctly (0→1→2→3→0)

### Motor Moves Too Fast/Slow
**Symptom**: Steps occur faster or slower than expected

**Solution**: Adjust `Motor_StepDelay` inner loop count:
- Current: 128 iterations ≈ 1 second
- Faster: Reduce to 13 iterations ≈ 0.1 seconds
- Slower: Increase to 256 iterations ≈ 2 seconds

## Code Examples

### Basic Forward Stepping
```assembly
call Motor_Init           ; Initialize motor
loop:
    call Motor_StepForward
    call Motor_StepDelay
    bra loop
```

### Bidirectional Test
```assembly
call Motor_Init
loop:
    call Motor_BidirectionalTest
    bra loop
```

### Custom Step Count
```assembly
call Motor_Init
movlw 0x30        ; 48 steps = 360° (full rotation)
call Motor_StepsForward
```

## Design Decisions

### Why Wave Drive?
- Simpler than full-step (two coils) or half-step
- Lower power consumption
- Adequate torque for belt-driven applications
- Standard sequence for unipolar motors

### Why Conditional Branches Instead of Computed Jump?
- Computed jumps (`addwf PCL`) can fail across page boundaries
- Conditional branches are more reliable and easier to debug
- Minimal performance impact (only called once per step)

### Why Triple Nested Loops for Delay?
- Simple 8-bit counters are more reliable than 16-bit operations
- Easy to adjust by changing one loop count
- Predictable timing behavior
- No complex arithmetic required

## Performance Considerations

### CPU Usage
- **Step execution**: Negligible (< 100 instruction cycles)
- **Delay function**: Blocks CPU for ~1 second per step
- **Total CPU usage**: ~99.99% during delays (expected behavior)

### Memory Usage
- **Code size**: ~220 lines of assembly
- **RAM usage**: 7 bytes (registers 0x0A through 0x10)
- **Stack usage**: Minimal (only function calls)

## Future Enhancements

Potential improvements for future versions:

1. **Variable speed control**: Parameterize delay function
2. **Acceleration/deceleration**: Ramp speed up/down
3. **Position tracking**: Track absolute position in steps
4. **Full-step mode**: Two coils at once for more torque
5. **Half-step mode**: 8 steps per cycle for finer resolution
6. **Interrupt-based timing**: Use timer interrupts instead of delays

## References

- **Motor Datasheet**: 330510 Motor.md (9904 112 35014 specifications)
- **Drive Method**: Philips Stepping Motors 1986.md (Wave drive documentation)
- **Hardware Setup**: L298N_Unipolar_Wiring.md (Connection guide)
- **Board Manual**: easypic-pro-v7-manual-v101.md (PIC18F87K22 configuration)

## Version History

- **v1.0**: Initial implementation with wave drive sequence
- **v1.1**: Fixed computed jump issue (replaced with conditional branches)
- **v1.2**: Corrected step sequence (1→3→2→4 for unipolar)
- **v1.3**: Fixed delay calculation for PLL-enabled clock (16 MIPS)
- **v1.4**: Fixed register conflict in GetStepValue (use pauseDelayL)

