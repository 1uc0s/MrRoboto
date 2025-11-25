# 4-DOF Inverse Kinematics in PIC18 Assembly

## Overview
Implement pure assembly inverse kinematics for a 4-DOF robot arm (Base, Shoulder, Elbow, Wrist) using flash-based sin/cos lookup tables with fixed-point arithmetic.

## Prerequisites - Measurements Needed

Before implementation, you must measure and document:

1. **Link Lengths** (in mm):
   - `L0`: Base height (ground to shoulder pivot)
   - `L1`: Upper arm length (shoulder to elbow)
   - `L2`: Forearm length (elbow to wrist)
   - `L3`: End effector length (wrist to gripper center)

2. **Joint Limits** (in degrees):
   - Base rotation: min/max angles
   - Shoulder pitch: min/max angles
   - Elbow pitch: min/max angles
   - Wrist pitch: min/max angles

3. **Step-to-Angle Calibration**:
   - Confirm: 48 steps = 360° (7.5° per step)
   - Verify actual mechanical backlash/slop

4. **Coordinate System Convention**:
   - Define origin location (base center? shoulder joint?)
   - Define axis directions (X forward, Y left, Z up?)

## Implementation Approach

### Architecture

```
User Input (x, y, z) 
    ↓
IK Solver (assembly)
    ↓
Joint Angles (θ1, θ2, θ3, θ4)
    ↓
Angle-to-Steps Conversion
    ↓
Motor Control (existing motor_control.s)
```

## Implementation Plan

### Phase 1: Lookup Table Infrastructure

**File**: `scripts/generate_trig_tables.py`

Create Python script to generate sin/cos lookup tables:
- Resolution: 0.5° (720 entries per table)
- Format: 16-bit signed fixed-point (Q15 format: range -1.0 to +0.9999)
- Output: Assembly `.db` directives for inclusion in Flash

**File**: `trig_tables.s`

Assembly file containing:
```assembly
psect trig_data,class=CONST,reloc=2,space=0

; Sin table: 720 entries, 0.5° resolution
; Values stored as signed 16-bit fixed-point (Q15)
; sin(θ) × 32768, range: -32768 to +32767
sin_table:
    db 0x00, 0x00  ; sin(0°) = 0
    db 0x01, 0x68  ; sin(0.5°) = 0.00873 × 32768
    ; ... 718 more entries
    
cos_table:
    db 0x7F, 0xFF  ; cos(0°) = 1.0
    ; ... 720 entries
```

**File**: `trig_lookup.s`

Helper functions:
- `Sin_Lookup`: Given angle in degrees (×2 for 0.5° resolution), return sin value
- `Cos_Lookup`: Given angle in degrees (×2), return cos value
- `Interpolate`: Linear interpolation between table entries for sub-degree accuracy

### Phase 2: Fixed-Point Math Library

**File**: `fixed_point_math.s`

Core arithmetic operations on Q15 fixed-point numbers:
- `FP_Multiply`: 16-bit × 16-bit → 16-bit (with proper shift)
- `FP_Divide`: 16-bit ÷ 16-bit → 16-bit (slow, avoid if possible)
- `FP_Add`: 16-bit + 16-bit → 16-bit
- `FP_Subtract`: 16-bit - 16-bit → 16-bit
- `FP_Sqrt`: Square root using Newton-Raphson iteration
- `FP_Atan2`: Arctangent using CORDIC algorithm or lookup table with interpolation

Memory usage: ~20 bytes for intermediate calculations

### Phase 3: Inverse Kinematics Solver

**File**: `inverse_kinematics.s`

#### Geometric Solution for 4-DOF Arm

**Step 1: Base Angle (θ1)**
```
θ1 = atan2(y, x)
```
Projects target onto XY plane for base rotation.

**Step 2: Planar 3-DOF Problem**
After base rotation, solve in 2D:
- Distance from base: `r = sqrt(x² + y²)`
- Target in (r, z) plane

**Step 3: Shoulder & Elbow (θ2, θ3)**
Using law of cosines for 2-link planar arm:
```
D = sqrt(r² + (z - L0)²)  ; Distance to target
cos(θ3) = (D² - L1² - L2²) / (2 × L1 × L2)
θ3 = acos(cos(θ3))  ; Elbow angle

α = atan2(z - L0, r)
β = atan2(L2 × sin(θ3), L1 + L2 × cos(θ3))
θ2 = α - β  ; Shoulder angle
```

**Step 4: Wrist Angle (θ4)**
```
θ4 = desired_pitch - θ2 - θ3
```
Maintains end effector orientation.

#### Function Interface

**Input** (in dedicated memory locations):
- `target_x`: X coordinate (mm, 16-bit signed)
- `target_y`: Y coordinate (mm, 16-bit signed)
- `target_z`: Z coordinate (mm, 16-bit signed)
- `target_pitch`: Desired end effector pitch (degrees, 8-bit)

**Output**:
- `angle_base`: θ1 in degrees (16-bit)
- `angle_shoulder`: θ2 in degrees (16-bit)
- `angle_elbow`: θ3 in degrees (16-bit)
- `angle_wrist`: θ4 in degrees (16-bit)
- `ik_status`: 0 = success, 1 = out of reach, 2 = singularity

**Memory allocation**:
```assembly
; IK input parameters
target_x     EQU 0x20  ; 2 bytes
target_y     EQU 0x22  ; 2 bytes
target_z     EQU 0x24  ; 2 bytes
target_pitch EQU 0x26  ; 1 byte

; IK output angles
angle_base     EQU 0x30  ; 2 bytes
angle_shoulder EQU 0x32  ; 2 bytes
angle_elbow    EQU 0x34  ; 2 bytes
angle_wrist    EQU 0x36  ; 2 bytes
ik_status      EQU 0x38  ; 1 byte

; Working registers (20 bytes)
ik_temp1  EQU 0x40
; ... more temps
```

### Phase 4: Angle-to-Motor-Steps Conversion

**File**: `motor_commands.s`

Convert IK angles to motor step commands:

```assembly
; Constants (measured during calibration)
STEPS_PER_DEGREE EQU 48/360  ; Approximately 0.133 steps/deg

ConvertAngleToSteps:
    ; Input: W = angle in degrees (signed)
    ; Output: W = number of steps (unsigned)
    ; Formula: steps = angle × (48 / 360)
```

Functions:
- `MoveToPosition`: Takes (x,y,z) → runs IK → moves motors
- `CheckReachable`: Validates target is within workspace
- `GetCurrentPosition`: Forward kinematics to report current position

### Phase 5: Integration & Testing

**File**: `ik_test.s`

Test program:
1. Initialize all motors to home position (0, 0, 0, 0)
2. Define test points in workspace
3. Call IK solver for each point
4. Move motors to calculated angles
5. Verify position (manual check or sensors)

**Example test points**:
- Origin check: (0, 0, L0)
- Full extension: (L1+L2+L3, 0, L0)
- Various intermediate points

## Memory Budget

**Flash Memory** (128 KB total):
- Sin/Cos tables: 2.88 KB
- IK solver code: ~2 KB
- Math library: ~3 KB
- Existing motor control: ~1 KB
- **Total: ~9 KB** ✅ Only 7% of Flash

**RAM** (3,896 bytes total):
- IK parameters: 39 bytes
- Motor control vars: 50 bytes (existing)
- Stack: 100 bytes
- **Total: ~190 bytes** ✅ Only 5% of RAM

## Performance Estimates

**Computation time** (at 16 MIPS):
- Table lookup: ~50 instruction cycles
- Fixed-point multiply: ~200 cycles
- Full IK solution: ~50,000 cycles = **3.1 ms** ⚡

**Movement time**:
- Motor stepping: 100 steps/sec = 10ms per step
- Full rotation (48 steps): 480ms
- **IK computation is negligible compared to motion time**

## Alternative: Simplified 3-DOF Implementation

If 4-DOF is too complex initially, start with 3-DOF (Base + Shoulder + Elbow):
- Simpler equations (no wrist compensation)
- Same lookup tables
- Faster development
- Easy to extend to 4-DOF later

## Key Design Decisions

1. **Lookup tables in Flash, not RAM**: Saves precious RAM
2. **Fixed-point arithmetic**: No floating point needed
3. **0.5° resolution**: Good accuracy (±2.5mm at 300mm reach)
4. **Geometric approach**: Simpler than DH parameters
5. **Blocking computation**: 3ms is acceptable for robot arm

## Potential Challenges

1. **Atan2 implementation**: Most complex function, may need approximation
2. **Multiple solutions**: For given (x,y,z), may have elbow-up/elbow-down configs
3. **Singularities**: When arm is fully extended or at base
4. **Calibration**: Real-world measurements vs theoretical model

## Success Criteria

- ✅ Lookup tables fit in memory
- ✅ IK solution computes in < 10ms
- ✅ Position accuracy within ±5mm
- ✅ Handles reachable workspace correctly
- ✅ Gracefully rejects unreachable targets

## Implementation Todos

1. Measure and document robot arm link lengths (L0, L1, L2, L3) and joint limits
2. Create Python script to generate sin/cos lookup tables with 0.5° resolution
3. Create trig_tables.s with Flash-based sin/cos lookup tables
4. Implement trig_lookup.s with Sin_Lookup, Cos_Lookup, and interpolation
5. Create fixed_point_math.s with multiply, divide, add, subtract operations
6. Implement FP_Sqrt and FP_Atan2 functions for IK calculations
7. Implement inverse_kinematics.s with geometric 4-DOF solution
8. Create motor_commands.s to convert angles to motor steps
9. Integrate IK solver with existing motor_control.s module
10. Create ik_test.s with test points and validation
11. Calibrate physical robot and tune IK parameters for accuracy



