# ULN2003A Hardware Setup Guide
## Six Stepper Motor Control with EasyPIC PRO v7

This document provides complete hardware integration details for controlling six 9904-112-35014 stepper motors using ULN2003A Darlington transistor arrays with the EasyPIC PRO v7 development board.

---

## Hardware Compatibility Verification

### ✅ Motor Specifications (9904-112-35014)
- **Current per phase:** 240mA (0.24A)
- **Voltage:** 8-12V (external supply)
- **Resistance:** 47Ω per phase
- **Inductance:** 400mH per phase (inductive load)
- **Configuration:** 6 terminals (unipolar capable)
- **Step angle:** 7.5° (48 steps per revolution)
- **Holding torque:** 8.5 Ncm

### ✅ ULN2003A Driver Specifications
- **Current capacity:** 500mA per channel (240mA needed) ✅
- **Voltage rating:** Up to 50V ✅
- **Built-in flyback diodes:** Yes (critical for inductive loads) ✅
- **Logic compatibility:** 3.3V and 5V ✅
- **Channels:** 7 Darlington pairs per IC
- **Package:** DIP-16, SOIC-16, TSSOP-16

### ✅ EasyPIC PRO v7 Capabilities
- **GPIO availability:** 69 I/O pins (24 needed for 6 motors) ✅
- **Logic levels:** 3.3V or 5V selectable ✅
- **On-board power:** 600mA max (insufficient for motors) ⚠️

---

## Power Supply Requirements

### Critical Power Considerations

**Total Motor Current:** 6 motors × 4 coils × 240mA = **5.76A peak** (when all coils energized)

**Typical Operation:** 6 motors × 2 coils × 240mA = **2.88A** (half-step mode)

### Required External Power Supply

**Specifications:**
- **Voltage:** 8-12V DC (motors rated for 8.5V nominal)
- **Current:** Minimum 2.5A, **recommended 3-4A**
- **Type:** Regulated DC power supply or 12V wall adapter

**Why External Power is Required:**
- EasyPIC PRO v7 maximum output: 600mA (adapter) or 500mA (USB)
- Motors require up to 2.88A during operation
- On-board supply cannot handle motor load

**Power Distribution:**
```
External 8-12V Supply → ULN2003A COM pins → Motor Coils
EasyPIC 5V/3.3V → ULN2003A Input Logic only (low current)
Common GND between EasyPIC and External Supply (REQUIRED)
```

---

## Bill of Materials

| Quantity | Component | Specification | Purpose | Estimated Cost |
|----------|-----------|---------------|---------|----------------|
| 6 | ULN2003A IC | DIP-16 or SOIC-16 | Stepper driver | $2-5 each (~$12-30) |
| 6 | 16-pin IC socket | DIP-16 (optional) | Easy replacement | $0.50 each (~$3) |
| 6 | 9904-112-35014 | Stepper motor | Already owned | - |
| 1 | Power supply | 8-12V, 3-4A DC | Motor power | $15-25 |
| 1 | Breadboard | Large (830 tie points) | Prototyping | $5-10 |
| 1 | Wire jumper kit | Male-male, male-female | Connections | $5-10 |
| 24 | 10kΩ resistors | Optional pull-downs | Signal stability | $1 |
| - | Header pins | - | Motor connections | $2 |
| **Total** | - | - | - | **$45-85** |

---

## Pin Assignments

### ULN2003A Pinout (DIP-16 Package)
```
        ULN2003A
     +-----------+
  1B |1       16| 7C
  2B |2       15| 6C
  3B |3       14| 5C
  4B |4       13| 4C
  5B |5       12| 3C
  6B |6       11| 2C
  7B |7       10| 1C
   E |8        9| COM
     +-----------+

Pins 1-7 (B):  Inputs from microcontroller
Pin 8 (E):     Common emitter (Ground)
Pin 9 (COM):   Common cathode for flyback diodes (Motor supply voltage)
Pins 10-16 (C): Outputs to motor coils
```

### GPIO Port Assignments (PIC18F87K22)

**Motor 1 - PORTA (RA0-RA3)**
```
RA0 → ULN2003A #1 Pin 1 (1B) → Motor 1 Coil A
RA1 → ULN2003A #1 Pin 2 (2B) → Motor 1 Coil B
RA2 → ULN2003A #1 Pin 3 (3B) → Motor 1 Coil C
RA3 → ULN2003A #1 Pin 4 (4B) → Motor 1 Coil D
```

**Motor 2 - PORTB (RB0-RB3)**
```
RB0 → ULN2003A #2 Pin 1 (1B) → Motor 2 Coil A
RB1 → ULN2003A #2 Pin 2 (2B) → Motor 2 Coil B
RB2 → ULN2003A #2 Pin 3 (3B) → Motor 2 Coil C
RB3 → ULN2003A #2 Pin 4 (4B) → Motor 2 Coil D
```

**Motor 3 - PORTC (RC0-RC3)**
```
RC0 → ULN2003A #3 Pin 1 (1B) → Motor 3 Coil A
RC1 → ULN2003A #3 Pin 2 (2B) → Motor 3 Coil B
RC2 → ULN2003A #3 Pin 3 (3B) → Motor 3 Coil C
RC3 → ULN2003A #3 Pin 4 (4B) → Motor 3 Coil D
```

**Motor 4 - PORTD (RD0-RD3)**
```
RD0 → ULN2003A #4 Pin 1 (1B) → Motor 4 Coil A
RD1 → ULN2003A #4 Pin 2 (2B) → Motor 4 Coil B
RD2 → ULN2003A #4 Pin 3 (3B) → Motor 4 Coil C
RD3 → ULN2003A #4 Pin 4 (4B) → Motor 4 Coil D
```

**Motor 5 - PORTE (RE0-RE3)**
```
RE0 → ULN2003A #5 Pin 1 (1B) → Motor 5 Coil A
RE1 → ULN2003A #5 Pin 2 (2B) → Motor 5 Coil B
RE2 → ULN2003A #5 Pin 3 (3B) → Motor 5 Coil C
RE3 → ULN2003A #5 Pin 4 (4B) → Motor 5 Coil D
```

**Motor 6 - PORTF (RF0-RF3)**
```
RF0 → ULN2003A #6 Pin 1 (1B) → Motor 6 Coil A
RF1 → ULN2003A #6 Pin 2 (2B) → Motor 6 Coil B
RF2 → ULN2003A #6 Pin 3 (3B) → Motor 6 Coil C
RF3 → ULN2003A #6 Pin 4 (4B) → Motor 6 Coil D
```

---

## Wiring Diagram

### Complete System Connections

```
EasyPIC PRO v7                  ULN2003A #1              Motor 1
+-------------+                 +-----------+            +-------+
|             |                 |           |            |       |
|  RA0 -------+---------------->| 1B    1C |----------->| Coil A|
|  RA1 -------+---------------->| 2B    2C |----------->| Coil B|
|  RA2 -------+---------------->| 3B    3C |----------->| Coil C|
|  RA3 -------+---------------->| 4B    4C |----------->| Coil D|
|             |                 |           |            |       |
|  GND -------+---------------->| E     COM|<---+       +-------+
|             |                 |           |    |
+-------------+                 +-----------+    |
                                                 |
                                      External Power Supply
                                         8-12V, 2-3A
                                      +-------------+
                                      |    +V   GND |
                                      +-----|-------|+
                                            |       |
                                            |       +---> Common GND
                                            |
                                            +----------> All COM pins (pin 9)

(Repeat for ULN2003A #2, #3, #4, #5, #6 with respective ports)
```

### Physical Connection Steps

1. **Connect ULN2003A to Breadboard**
   - Place each ULN2003A IC on breadboard
   - Ensure proper orientation (notch at top)

2. **Connect Power and Ground**
   - Connect all ULN2003A pin 8 (E) to common ground rail
   - Connect all ULN2003A pin 9 (COM) to +8-12V rail from external supply
   - Connect EasyPIC GND to common ground rail
   - **DO NOT** connect external +8-12V to EasyPIC VCC

3. **Connect Control Signals**
   - Use IDC10 headers on EasyPIC for easy port access
   - Connect RA0-RA3 to ULN2003A #1 pins 1-4
   - Connect RB0-RB3 to ULN2003A #2 pins 1-4
   - Connect RC0-RC3 to ULN2003A #3 pins 1-4
   - Connect RD0-RD3 to ULN2003A #4 pins 1-4
   - Connect RE0-RE3 to ULN2003A #5 pins 1-4
   - Connect RF0-RF3 to ULN2003A #6 pins 1-4

4. **Connect Motors**
   - Identify motor coils (use ohmmeter: ~47Ω between coil pairs)
   - Connect coils to ULN2003A outputs (pins 10-13)
   - Typical 6-terminal unipolar wiring:
     ```
     Terminal 1 & 2 → Coil A (ULN2003A 1C)
     Terminal 3 & 4 → Coil B (ULN2003A 2C)
     Terminal 5 & 6 → Coil C (ULN2003A 3C)
     Common center tap → Connect to external +V
     ```

---

## Motor Connection Details

### 6-Terminal Unipolar Configuration

The 9904-112-35014 motors have 6 terminals for unipolar operation:

```
Motor Terminal Layout:
  1 ○──────────────○ 2    Coil A
                |
              Center
                |
  3 ○──────────────○ 4    Coil B
                |
              Center
                |
  5 ○──────────────○ 6    Coil C
                |
              Center
                |
              To +V Supply
```

**Unipolar Connection (Recommended):**
- Terminals 1, 3, 5: Connect to ULN2003A outputs 1C, 2C, 3C
- Terminals 2, 4, 6: Connect to external +8-12V supply
- ULN2003A sinks current through one half of each coil

**Testing Motor Coils:**
Use multimeter to measure resistance:
- Between terminal pairs: ~47Ω (same coil)
- Between different coils: ~94Ω (through center tap)

---

## Assembly Code Interface

### Control Strategy

**Wave Drive (Simplest - One coil at a time):**
```assembly
; Step sequence for wave drive
WAVE_STEPS:
    DB  0b00000001  ; Coil A
    DB  0b00000010  ; Coil B
    DB  0b00000100  ; Coil C
    DB  0b00001000  ; Coil D
```

**Full Step (Two coils at a time - More torque):**
```assembly
; Step sequence for full step
FULL_STEPS:
    DB  0b00000011  ; Coil A + B
    DB  0b00000110  ; Coil B + C
    DB  0b00001100  ; Coil C + D
    DB  0b00001001  ; Coil D + A
```

**Half Step (Best resolution):**
```assembly
; Step sequence for half-step
HALF_STEPS:
    DB  0b00000001  ; Coil A
    DB  0b00000011  ; Coil A + B
    DB  0b00000010  ; Coil B
    DB  0b00000110  ; Coil B + C
    DB  0b00000100  ; Coil C
    DB  0b00001100  ; Coil C + D
    DB  0b00001000  ; Coil D
    DB  0b00001001  ; Coil D + A
```

### Basic Motor Control Example

```assembly
; Motor control registers
MOTOR1_STEP     EQU 0x20    ; Current step index for motor 1
MOTOR2_STEP     EQU 0x21
MOTOR3_STEP     EQU 0x22
MOTOR4_STEP     EQU 0x23
MOTOR5_STEP     EQU 0x24
MOTOR6_STEP     EQU 0x25

; Initialize ports as outputs
INIT_MOTORS:
    CLRF    TRISA       ; PORTA all outputs (Motor 1)
    CLRF    TRISB       ; PORTB all outputs (Motor 2)
    CLRF    TRISC       ; PORTC all outputs (Motor 3)
    CLRF    TRISD       ; PORTD all outputs (Motor 4)
    CLRF    TRISE       ; PORTE all outputs (Motor 5)
    CLRF    TRISF       ; PORTF all outputs (Motor 6)
    
    CLRF    PORTA       ; All motors off
    CLRF    PORTB
    CLRF    PORTC
    CLRF    PORTD
    CLRF    PORTE
    CLRF    PORTF
    
    CLRF    MOTOR1_STEP ; Reset step counters
    CLRF    MOTOR2_STEP
    CLRF    MOTOR3_STEP
    CLRF    MOTOR4_STEP
    CLRF    MOTOR5_STEP
    CLRF    MOTOR6_STEP
    RETURN

; Step Motor 1 forward one step
STEP_MOTOR1_FWD:
    MOVF    MOTOR1_STEP, W
    CALL    GET_STEP_PATTERN
    MOVWF   PORTA           ; Output to motor 1
    
    INCF    MOTOR1_STEP, F  ; Next step
    MOVLW   0x04            ; 4 steps in full-step mode
    CPFSEQ  MOTOR1_STEP
    RETURN
    CLRF    MOTOR1_STEP     ; Wrap around
    RETURN

; Get step pattern from table
GET_STEP_PATTERN:
    ADDWF   PCL, F          ; Computed goto
    DB      0b00000011      ; Step 0: A+B
    DB      0b00000110      ; Step 1: B+C
    DB      0b00001100      ; Step 2: C+D
    DB      0b00001001      ; Step 3: D+A
```

### Timing Considerations

**Step Rate Calculation:**
- Motor spec: 7.5° per step = 48 steps per revolution
- Maximum step rate: ~1000 steps/second (from ULN2003A datasheet)
- Recommended step rate: 200-400 steps/second for smooth operation
- Delay between steps: 2.5-5ms minimum

**Timer-Based Stepping:**
```assembly
; Using Timer0 for step timing (5ms period)
; Fosc = 16MHz, Prescaler = 256
; Timer0 reload value = 256 - (5ms × 16MHz / (4 × 256)) = 256 - 78 = 178

INIT_TIMER0:
    MOVLW   b'10000111'     ; TMR0ON=1, 8-bit, prescaler=256
    MOVWF   T0CON
    MOVLW   178
    MOVWF   TMR0L
    RETURN

TMR0_ISR:
    MOVLW   178
    MOVWF   TMR0L           ; Reload timer
    
    CALL    STEP_MOTOR1_FWD ; Step each motor
    CALL    STEP_MOTOR2_FWD
    CALL    STEP_MOTOR3_FWD
    CALL    STEP_MOTOR4_FWD
    CALL    STEP_MOTOR5_FWD
    CALL    STEP_MOTOR6_FWD
    
    BCF     INTCON, TMR0IF  ; Clear flag
    RETFIE  FAST
```

---

## Testing and Troubleshooting

### Initial Testing Procedure

**1. Power Supply Test**
```assembly
; Test: All coils off
CLRF    PORTA
CLRF    PORTB
CLRF    PORTC
CLRF    PORTD
CLRF    PORTE
CLRF    PORTF
; Measure: ULN2003A outputs should be at supply voltage (~8-12V)
```

**2. Single Coil Test**
```assembly
; Test: Energize one coil at a time
MOVLW   0b00000001
MOVWF   PORTA       ; Motor 1, Coil A should energize
; Measure: ULN2003A output should drop to ~1V
; Listen: Motor should produce audible click and resist rotation
```

**3. Step Sequence Test**
```assembly
; Test: Manual stepping
MAIN_LOOP:
    MOVLW   0b00000011
    MOVWF   PORTA
    CALL    DELAY_500MS
    
    MOVLW   0b00000110
    MOVWF   PORTA
    CALL    DELAY_500MS
    
    MOVLW   0b00001100
    MOVWF   PORTA
    CALL    DELAY_500MS
    
    MOVLW   0b00001001
    MOVWF   PORTA
    CALL    DELAY_500MS
    
    GOTO    MAIN_LOOP
; Observe: Motor should rotate slowly, ~30 RPM
```

### Common Issues and Solutions

| Problem | Possible Cause | Solution |
|---------|----------------|----------|
| Motor doesn't move | No power to motor | Check external supply, COM pins |
| Motor vibrates | Wrong step sequence | Verify coil connections, check sequence |
| Motor runs hot | Continuous energization | Implement idle state, reduce current |
| Erratic movement | Noisy signals | Add 10kΩ pull-downs on inputs |
| Weak torque | Insufficient current | Check power supply capacity |
| Motor skips steps | Stepping too fast | Reduce step rate, increase delays |

### Voltage Measurements

**Expected Voltages (with 12V supply):**
- ULN2003A input (inactive): 0V
- ULN2003A input (active): 3.3V or 5V (from EasyPIC)
- ULN2003A output (OFF): ~11-12V (supply voltage)
- ULN2003A output (ON): ~1-1.5V (VCE saturation)
- Motor coil voltage (energized): ~10-11V (Supply - VCE)
- Motor coil current (energized): ~240mA per coil

---

## Safety and Best Practices

### Electrical Safety
- ⚠️ **Always connect common ground** between EasyPIC and external supply
- ⚠️ **Never connect external motor supply to EasyPIC VCC**
- ⚠️ **Verify voltage polarity** before powering on
- ⚠️ **Use current-limited power supply** (2-3A max)
- ⚠️ **Add fuse protection** (3A fast-blow recommended)

### Assembly Best Practices
- Use IC sockets for ULN2003A (easy replacement if damaged)
- Secure all connections with proper wire management
- Keep motor wires away from logic signals (noise)
- Use shielded cable for motors if wires exceed 30cm
- Label all connections clearly

### Software Best Practices
- Always initialize motors to OFF state on startup
- Implement gradual acceleration/deceleration
- Add timeout protection for continuous operation
- Monitor step count to prevent mechanical binding
- Use interrupts for precise timing

### Motor Protection
- Don't exceed 300mA per coil (motors rated 240mA)
- Limit continuous operation duration (motors can heat up)
- Implement idle state when not stepping (de-energize coils)
- Monitor motor temperature during extended operation

---

## Performance Specifications

### Achievable Performance

**Step Resolution:**
- Wave drive: 48 steps/revolution (7.5°/step)
- Full step: 48 steps/revolution (7.5°/step)
- Half step: 96 steps/revolution (3.75°/step)

**Speed Range:**
- Minimum: ~1 RPM (limited by software timing)
- Maximum: ~250 RPM @ 200 steps/sec (recommended)
- Theoretical max: ~1250 RPM @ 1000 steps/sec (may skip steps)

**Torque:**
- Holding torque: 8.5 Ncm (85 mNm)
- Running torque: ~6-7 Ncm (depends on speed)

**Positioning Accuracy:**
- ±7.5° (full step mode)
- ±3.75° (half step mode)

---

## Further Reading

### Datasheets
- [ULN2003A Datasheet](Uln2003a%20Darlington%20Transistor%20Array.md)
- [EasyPIC PRO v7 Manual](easypic-pro-v7-manual-v101.md)
- [330510 Motor Specifications](330510%20Motor.md)

### Application Notes
- Texas Instruments: "Driving Stepper Motors with ULN200x"
- Microchip AN822: "Stepper Motor Microstepping with PIC18F MCUs"

### Related Documentation
- [PIC18F87K22 Datasheet](https://www.microchip.com/PIC18F87K22)
- [Assembly Programming Guide](3_Assembly_2.md)

---

## Revision History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 2025-01-XX | Initial hardware setup guide |

---

**Document prepared for:** MrRoboto Project  
**Target Hardware:** EasyPIC PRO v7 + 6× 9904-112-35014 Stepper Motors  
**Driver:** 6× ULN2003A Darlington Arrays  
**Power:** External 8-12V, 3-4A supply

