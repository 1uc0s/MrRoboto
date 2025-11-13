# L298N Unipolar Stepper Motor Wiring Guide

## Motor: 9904 112 35014 (Unipolar, 6 terminals)

### Wire Colors (from your motor):
- **Green** = Coil 1
- **Purple** = Coil 2  
- **Blue** = Coil 3
- **Grey** = Coil 4
- **White** = Center tap/common (CRITICAL - must be connected!)

## Problem Diagnosis

**The white wire MUST be connected to +V supply!** 

For unipolar stepper motors, the center tap provides the return path for current. Without it connected to +V, the motor cannot complete the circuit and will not move properly (or at all).

## Correct L298N Wiring for Unipolar Motor

### L298N Pin Connections:
```
L298N Module:
- OUT1 → Green (Coil 1)
- OUT2 → Purple (Coil 2)
- OUT3 → Blue (Coil 3)
- OUT4 → Grey (Coil 4)
- +V Supply → White (Center tap) ⚠️ CRITICAL!
- GND → Common ground
```

### Control Pin Mapping (from PIC):
```
RE0 (IN1) → Controls Coil 1 (Green)
RE1 (IN2) → Controls Coil 2 (Purple)
RE2 (IN3) → Controls Coil 3 (Blue)
RE3 (IN4) → Controls Coil 4 (Grey)
```

## How Unipolar Motors Work with L298N

The L298N has H-bridges, but for unipolar operation:
1. **Center tap (white wire)** connects to **+V supply** (8-12V)
2. **Coil ends** connect to **L298N outputs** (OUT1-OUT4)
3. When an L298N output goes LOW, it sinks current through that coil
4. Current flows: +V → Center tap → Coil → L298N output → GND

## Step Sequence (Wave Drive)

The code uses sequence: **1 → 3 → 2 → 4**

- **Step 1**: Coil 1 (Green) energized → RE0=HIGH, OUT1 sinks current
- **Step 2**: Coil 3 (Blue) energized → RE2=HIGH, OUT3 sinks current  
- **Step 3**: Coil 2 (Purple) energized → RE1=HIGH, OUT2 sinks current
- **Step 4**: Coil 4 (Grey) energized → RE3=HIGH, OUT4 sinks current

## Troubleshooting

### If motor isn't moving:
1. ✅ **Connect white wire to +V supply** (8-12V) - This is likely the issue!
2. ✅ Verify all coil wires are connected to correct L298N outputs
3. ✅ Check that L298N ENA/ENB are enabled (HIGH or connected to +5V)
4. ✅ Verify power supply voltage (8-12V recommended for this motor)
5. ✅ Check that motor power supply GND is connected to PIC GND

### If motor moves but belt doesn't:
- Motor may be moving but not enough torque
- Check belt tension
- Verify motor is properly mounted
- Try increasing power supply voltage (up to 12V)
- Consider using full-step mode (two coils at once) for more torque

## Power Supply Requirements

- **Voltage**: 8-12V DC (motor rated for ~8.5V nominal)
- **Current**: At least 1A (motor draws ~240mA per coil)
- **Connection**: 
  - +V → White wire (center tap)
  - GND → Common ground with PIC and L298N

## Alternative: Full-Step Mode (More Torque)

If wave drive doesn't provide enough torque, you can modify the code to use full-step mode where two coils are energized simultaneously:

```
STEP1: Coil 1 + Coil 2 = 0x03
STEP2: Coil 2 + Coil 3 = 0x06  
STEP3: Coil 3 + Coil 4 = 0x0C
STEP4: Coil 4 + Coil 1 = 0x09
```

This provides ~30% more torque but uses more power.

