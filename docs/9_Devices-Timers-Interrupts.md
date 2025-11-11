# 

---

## Page 1

Mark Neil - Microprocessor Course

1

Timers and Interrupts


---

## Page 2

Example Product: Signal Generator

Mark Neil - Microprocessor Course

2

! A Signal Generator should be programmable.

! A user can use the the LCD display and the keyboard to change the:

¡ Frequency scale

¡ Amplitude scale

¡ Offset on/off etc.

¡ Waveform shape (Square, Sinusoidal, Triangle..)

! Analog control given by potentiometer

! Analog signal output by using a Digital to Analog Converter (DAC)


---

## Page 3

Digital to Analog

Conversion

Digital data representing an

analog signal (for instance an

audio file) sampled at a (usually)

fixed time interval is fed to a

Digital to Analog Converter

The output is an analog

waveform which is an

approximation to the required

analog signal

Output should be generated at

correct points in time to

reproduce the required signal

Digital

Signal Data

Digital to

Analog

Conversion

### (DAC)

Output

“Sampled”

Analog

Waveform

3

Mark Neil - Microprocessor Course


---

## Page 4

Timing: a ripple

counter with D-type

flip-flops

Q* output is fed back to the D

input on each D-type latch and

to the clock input on the

following latch.

Each D-type output flip-flops

between high and low, halving

the frequency each step along

the chain.

Outputs Q0 to Q3 give a 4 bit

counter from 0x0 to 0xF…

… and then to 0x0

4

Mark Neil - Microprocessor Course


---

## Page 5

Timers and

counters on

### PIC18F87K22

PIC18F87K22 has 6 8-bit

counter/timers and 5 16-bit

counter/timers.

Each is programmable via

control registers to perform a

wide variety of different

functions:

Count-up, different clock

sources, time external events

(input capture), provide timed

output waveforms (PWM), etc.

And as a source of interrupts!

5

Mark Neil - Microprocessor Course

T0CKI Pin

### T0SE

0

1

1

0

### T0CS

### FOSC/4

Sync with

Internal

Clocks

### TMR0L

(2 TCY Delay)

Internal Data Bus

8

### PSA

### T0PS<2:0>

Set

### TMR0IF

on Overflow

3

### TMR0

### TMR0H

High Byte

8

8

8

Read TMR0L

Write TMR0L

8

Programmable

Prescaler

T0CKI Pin

### T0SE

0

1

1

0

### T0CS

### FOSC/4

Programmable

Prescaler

Sync with

Internal

Clocks

### TMR0L

(2 TCY Delay)

Internal Data Bus

### PSA

### T0PS<2:0>

Set

### TMR0IF

on Overflow

3

8

8

TIMER0 8-bit mode

TIMER0 16-bit mode


---

## Page 6

Processor Interrupts

! Interrupts are subroutine calls initiated not by a call command but by

hardware signals.

! These hardware signals cause the processor to jump to interrupt service

routines.

! At the end they return control to your program to exactly where it was

just before the interrupt occurred.

Mark Neil - Microprocessor Course

6


---

## Page 7

The Need for Processor Interrupts

! Up to now if you wanted to do something in a program as soon as a bit

was set (key pressed, bit set in a register, voltage exceeded a given

threshold,…) you had to keep reading the bit until it changed !

¡ This is called Polling

! This is clearly not an efficient way of doing things

¡ CPU time is wasted watching for something to happen

! This is why interrupts were introduced as a means of getting the

processor’s attention on demand

¡ Use the CPU for other things until whatever we were waiting for happens

Mark Neil - Microprocessor Course

7


---

## Page 8

PIC18 Timers and Interrupts

### TMR0IE

### GIE/GIEH

### PEIE/GIEL

Wake-up if in

Interrupt to CPU

Vector to Location

0008h

### INT2IF

### INT2IE

### INT2IP

### INT1IF

### INT1IE

### INT1IP

### TMR0IF

### TMR0IE

### TMR0IP

### RBIF

### RBIE

### RBIP

### IPEN

### TMR0IF

### TMR0IP

### INT1IF

### INT1IE

### INT1IP

### INT2IF

### INT2IE

### INT2IP

### RBIF

### RBIE

### RBIP

### INT0IF

### INT0IE

### PEIE/GIEL

Interrupt to CPU

Vector to Location

### IPEN

### IPEN

0018h

### PIR1<7:0>

### PIE1<7:0>

### IPR1<7:0>

High-Priority Interrupt Generation

Low-Priority Interrupt Generation

Idle or Sleep modes

### GIE/GIEH

### INT3IF

### INT3IE

### INT3IP

### INT3IF

### INT3IE

### INT3IP

### PIR2<7,5:0>

### PIE2<7,5:0>

### IPR2<7,5:0>

### PIR3<7,5>

### PIE3<7,5>

### IPR3<7,5>

### PIR1<7:0>

### PIE1<7:0>

### IPR1<7:0>

### PIR2<7, 5:0>

### PIE2<7, 5:0>

### IPR2<7, 5:0>

### PIR3<7, 5:0>

### PIE3<7, 5:0>

### IPR3<7, 5:0>

### IPEN

### PIR4<7:0>

### PIE4<7:0>

### IPR4<7:0>

### PIR5<7:0>

### PIE5<7:0>

### IPR5<7:0>

### PIR6<4, 2:0>

### PIE6<4, 2:0>

### IPR6<4, 2:0>

### PIR4<7:0>

### PIE4<7:0>

### IPR4<7:0>

### PIR5<7:0>

### PIE5<7:0>

### IPR5<7:0>

### PIR6<4, 2:0>

### PIE6<4, 2:0>

### IPR6<4, 2:0>

! There are 42 sources of

interrupt on the PIC18F87K22

! Timers on the PIC8 can be used to

trigger an interrupt at fixed intervals

! Interrupts can be triggered when

certain hardware tasks are

completed, eg ADC, UART etc

! External inputs can be used to

request an interrupt by changing the

logic level on an input pin

! Communications peripherals can

cause interrupts when they have

received new data

Mark Neil - Microprocessor Course

8


---

## Page 9

Interrupt vectors

! Place your interrupt code at the

interrupt vector address

¡ use a goto, bra or call instruction if

using both high and low priority

interrupts

! Check what the source of the

interrupt was and execute the

appropriate code

! Return from the interrupt routine

with the special retfie command

! High-priority interrupts cause a FAST

call

¡ Status, W and BSR are saved in shadow

registers

¡ Restored with retfie f command

Mark Neil - Microprocessor Course

9

! Interrupts cause the execution of code

to jump to one of two locations

! 0x0008 - High-priority interrupts

! 0x0018 - Low-priority interrupts

! High-priority interrupts can interrupt

low-priority ones

! Multiple sources can call the same High

or Low priority interrupts

¡ Your interrupt code must determine which

one has made the call using interrupt flags


---

## Page 10

Setting up interrupts for a peripheral

! A peripheral (TIMER0 say) will have a bunch of SFRs that configure its operation

¡ T0CON = 10000111 ⇒TIMER0 on, 16-bit, clock source=Fosc/4/256=62.5 KHz

! You will need to enable TIMER0 interrupts by setting the TMR0IE bit in the  INTCON

### SFR

¡ bsf TMR0IE

! And also globally enable all interrupts (with high priority) by setting the GIE bit in

### INTCON

¡ bsf GIE

! TIMER0 will count upwards at the selected clock rate and when its value rolls over

from 0xFFFF to 0x0000 an interrupt will be generated

! The TMR0IF bit in INTCON register signals that a TIMER0 interrupt has occurred

! You need to reset TMR0IF to 0 in the interrupt routine or the interrupt will continue

to be triggered

Mark Neil - Microprocessor Course

10


---

## Page 11

Timer/Counter0 Control Register

! TMR0ON: Turn on TIMER0

! T08BIT: Select 8-bit or 16-bit operation

! T0CS: Choose external (=1) or internal (=0) clock Fosc/4

! T0SE: Clock edge if using external clock

! PSA: Choose prescaler (=0) or to bypass (=1)

! The timer pre-scale factor : T0PS2; T0PS1; T0PS0

Mark Neil - Microprocessor Course

11

### D7

### D6

### D5

### D4

### D3

### D2

### D1

### D0

### TMR0ON

### T08BIT

### T0CS

### T0SE

### PSA

### T0PS2

### T0PS1

### T0PS0

### TCON0


---

## Page 12

Timer0 clock prescaler

Mark Neil - Microprocessor Course

12

T0CKI Pin

### T0SE

0

1

1

0

### T0CS

### FOSC/4

Sync with

Internal

Clocks

### TMR0L

(2 TCY Delay)

Internal Data Bus

8

### PSA

### T0PS<2:0>

Set

### TMR0IF

on Overflow

3

### TMR0

### TMR0H

High Byte

8

8

8

Read TMR0L

Write TMR0L

8

Programmable

Prescaler

### PSA

### T0PS2

### T0PS1

### T0PS0

Fcyc = Fosc/4 = 16 MHz

1

x

x

x

Fcyc = 16 MHz

0

0

0

0

Fcyc/2 = 8 MHz

0

0

0

1

Fcyc/4 = 4 MHz

0

0

1

0

Fcyc/8 = 2 MHz

0

0

1

1

Fcyc/16 = 1 MHz

0

1

0

0

Fcyc/32 = 500 KHz

0

1

0

1

Fcyc/64 = 250 KHz

0

1

1

0

Fcyc/128 = 125 KHz

0

1

1

1

Fcyc/256 = 62.5 KHz


---

## Page 13

INTCON Register

! GEI/GEIH: Global (high priority if IPEN=1) interrupt enable

! PEIE/GEIL: Peripheral (low-priority if IPEN=1) interrupt enable

! TMR0IE: Timer0 interrupt enable

! TMR0IF: Timer0 interrupt flag

! Some peripherals need other bits to be set (INTCON:PEIE)

! Individual peripheral enable bits can be found in PIE* registers and their

flags in PIR* registers

! For low priority interrupts set RCON:IPEN and individual priority levels in

IPR* registers

Mark Neil - Microprocessor Course

13

### D7

### D6

### D5

### D4

### D3

### D2

### D1

### D0

### GIE/GIEH

### PEIE/GIEL

### TMR0IE

### INT0IE

### RBIE

### TMR0IF

### INT0IF

### RBIF

### INTCON


---

## Page 14

Simple interrupt

example

In your main program you need

to put a goto at the hi-priority

interrupt vector address 0x0008

The program needs to call the

DAC_Setup routine to setup

the timer, interrupt and output

port

After that it just does nothing

with a goto $

The timer interrupt executes a

call to the interrupt vector

address which then jumps to the

interrupt code in the

DAC_Interrupt module.

main.s

#include <xc.inc>

extrn

DAC_Setup, DAC_Int_Hi

psect

code, abs

rst:

org

0x0000

; reset vector

goto

start

int_hi:

org

0x0008

; high vector, no low vector

goto

DAC_Int_Hi

start:

call

DAC_Setup

goto

$

; Sit in infinite loop

end

rst

14

Mark Neil - Microprocessor Course


---

## Page 15

Simple interrupt

example

When calling a high-priority

interrupt the PIC18 does a “Fast”

call, saving the W, STATUS and BSR

registers in shadow registers WS,

STATUSS and BSRS

Use  retfie f to put the

shadow register contents back

If using low-priority interrupts you

must do this yourself!

Use Git to checkout the simple

interrupt example as branch:

Simple_Interrupt_V5.4

Run it on the EasyPic Pro board

and you should see RJ0 blink at

about 0.5Hz.

DAC_Interrupt.s

#include <xc.inc>

global

DAC_Setup, DAC_Int_Hi

psect

dac_code, class=CODE

DAC_Int_Hi:

btfss

### TMR0IF

; check that this is timer0 interrupt

retfie

f

; if not then return

incf

### LATJ, F, A

; increment PORTJ

bcf

### TMR0IF

; clear interrupt flag

retfie

f

; fast return from interrupt

DAC_Setup:

clrf

### TRISJ, A

; Set PORTJ as all outputs

clrf

### LATJ, A

; Clear PORTJ outputs

movlw

### 10000111B

; Set timer0 to 16-bit, Fosc/4/256

movwf

T0CON, A ; = 62.5KHz clock rate, approx 1sec rollover

bsf

### TMR0IE

; Enable timer0 interrupt

bsf

### GIE

; Enable all interrupts

return

15

Mark Neil - Microprocessor Course


---

## Page 16

You need to be careful using Interrupt Service Routines

! Interrupts can occur at any time

¡ They are asynchronous to the operation of the rest of your program

! Your program may be doing something else important

¡ The interrupt service routine should leave the program in a state so that in can continue running

after the retfie

¡ Make sure to save and restore any special registers that you use (eg FSRs, TABLAT, PRODH:PRODL)

÷ High-priority interrupts will save copies of W, STATUS and BSR

÷ For low-priority interrupts you need to do this yourself

÷ Only if you can guarantee that you are not using a register elsewhere in your program can you avoid saving

and restoring

÷ Very unpredictable effects can happen if you don’t do this

! General Hints

¡ Keep the service routines short – don’t do any heavy computation, don’t do long and involved I/O if

you can avoid it

¡ Better to simply flag that the interrupt has happened so that elsewhere in your program you can

deal with it

¡ Make sure you reset your interrupt flags before returning or you will jump straight back into the

interrupt routine again

Mark Neil - Microprocessor Course

16


---

## Page 17

Task Plan

! Design and construct a Signal Generator

! Start by modifying branch Simple_Interrupt

! Later you could add the DAC_Interrupt module to your current project

! The signals should be produced using a DAC and an Operational Amplifier driven by

one of the PIC18 ports.

! Using the supplied code connect your DAC to PORTJ and wire WR* line to GND for

continuous updates

! Use the timed interrupts to generate a saw-tooth waveform

! Modify the timer setup to get much faster interrupts for generating higher frequency

signals

¡ Consider reducing prescaler and/or running TIMER0 in 8-bit mode

¡ Audio signals typically use a 44.1kHz sample rate

Mark Neil - Microprocessor Course

17


---

## Page 18

Extras if you have time…

! Signal generator with potentiometer control of frequency and/or

amplitude

! Write a module that uses a timed interrupt to output a signal of choice

from a look-up table

¡ Square, triangle or sine wave from a look-up table

! Main program reads in analog value on potentiometer and changes

period of counter or increments appropriately to control frequency

! Main program can also use keyboard and LCD to change modes

¡ Eg amplitude control instead of frequency

¡ Different waveform shapes

Mark Neil - Microprocessor Course

18


---

## Page 19

CCP modules - better timer control

! Waiting for Timer0 counter to roll over from 0xFFFF to 0x0000 is not very

flexible even though you have several pre-scaler choices

¡ Could reload a starting count to Timer0 in the interrupt routine

¡ but may not be accurate because of interrupt latency (>2 instruction cycles)

! Or you could do it in hardware with a Capture/Compare/PWM module

¡ Can record the value of the timer based on a hardware trigger (capture)

¡ Can trigger something else (an interrupt) when the timer reaches a certain value (compare)

¡ Can produce pulse-width modulated signals (PWM)

! PIC18F87K22 has 7 CCP modules (CCP4-CCP10) and 3 enhanced CCP

modules (ECCP1-ECCP3)

! CCP/ECCP modules only work with certain timers

¡ Not Timer0 unfortunately!

Mark Neil - Microprocessor Course

19


---

## Page 20

Set up Timer1

Set up CCP4

! T1CON controls Timer1 operation

! Bits TMR1CS1:0 select clock source,

choose 00 for Fosc/4=16MHz

! Bits T1CKPS1:0 sets clock prescale,

choose 11 for ÷8, giving 2MHz update

or 500 ns period steps

¡ Max period timeout=32.7675 ms

! Turn timer1 on by setting bit TMR1ON

! CCP4CON controls CCP4 operation

! Compare mode: Special Event Trigger;

reset timer on CCP4 match (CCP4IF bit

is set in PIR4)

¡ Bits CCP4M3:0=1011

! Select Timer1 in CCPTMRS1 (note

register is not in access ram)

¡ Bits C4TSEL1:0=00

! CCPR4H:CCPR4L period registers hold

the 16-bit compare match value

! Set interrupt enable bit CCP4IE in PIE4

register

! Set both PEIE and GIE bits in INTCON0

Programming a variable timeout interrupt with Timer1 and CCP4

Mark Neil - Microprocessor Course

20


---

## Page 21

Alternative DAC

Operation for single

supply 5V operation

The ladder can be operated in reverse

by applying a reverence voltage at

OUT1.

An analog output voltage now

appears on the Vref pin.

Use an op-amp to buffer the output

voltage

For 0 and +5V supplies this only

works with Vref≤2.5V

An op-amp that can take inputs over

the full 0V to +5V range and drive its

outputs over the same range is

required.

The op-amp should be configured for

a gain of +2 to get the full 0V to +5V

output range

This is known as a rail-to-rail op-amp

21

Mark Neil - Microprocessor Course

### R

1

0

REF (Analog Output Voltage)

### OUT2

OUT1 (Fixed Input Voltage)

### R

### R

### R

### 2R

### 2R

### 2R

### 2R

Figure 1. Voltage Mode Operation

From TLC2547 datasheet

Example of a 4-bit

0-10V (nominal) DAC


---

## Page 22

DAC Schematic –

voltage mode

Here we use a 3-pin +2.5V

voltage reference MCP1525 as

input at pin OUT1

A 1-10µF capacitor is

recommended at the output of

the voltage source for stability.

(0.1µF is a little noisy but OK)

The output from REF pin is

connected to a x2 non-inverting

amplifier.

Use an OPA350 for the op-amp

with oV and +5V supply

Output voltage range is now oV

to +5V.

22

Mark Neil - Microprocessor Course

CS* : keep it enabled

### TLC7524

### OUT1

1

### OUT2

2

### RF B

16

### REF

15

### DB0

11

### DB1

10

### DB2

9

### DB3

8

### DB4

7

### DB5

6

### DB6

5

### DB7

4

### WR

13

### CS

12

741

−

+

30pf

Output Voltage

100 ⌦

100 ⌦

### VCC

8 bit input data

From ATMEL PORT

Write Enable*

### VSS

### VIN

### VOUT

3

1 2

### VSS

### VOUT

### VIN

### VDD

### MCP1525

### MCP1541

+

### VIN

### VOUT

### RG

### RF

For gain x2

RF=RG=10kΩ

### OPA350

8-bit input data

from Pic PORT

1µF to 10µF recommended


---

