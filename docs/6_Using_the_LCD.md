# 

---

## Page 1

Mark Neil - Microprocessor Course

1

Device Drivers – LCD Display


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

Things needed to make it work

Mark Neil - Microprocessor Course

3

! User output

¡ A liquid crystal display (LCD)

! User input – push buttons

¡ A keypad

! User input – variable knob

¡ To set frequency/amplitude etc.  Analog to digital conversion

! Signal output

¡ Digital to analog conversion

¡ Accurate timing to generate the correct signal shape


---

## Page 4

Overall task plan for next few sessions

Mark Neil - Microprocessor Course

4

! To build elements of a signal generator

! You will develop a number of functional units …

! … and code to make them work

! Think about modular design and as we progress so that your code is

reusable as you add more features (hardware and software) to your

system


---

## Page 5

First Task Plan

Mark Neil - Microprocessor Course

5

! You will create a device driver for a Liquid Crystal Display (LCD).

! You will have some more practice writing assembler and developing a

modular program


---

## Page 6

2x16 Character LCD

Plugs into socket on board (power

it off first), hard-wired to PortB

4-bit data bus, (8-bit data needs

two write cycles)

3 control lines

•

RS Write instruction (0) or data

(1)

•

R/W*, wired low so only write

possible

•

E pulse high to write (H/L

transition latches data)

Dip switch for backlight, pot for

contrast

Liquid Crystal Displays or LCDs are cheap and

popular way of representing information to the

end user of some electronic device. Character

LCDs can be used to represent standard and

custom characters in the predefined number of

fields. EasyPIC PRO™ v7 provides the connector

and the necessary interface for supporting 2x16

character LCDs in 4-bit mode. This type of display has

two rows consisted of 16 character fields. Each field is a

7x5 pixel matrix. Communication with the display module

is done through CN14 display connector. Board is fitted with

uniquely designed plastic display distancer, which allows the LCD

module to perfectly and firmly fit into place.

GND and VCC - Display power supply lines

Vo - LCD contrast level from potentiometer P1

RS - Register Select Signal line

E - Display Enable line

R/W - Determines whether display is in Read or Write mode. It’s

always connected to GND, leaving the display in Write mode all

the time.

D0–D3 - Display is supported in 4-bit data mode, so lower half of

the data byte interface is connected to GND.

D4–D7 - Upper half of the data byte

LED+ - Connection with the backlight LED anode

LED- - Connection with the backlight LED cathode

We have allowed LCD backlight to be enabled in two different ways:

1. It can be turned on with full brightness using SW4.1 switch.

2.  Brightness level can be determined with PWM signal from the

microcontroller, allowing you to write custom backlight controling

software. This backlight mode is enabled with SW4.3 switch.

LCD 2x16 characters

### DATA BUS

Figure 12-1: On-board LCD 2x16 display connector

Figure 12-2: 2x16 LCD

connection schematics

Standard and PWM-driven backlight

Connector pinout explained

Make sure to turn off the power supply before placing LCD onto

the board. Otherwise your display can be permanently damaged.

In order to use PWM backlight both SW4.1 and SW4.3 switches must be

enabled at the same time.

### IMPORTANT:

### IMPORTANT:

page 26

displays

EasyPIC PRO

v7

6

Mark Neil - Microprocessor Course


---

## Page 7

EasyPIC pro 7

Conceptual Design

Mark Neil - Microprocessor Course

7

!  We want to construct :

### PIC18F87K22

### RS,E, RB4:5

2x16 LCD DISPLAY

### PORTB0:5

4-bit data RB0:3

data

control


---

## Page 8

The Hitachi LM032XMBL LCD

Mark Neil - Microprocessor Course

8

### RB0-RB3

### E (RB5)

### RS (RB4)

Place upper 4 bits of data/command on RB0:3

Set RS (register select, RB4) to Instruction (0) or Data (1)

Pulse E (RB5) high for 500ns

Place lower 4 bits of data/command on on PORTB0:3

Check RS (register select, RB4) is Instruction (0) or Data (1)

Pulse E (RB5) high for 500ns

Wait >40us for command to complete

### D4:7

### D0:3


---

## Page 9

LCD instruction

table

Note as R/W is hard wired to 0V

we can only perform write

instructions

Need to go through a set-up

routine to make the device work

as desired

Can then write ascii codes to the

device either to defined

character (DDRAM) addresses

or use autoincrement.

See LCD data sheets for more

information

Instruction Table:

Instruction

Instruction Code

Description

Description

Time

(270KHz)

### RS

### R/W DB7 DB6 DB5 DB4 DB3 DB2 DB1 DB0

Clear

Display

0

0

0

0

0

0

0

0

0

1

Write "20H" to DDRAM. and

set DDRAM address to

"00H" from AC

1.52 ms

Return

Home

0

0

0

0

0

0

0

0

1

x

Set DDRAM address to

"00H"  from AC and return

cursor to its original position

if shifted. The contents of

DDRAM are not changed.

1.52 ms

Entry Mode

Set

0

0

0

0

0

0

0

1

### I/D

### S

Sets cursor move direction

and specifies display shift.

These operations are

performed during data write

and read.

37 us

Display

### ON/OFF

0

0

0

0

0

0

1

### D

### C

### B

D=1:entire display on

C=1:cursor on

B=1:cursor position on

37 us

Cursor or

Display

Shift

0

0

0

0

0

1

### S/C

### R/L

x

x

Set cursor moving and

display shift control bit, and

the direction, without

changing DDRAM data.

37 us

Function

Set

0

0

0

0

1

### DL

### N

### F

x

x

DL:interface data is 8/4 bits

N:number of line is 2/1

F:font size is 5x11/5x8

37 us

Set CGRAM

address

0

0

0

1

### AC5

### AC4

### AC3

### AC2

### AC1

AC0 Set CGRAM address in

address counter

37 us

Set DDRAM

address

0

0

1

### AC6 AC5

### AC4

### AC3

### AC2

### AC1

AC0 Set DDRAM address in

address counter

37 us

Read Busy

flag and

address

0

1

### BF

### AC6 AC5

### AC4

### AC3

### AC2

### AC1

### AC0

Whether during internal

operation or not can be

known by reading BF. The

contents of address counter

can also be read.

0 us

Write data

to RAM

1

0

### D7

### D6

### D5

### D4

### D3

### D2

### D1

### D0

Write data into internal

### RAM

### (DDRAM/CGRAM)

37 us

Read data

from RAM

1

1

### D7

### D6

### D5

### D4

### D3

### D2

### D1

### D0

Read data from internal

### RAM

### (DDRAM/CGRAM)

37 us

9

Mark Neil - Microprocessor Course


---

## Page 10

Getting Started

Mark Neil - Microprocessor Course

10

! Checkout  LCD_Hello_World from Github/MicroprocessorsLab

project.

! In the file you will find routines to initialize the LCD display, and a

routine that will write a string from data memory to the display.

! Internally the LCD.s file also implements several delay functions that

are required to give the LCD time to respond to instructions

! Compile and download the code to the EasyPIC board and check that it

functions correctly as you would expect

¡ Note that this branch also includes the serial port code that we looked at before so

could send a message to any connected serial port too


---

## Page 11

Initialisation

Mark Neil - Microprocessor Course

11

LCD_Setup:

clrf

### LATB, A

movlw

11000000B     ; RB0:5 all outputs

movwf

### TRISB, A

movlw

40

call

LCD_delay_ms

; wait 40ms for LCD to start up properly

movlw

### 00110000B

; Function set 4-bit

call

LCD_Send_Byte_I

movlw

10

; wait 40us

call

LCD_delay_x4us

movlw

### 00101000B

; 2 line display 5x8 dot characters

call

LCD_Send_Byte_I

movlw

10

; wait 40us

call

LCD_delay_x4us

movlw

### 00101000B

; repeat, 2 line display 5x8 dot characters

call

LCD_Send_Byte_I

movlw

10

; wait 40us

call

LCD_delay_x4us

movlw

### 00001111B

; display on, cursor on, blinking on

call

LCD_Send_Byte_I

movlw

10

; wait 40us

call

LCD_delay_x4us

movlw

### 00000001B

; display clear

call

LCD_Send_Byte_I

movlw

2

; wait 2ms

call

LCD_delay_ms

movlw

### 00000110B

; entry mode incr by 1 no shift

call

LCD_Send_Byte_I

movlw

10

; wait 40us

call

LCD_delay_x4us

return

### POWER ON

Function set

### RS R/W DB7 DB6 DB5 DB4 DB3 DB2 DB1 DB0

0

0

0

0

1

1

### X

### X

### X

### X

Wait time >40mS

After Vcc >4.5V

Function set

### RS R/W DB7 DB6 DB5 DB4 DB3 DB2 DB1 DB0

0

0

0

0

1

0

### X

### X

### X

### X

0

0

### N

### F

### X

### X

### X

### X

### X

### X

Wait time >37uS

Function set

### RS R/W DB7 DB6 DB5 DB4 DB3 DB2 DB1 DB0

0

0

0

0

1

0

### X

### X

### X

### X

0

0

### N

### F

### X

### X

### X

### X

### X

### X

Wait time >37uS

Wait time >37uS

Display ON/OFF control

### RS R/W DB7 DB6 DB5 DB4 DB3 DB2 DB1 DB0

0

0

0

0

0

0

### X

### X

### X

### X

0

0

1

### D

### C

### B

### X

### X

### X

### X

Wait time >37uS

Display clear

### RS R/W DB7 DB6 DB5 DB4 DB3 DB2 DB1 DB0

0

0

0

0

0

0

### X

### X

### X

### X

0

0

0

0

0

1

### X

### X

### X

### X

Entry mode set

### RS R/W DB7 DB6 DB5 DB4 DB3 DB2 DB1 DB0

0

0

0

0

0

0

### X

### X

### X

### X

0

0

0

1

### I/D

### S

### X

### X

### X

### X

Wait time >1.52mS

Initialization end


---

## Page 12

Write a message

Mark Neil - Microprocessor Course

12

LCD_Write_Message:     ; Message stored at FSR2, length stored in W

movwf   LCD_counter, A

LCD_Loop_message:

movf    POSTINC2, W, A

call    LCD_Send_Byte_D

decfsz  LCD_counter, A

bra     LCD_Loop_message

return

LCD_Send_Byte_D:

; Transmits byte stored in W to data reg

movwf   LCD_tmp, A

swapf   LCD_tmp, W, A   ; swap nibbles, high nibble goes first

andlw   0x0f            ; select just low nibble

movwf   LATB, A         ; output data bits to LCD

bsf     LATB, LCD_RS, A ; Data write set RS bit

call    LCD_Enable      ; Pulse enable Bit

movf    LCD_tmp, W, A   ; swap nibbles, now do low nibble

andlw   0x0f            ; select just low nibble

movwf   LATB, A         ; output data bits to LCD

bsf     LATB, LCD_RS, A ; Data write set RS bit

call    LCD_Enable      ; Pulse enable Bit

movlw   10              ; delay 40us

call    LCD_delay_x4us

return


---

## Page 13

Use 16 bit counters for delays

Mark Neil - Microprocessor Course

13

! Cascade loops to get µs and ms delays

LCD_delay:

; delay routine

4 instruction loop == 250ns

movlw 0x00

### ; W=0

lcdlp1:

decf

LCD_cnt_l, F, A

; no carry when 0x00 -> 0xff

subwfb LCD_cnt_h, F, A

; no carry when 0x00 -> 0xff

bc

lcdlp1

; carry, then loop again

return

; carry reset so return


---

## Page 14

Things to do…

Mark Neil - Microprocessor Course

14

! Add some new routines:

¡ Clear the display

¡ Write to 2nd line of display (or any position on the display)

¡ Write a message directly from program memory instead of from data memory

¡ Make your top level-program do something different depending on a button press

! Top down-modular diagram

¡ Draw a top-down modular design diagram for the whole program

¡ You now have modules (and sub-modules) doing UART and LCD tasks


---

## Page 15

Top Down Modular Programming

M. Neil - Microprocessor Course

15

c

o

m

p

l

e

x

i

t

y

time

Calculator

Initialise

Get

command

Calculate

Output

Load

values

Prompt

message

Input

Interpret

command

Select/run

routine

Format

output

Display

Output

character

Input

character

Output

character

Output

character

Reset


---

