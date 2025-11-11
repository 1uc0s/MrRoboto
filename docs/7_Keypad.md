# 

---

## Page 1

### W R I T E  Y O U R  O W N  D E V I C E  M O D U L E

Mark Neil - Microprocessor Course

1

Decoding and Using a

4x4 Keyboard


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

The Keyboard

Mark Neil - Microprocessor Course

3

8 lines corresponding  to

4 rows and 4 columns

By Pressing a button you

connect one of the row

lines to one of the column lines.


---

## Page 4

The PCB of the Key-Board

Mark Neil - Microprocessor Course

4

The buttons simply

connect one row with

one column!

From this picture you

Can see that the keyboard is

all PASSIVE: No

ICs no Transistors


---

## Page 5

Row 0

Row 1

Row 2

Row 3

Col 0

Col 1

Col 2

Col 3

1

2

3

### F

4

5

6

### E

7

8

9

### D

### A

0

### B

### C

### VCC

Decoding what key

is pressed

Step 1: Row

We can provide power to the

four rows, and readout the data

We write 0 to all columns

In the example on the right (the

5 is pressed) we will see a 0 on

row 2 and 1 on the rest of the

rows

We then have to determine

which column has been pressed

5

Mark Neil - Microprocessor Course


---

## Page 6

Row 0

Row 1

Row 2

Row 3

Col 0

Col 1

Col 2

Col 3

1

2

3

### F

4

5

6

### E

7

8

9

### D

### A

0

### B

### C

### VCC

Step 2:Reading the

Column

If instead of providing power to

the rows, we provide power to

the columns we can determine

which column has a key pressed

We write 0 to all the rows

In this case we will read 0 on

column 1 and 1 on the other rows

Hence we know that the ‘5’ was

pressed as row 2 and col 1 have a

key pressed

6

Mark Neil - Microprocessor Course


---

## Page 7

Ports and Pull-up Resistors on PIC18

Mark Neil - Microprocessor Course

7

### PORTE :

OUTPUT writes to

LATE Register

INPUT reads port

pin logic level

### TRISE :

Tri-state (I/O) Reg

Each pin on

PORTE is

independent!

There are pull-up resistors

present on-chip.  Which allow us

to put power on to the PORT pins.

These need to be enabled by

setting the REPU bit in PADCFG1

SFR.

Note PADCFG1 is not in access

### RAM!

You should disconnect PORTE

LEDs as these will pull-down!

Data

Bus

### WR LAT

### WR TRIS

### RD PORT

Data Latch

TRIS Latch

### RD TRIS

Input

Buffer

I/O Pin

### Q

### D

CKx

### Q

### D

CKx

### EN

### Q

### D

### EN

### RD LAT

or PORT


---

## Page 8

Reading the Keypad with the PIC18

Mark Neil - Microprocessor Course

8

We will use PORTE for both

Reading the pins and providing the

Power.  This example is the initial

configuration to read the row

PORTE bits 4-7

Outputs

PORTE bits 0-3

Inputs

Row 0

Row 1

Row 2

Row 3

Col 0

Col 1

Col 2

Col 3

1

2

3

### F

4

5

6

### E

7

8

9

### D

### A

0

### B

### C

### VCC


---

## Page 9

Task Plan - Steps

Mark Neil - Microprocessor Course

9

! Enable the pull-up resistors on bits 0-3 of PORTE and connect the 4 pins of

the keyboard. Configure these pins as inputs,  the 4 lines will be held high by

the pull-up resistors.

! Connect the rest of keyboard to pins 4-7 of PORTE and configure them as

outputs.

! Your program should drive the output bits (4-7) of PORTE low all at once

! Then read the 4 PORTE input pins (0-3).

¡ Determine which row has a key pressed

! Next it should configure bits 0-3 as outputs and bits 4-7 as inputs

¡ Read RE4:7 to determine which column has a key pressed

! Decode the results to determine which key has been pressed

! Test your measurement by outputting to PORTD


---

## Page 10

How to configure PORTE for Step 1

Mark Neil - Microprocessor Course

10

! Set the pull-ups to on for PORTE

¡ bsf  REPU

¡ Remember that PADCFG1is not in access ram so you need to set BSR first

! Write 0s to the LATE register

¡ clrf LATE

¡ You only need to do this once – it’s a latch and will remember its state!

! To configure  PORTE 4-7 as outputs and  PORTE 0-3 as  inputs

¡ Set  TRISE to 0x0F

! Be careful as it may take time for the voltage on your output pins to settle

¡ Use delays, check what is happening with your oscilloscope

! Read PORTE to determine the logic levels on PORTE 0-3


---

## Page 11

Decoding the output

Mark Neil - Microprocessor Course

11

! With 8 bits of data from your measurements you could have up to 256

different results

! However, only 17 are valid

! Lots more are invalid and the result of pressing multiple buttons

! Others are impossible given the electrical circuit or are a result of you not

giving the circuit time to settle

! Think about how you might decode these outputs to the 17 valid answers and

1 invalid

¡ By doing it as quickly as possible

¡ Or by using as little program memory as possible


---

## Page 12

Suggested algorithm

for decoding keypad

Use flow-charts to design your

algorithms

Check measured code against

each valid code in succession

You will have to think carefully

about how you implement this

test and make your decision

Use RETLW command to return

the value that you want in W

12

Mark Neil - Microprocessor Course

Input code

Return 0x00

(null)

Is no

button

pressed?

Yes

Return ‘0’

Is button

0

pressed?

Yes

Return ‘F’

Is button

### F

pressed?

Yes

No

No

No

Return 0xff

(error)


---

## Page 13

Task

Mark Neil - Microprocessor Course

13

! Write a module to read from a 4x4 keypad

¡ Include a set-up routine to set port pins/latches appropriately

¡ Write a routines which reliably input a key press and decode it to a meaningful output.

! We need a reliable piece of code where the PIC18 interprets relatively quickly

any key pressed on the keyboard

¡ There are 17 valid states and lots of invalid/impossible ones!

! Note that the microprocessor is faster than the electrical signals so use delays

! And than your finger so you might ‘see’ the bouncing up and down that

happens when you press a button on the keyboard

! Use your module to input a string of key presses and display the output on

the LCD and/or serial port


---

## Page 14

Writing your own module

Mark Neil - Microprocessor Course

14

! Copy the file containing an existing module, eg UART.s , to a new file, say

KeyPad.s.

! Add the file KeyPad.s to your project so that it compiles

! Change all the internal names mentioning ‘UART’ to something new, say

‘KeyPad’

! Define space for any named variables that you want to use in psect

udata_acs

! Put your own initialization code into the ‘KeyPad_init’ subroutine

! And your own code into another ‘KeyPad_read’ subroutine to read the

keypad

! Enter the name of subroutines and variables that you want to see from other

files in the globals statement and in the extrn statement in files where you

want to see them


---

