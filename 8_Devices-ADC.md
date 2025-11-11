# 

---

## Page 1

A n a l o g  t o  D i g i t a l  C o n v e r s i o n  - A D C

Mark Neil - Microprocessor Course

1

Device Drivers – Measuring Voltages


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

! We are also going to do look at some more complex numerical

calculations


---

## Page 3

Analog to Digital Converters

Mark Neil - Microprocessor Course

3

An ANALOG to DIGITAL CONVERTER (ADC) is a

device that measures analog signals and convert them to

digital (binary) numbers:

12-bit

### ADC

output

12-bit

Number

sequence

Higher Voltage Ref.

Lower Voltage Ref.

Input

Signal

Input

### D11

### D0


---

## Page 4

PIC18 12-bit ADC

internals

You can select from many different

input sources

Actually measures the difference

between 2 inputs - one can be zero,

and the difference can be negative

You can also select the upper and

lower voltage references

The A/D convertor itself is a

successive approximation

convertor consisting of a 12-bit

D/A convertor and conversion

logic

Takes 12 steps to complete

conversion and provide a 12-bit

result (13-bit if you include sign)

### VREF+

Reference

Voltage

### VNCFG

### CHS<4:0>

### AN23(1)

### AN22(1)

### AN4

### AN3

### AN2

### AN1

### AN0

10111

10110

00100

00011

00010

00001

00000

12-Bit

### A/D

### VREF-

### VSS(2)

Converter

1.024V Band Gap

### VDDCORE

Reserved CTMU

(Unimplemented)

11111

11110

11101

11100

11011

11010

11001

11000

(Unimplemented)

(Unimplemented)

(Unimplemented)

Negative Input Voltage

Positive Input Voltage

### CHSN<2:0>

### AN6

### AN5

### AN0

### AVSS

111

110

001

000

### AN2

### VCFG<1:0>

### AN3

### VDD

11

10

01

00

Internal VREF+

### (4.096V)

Internal VREF+

### (2.048V)

Reserved

Temperature Diode

4

Mark Neil - Microprocessor Course


---

## Page 5

The ADC Registers I

Mark Neil - Microprocessor Course

5

! The 12-bit ADC on PIC18F87K22 receives its inputs from PORTs A, F,

G, and H.

! The Reference voltage can be provided externally or by an internal

voltage reference of either 2.048V or 4.096V

! The device can be controlled by several special function registers:

### ¡ ADCON0:2

: ADC control registers

### ¡ ANCON0:2

: Analog selection registers (makes pins either analog or digital)

### ¡ TRIS

: Tris-state registers turn digital outputs off

### ¡ ADRESL

: Data Register for D0-D7

### ¡ ADRESH

: Data Register for D11-D8


---

## Page 6

Hardware

We need to connect an analog

voltage to pin RA0 (or AN0 as it

is called as an analog input)

You can do this using the on

board potentiomenter on the

EasyPic Pro board – remember

to set the jumper to connect this

to RA0

Or you can wire your own

directly using the external proto-

board, which has nicer

potentiometers

You may want to turn off the

LEDs for PORTA so that they do

not load your analog circuit too

much

6

Mark Neil - Microprocessor Course


---

## Page 7

ADC.s Routines

Checkout branch:

ADC_test_measurement_V5.4

One routine to set up the ADC

One routine to trigger a

measurement

Result appears in registers

### ADRESH:ADRESL

#include <xc.inc>

global

ADC_Setup, ADC_Read

psect

adc_code, class=CODE

ADC_Setup:

bsf

### TRISA, PORTA_RA0_POSN, A

; pin RA0==AN0 input

banksel

### ANCON0

; ANCON0 is not in access ram

bsf

### ANSEL0

; set AN0 to analog

movlw

0x01         ; select AN0 for measurement

movwf

### ADCON0, A

; and turn ADC on

movlw

0x30         ; Select 4.096V positive reference

movwf

### ADCON1, A

; 0V for -ve reference and -ve input

movlw

0xF6         ; Right justified output

movwf

### ADCON2, A

; Fosc/64 clock and acquisition times

movlb

0

; restore BSR to 0

return

ADC_Read:

bsf

GO   ; Start conversion by setting GO bit in ADCON0

adc_loop:

btfsc

### GO

; check to see if finished

bra

adc_loop

return

7

Mark Neil - Microprocessor Course


---

## Page 8

Using git to merge ADC of code into your project

Mark Neil - Microprocessor Course

8

! You can download and run the new code directly using git-checkout directly

! But better still you can merge this into your current code (to which you will

have hopefully added some of your own routines already) using git-merge

! Merging is an important feature of Git that allows multiple people to work on

the same project, developing and testing bits of code in different branches

that are then merged together

¡ Choose Git/Branch/Merge-Revision menu option

¡ Select the most recent revision of the ADC_test_measurement branch to merge into your

current branch

¡ You may be asked to fix a few conflicts by hand!


---

## Page 9

New code on Github – ADC_test_measurement

Mark Neil - Microprocessor Course

9

! ADC routines have been included in Git branch “ADC_test_measurement”

which also includes a hex display routine in the LCD code

! You will also find a new data block in the LCD code:

### PSECT

udata_acs_ovr,space=1,ovrld,class=COMRAM

LCD_hex_tmp:

ds 1    ; reserve 1 byte for variable LCD_hex_tmp

! The  ovrld keyword defines a region of memory that can be reused

(overlayed)

¡ Use this for temporary variables that you only use for a short while

¡ Be careful though as other routines in your code might be using the same memory locations!


---

## Page 10

Displaying the result

Mark Neil - Microprocessor Course

10

! Output from the ADC is a 12 bit number

representing the measured voltage

! Max digital number is

¡ 0x0FFF

! Resolution of the system is one bit or

¡ 0x0001

! Of course, we could always display a

hexadecimal number e.g.

¡ 0x03E8

! Even then we need to convert our 12-bit

number to the ascii codes for

hexadecimal digits

¡ Which is relatively easy

! This bit has been done for you…

! We would like to display the measured

voltage, which with a 4.096V reference

! Gives a maximum measured voltage

### ¡ 4.095 V

! Which in terms of voltage is

¡ 1 mV

! But it would be much better to display

the equivalent voltage

### ¡ 1.000 V

! But here we need to convert to base 10 in

order to pick out the individual decimal

digits

¡ Which is not so straight forward!

! … but you will write this yourselves


---

## Page 11

Converting 12-bits to decimal

Mark Neil - Microprocessor Course

11

! Suppose we want to take the hex value 0x03e8 to its decimal

equivalent 1000 then we can start by multiplying by a constant k such

that the most significant digit is correct and all other digits are zero

0x03e8 × k = 0x10000

! So to do this choose k=0x10000/0x03e8=65536/1000=65.536

! We can take the 1 in the most significant byte (MSB) and use that as

our most significant decimal digit

! After that we are left with a remainder of zero so our next three decimal

digits can only be zeros too


---

## Page 12

So what happens with other values?

Mark Neil - Microprocessor Course

12

! Suppose our measured value is 1234 mV, a

hex value of 0x04D2

! Multiply by k

! Take 1 as the most significant decimal digit

leaving a remainder of 0x3BE8

! Multiply by 10

! Take 2 as next decimal digit, leaving 0x5710

! Multiply by 10

! Take 3 as next decimal digit, leaving 0x66A0

! Multiply by 10 again

! Take 4 as final decimal digit

Step 1

0x04D2 × 65.536 = 0x13be8

Step 2

0x3BE8 × 0x0A = 0x25710

Step 3

0x5710 × 0x0A = 0x366A0

Step 4

0x66A0 × 0x0A = 0x40240

(Remainder 0x0240 is because we rounded up

the result to an integer at Step 1)


---

## Page 13

But what if we can only use integer arithmetic?

Mark Neil - Microprocessor Course

13

! Choose k=65 gives an answer of 1223

! Choose k=66 gives an answer of 1242

! We need more accuracy so use 4 bytes for calculation and choose

k=0x1000000/1000=16777.216=0x418A (rounded up)

! For for our value of 1234=0x04D2

Step 1

0x04D2 × 0x418A = 0x13BEB34

➜

1

Step 2

0x3BEB34 × 0x0A = 0x2573008

➜

2

Step 3

0x573008 × 0x0A = 0x367E050

➜

3

Step 4

0x67E050 × 0x0A = 0x40EC320

➜

4

! In fact it can be shown that this algorithm is now correct for all decimal

values from 0000 to 9999


---

## Page 14

Coding on the PIC18

Mark Neil - Microprocessor Course

14

! We have already seen 8 bit add and subtract

commands, both with and without carry, eg addwf

addwfc addlw subwf subwfc sublw

! Pic18 also has 8 bit multiply commands eg.

mulwf

f

! Multiplies the 8-bit number in W with the 8-bit

number in file register f and puts the 16-bit result

in special function registers PRODH:PRODL

! Calculation takes 1 instruction cycle! (The same as

add or subtract)

! You can combine mul operations with add

operations to realise longer multiplications

! mullw is also available as a command


---

## Page 15

L0ng multiplication 8-bits at a time

Mark Neil - Microprocessor Course

15

To calculate   0x04D2 × 0x418A

### 04 D2

### × 41 8A

### 8A×D2

71 34

### 8A×04

02 28 00

### 41×D2

35 52 00

41×04

01 04 00 00

### 01 3B EB 34

To calculate   0x3BEB34 × 0x0A

### 3B EB 34

×

### 0A

### 0A×34

02 08

### 0A×EB

### 09 2E 00

### 0A×3B

### 02 4E 00 00

02 57 30 08

Remember your carry bits as you add up!


---

## Page 16

To do…

Mark Neil - Microprocessor Course

16

! Add code to your program to output your ADC value as a decimal

number to the LCD and/or UART

! Start by writing a 16-bit by 16-bit multiply routine that gives a 32-bit

output [Hint: you can find this in the PIC18F87K22 datasheet!].

! Test your code on some example values.

! Then for Steps 2 to 4 understand and extend this to write an 8-bit by

24-bit routine with a 32-bit output.

! Convert the decimal digits to ascii codes and write to your LCD

! Check the accuracy of your measurements with a digital voltmeter or

the oscilloscope (plot a graph maybe?)


---

