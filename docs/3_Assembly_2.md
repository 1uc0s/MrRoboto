# 

---

## Page 1

### M E M O R Y  U S A G E  A N D  S U B R O U T I N E S

PIC Assembler 2

M. Neil - Microprocessor Course

1


---

## Page 2

Outline

M. Neil - Microprocessor Course

2

! Memory on the PIC18 processor

! Addressing modes for accessing memory

! Memory Test Program

! Program Flow: Subroutines and the Stack

! Some example programs for you to write

! Program Design


---

## Page 3

Memory in the PIC18

There are Several different types of

memory on the PIC which you can

use/access

Flash Program Memory

Data SRAM (internal and external)

including special function registers

Hardware stack

W register

EEPROM also available

M. Neil - Microprocessor Course

3


---

## Page 4

Data Memory

! There is some internal memory (SRAM)

on the PIC18 which can be used for

storing data

¡ Internal SRAM memory is 4K X 8 bits (4 Kilo-

Bytes 0x000-0xFFF)

¡ The special function registers and I/O ports

occupy the last part of this memory

! All of this memory (file registers) can be

addressed with single instructions in a

single instruction cycle

! There is also the possibility of external

memory being installed

¡ Not on our boards

¡ Can add if your project needs

M. Neil - Microprocessor Course

4

Data Memory

Bank Select(2)

7

0

From Opcode(2)

0

0

0

0

000h

100h

200h

300h

F00h

E00h

FFFh

Bank 0

Bank 1

Bank 2

Bank 14

Bank 15

00h

FFh

00h

FFh

00h

FFh

00h

FFh

00h

FFh

00h

FFh

Bank 3

through

Bank 13

0

0

1

0

1

1

1

1

1

1

1

1

7

0

### BSR(1)

1

1

1

1

1

1

1

1

SFRs

Access bank


---

## Page 5

Addressing modes – Literal and Direct addressing

M. Neil - Microprocessor Course

5

! Literal addressing

¡ The operand is a literal number

! Literal addressing only available to

destination W, BSR or FSR registers

! Direct addressing

¡ The operand is a file register and its

address is embedded in the op-code

! Remember, file registers can be either

Access or Banked

! Destination can be F or W

movlw 0x3f

0x3f ➜ W

addlw 0x02

### W+2 ➜ W

movf 0x3f,W,A

(0x3f) ➜ W

addwf 0x02,W,A

(0x02)+W ➜ W


---

## Page 6

Indirect addressing data RAM using File Select Registers (FSR)

M. Neil - Microprocessor Course

6

! The file select registers FSR0, FSR1 and

FSR2 can hold a 12-bit address that can

point to anywhere in RAM

¡ Can load a 12-bit literal into an FSR with the

LFSR command eg

lfsr 0,0x140

¡ Actually each FSR register is a pair of SFRs, eg

FSR1=FSR1H:FSR1L that can be written or

read independently as normal

! To access the file register at the address

pointed to by FSR0, use the INDF0 SFR

! Increment/decrement SFRs also available

that let you move through a block of RAM

(POSTINCn, PREINCn, POSTDECn)

! PLUSWn register allows indexed

addressing by defining an offset (-

128➜127) to the FSR* address

lfsr 0, 0x140

;load address 0x140 into FSR0

movlw 0x10

;load 0x10 into W

addwf INDF0, f, A ;adds W to contents of address 0x140

;puts result back into address 0x140

lfsr 2, 0x560

;load address 0x560 into FSR2

clrf POSTINC2, A ;clears address 0x560

clrf POSTINC2, A ;clears address 0x561

clrf POSTINC2, A ;clears address 0x562

clrf POSTINC2, A ;clears address 0x563

;FSR2 now contains address 0x564

lfsr 2, PORTA

;load address 0xF80 into FSR2

movlw 2

;loads 2 into W

bcf

PLUSW2, 4, A ;clears bit 4 of 0xF82

;which happens to be PORTC

;FSR2 still contains address 0xF80


---

## Page 7

Program Memory

! Organized as 64K 16bit words

¡ 128 Kilo-Bytes of memory

¡ Addressed 0x00000-0x1FFFF

¡ Instructions always start on an even byte

address

¡ The processor architecture can address up to

2MB of program memory

! This is where the program which is

executing is stored

¡ The Program Counter (PC) holds the address

in program memory of the current instruction.

¡ To move to the next instruction the PC must

increment by 2 – its least significant bit is

always a zero

! Data can be stored in program memory

¡ The data stored in program memory needs to

be read out using SFRs and special

instructions before it can be used

M. Neil - Microprocessor Course

7

### PC<20:0>

21 bits = 2MB!

Reset Vector

Low-Priority Interrupt Vector

0000h

0018h

On-Chip

Program Memory

High-Priority Interrupt Vector

0008h

1FFFFFh

Read ‘0’


---

## Page 8

Reading data from program memory by indirect addressing

M. Neil - Microprocessor Course

8

Table Pointer(1)

Table Latch (8-bit)

Program Memory

### TBLPTRH

### TBLPTRL

### TABLAT

### TBLPTRU

Instruction: TBLRD*

Program Memory

### (TBLPTR)

1. Load address of location you

want to read into TBLPTRU,

TBLPTRH, TBLPTRL SFRs

2. Execute a TBLRD* instruction

3. Data is transferred to

the TABLAT SFR

; ******* Programme FLASH read Setup Code ****

### BCF CFGS

; point to Flash program memory

### BSF EEPGD

; access Flash program memory


---

## Page 9

TBLRD* instructions

M. Neil - Microprocessor Course

9

(

)

Mnemonic,

Operands

Description

Cycles

16-Bit Instruction Word

Status

Affected

Notes

MSb

LSb

DATA MEMORY l PROGRAM MEMORY OPERATIONS

### TBLRD*

### TBLRD*+

### TBLRD*-

### TBLRD+*

### TBLWT*

### TBLWT*+

### TBLWT*-

### TBLWT+*

Table Read

Table Read with Post-Increment

Table Read with Post-Decrement

Table Read with Pre-Increment

Table Write

Table Write with Post-Increment

Table Write with Post-Decrement

Table Write with Pre-Increment

2

2

0000

0000

0000

0000

0000

0000

0000

0000

0000

0000

0000

0000

0000

0000

0000

0000

0000

0000

0000

0000

0000

0000

0000

0000

1000

1001

1010

1011

1100

1101

1110

1111

None

None

None

None

None

None

None

None

! There are different versions of TBLRD* instructions that either increment or decrement

the TBLPTR registers before or after they have read the data

¡ Useful for reading blocks of data

! TBLWT* instructions are also available, but its not quite that simple with FLASH

memory!


---

## Page 10

Copying data from

program memory to

data memory

Don’t forget setup code

db defines a table of bytes in

program memory

EQU  defines a constant number for

use in the assembler at compile time

Low highword, high and low are

assembler functions to help you do

simple calculations at compile time

See help documents in MPLAB for

more info on other assembler

directives

; ******* Programme FLASH read Setup Code ****

setup:

bcf

### CFGS

; point to Flash program memory

bsf

### EEPGD

; access Flash program memory

goto

start

; ******* My data and where to put it in RAM *

myTable: db

'T','h','i','s',' ','i','s',' ','j','u','s','t’,

db

' ','s','o','m','e',' ','d','a','t','a'

myArray EQU 0x400

; Address in RAM for data

counter EQU 0x10

; Address of counter variable

align

2

; ensure alignment of subsequent instructions

; ******* Main programme *********************

start:

lfsr

0, myArray

; Load FSR0 with address in RAM

movlw

low highword(myTable)

; address of data in PM

movwf

### TBLPTRU, A

; load upper bits to TBLPTRU

movlw

high(myTable)

; address of data in PM

movwf

### TBLPTRH, A

; load high byte to TBLPTRH

movlw

low(myTable)

; address of data in PM

movwf

### TBLPTRL, A

; load low byte to TBLPTRL

movlw

22

; 22 bytes to read

movwf

counter, A

; our counter register

loop:

tblrd*+

; move one byte from PM to TABLAT,

; increment TBLPRT

movff

TABLAT, POSTINC0 ; move read data from TABLAT to

; (FSR0), increment FSR0

decfsz

counter, A

; count down to zero

bra

loop

; keep going until finished

goto

0

10

M. Neil - Microprocessor Course


---

## Page 11

A word of caution!

M. Neil - Microprocessor Course

11

! MPlab-X (actually the underlying NetBeans) does not always behave when

switching branches

¡ It has an internal view of what the project looks like so when you change the project on disk it

can get confused as to what is happening

! Best approach is to close the project before switching branches or checking out

a new branch

! Your project will still be visible in MPlab-X’s Git browser window

! Then re-open the project and MPlab-X will pick up all the changes to the project

on disk


---

## Page 12

Checkout the code using Git

M. Neil - Microprocessor Course

12

! Commit any recent changes you have made to your repository

! Under “Team” menu open the “Git Repository Browser”

! Close your project before changing branches

! From the Git repository browser select the remote branch “Table_read”

¡ You may need to tick the “Checkout as new branch” box to copy this branch to your local repository, you

then need to make sure that is has the same name Table_read locally

! Re-open your project (File>Open recent project)

! Code in your window should change to the example that reads program memory into

### RAM

! Step through the program in simulator or ICD mode and check that it works and that

you understand what is going on

¡ Watch what happens to the FSR and TBLPTR registers as you loop through the table


---

## Page 13

Storing data in program memory

M. Neil - Microprocessor Course

13

! You can create initial values for data in your program code

¡ These will be stored in the program memory

÷ Accessed using the labels you define

¡ See the examples below for the assembler directives needed to create data in program memory

! You can copy the data into RAM (as we did on the previous pages) or use them

directly from program memory

¡ Access will be simpler and quicker from RAM and values can be changed

! Remember, words are stored little-endian, (least significant byte first)

MyByteTable:

db 0x00,0x01,0x02,0x03,0x04,0x05,0x06,0x07

;Table loading with 8 bytes

db “a”,”s”,”c”,”i”,”i”

;Table loading with 5 ascii characters

MyWordTable:

dw 0x0908h,0x0B0Ah,0x0D0Ch,0x0F0Eh

; Load 4 16-bit words in the table

dw 0x1514h,0x1617h,0x1918h,0x1B1Ah

; Next 4 16-bit words in the table


---

## Page 14

Program flow and subroutines

M. Neil - Microprocessor Course

14

! You will want to break your program up into

small pieces or subroutines

! Use the call operations to jump to these

subroutines

! A special separate area of memory called the

STACK is used to store the program address of

where you came from

! When you return from the subroutine the

microprocessor reads the address from the top

of the stack back into the program counter

! PIC18 implements a HARDWARE stack that

can contain up to 31 addresses

! You have to implement your own software

stack if your program is more than 32 levels

deep…

! …or if it has recursive subroutines!

; main code

movlw

0x10

movwf

0x20, A ; store 0x10 in FR 0x20

call

delay

goto 0

; a delay subroutine

delay:

decfsz

0x20, A ; decrement until zero

bra delay

return


---

## Page 15

Stack example

### STKPTR

0x00

Stack

location

Contents

00*

----

01

0x00000

02

0x00000

03

0x00000

04

0x00000

05

0x00000

06

0x00000

013C  0E10     MOVLW 0x10

013E  6E20     MOVWF 0x20, ACCESS

0140  ECA4     CALL 0x148, 0

### 0142  F000     NOP

0144  EF00     GOTO 0x0

### 0146  F000     NOP

; a delay subroutine

0148  2E20     DECFSZ 0x20, F, ACCESS

014A  D7FE     BRA 0x148

### 014C  0012     RETURN 0

### PC

0x0013c

M. Neil - Microprocessor Course

15

### W

0x20

0x??

0x??


---

## Page 16

Stack example

### STKPTR

0x00

Stack

location

Contents

00*

----

01

0x00000

02

0x00000

03

0x00000

04

0x00000

05

0x00000

06

0x00000

013C  0E10     MOVLW 0x10

013E  6E20     MOVWF 0x20, ACCESS

0140  ECA4     CALL 0x148, 0

### 0142  F000     NOP

0144  EF00     GOTO 0x0

### 0146  F000     NOP

; a delay subroutine

0148  2E20     DECFSZ 0x20, F, ACCESS

014A  D7FE     BRA 0x148

### 014C  0012     RETURN 0

### W

0x20

0x10

0x??

### PC

0x0013e

M. Neil - Microprocessor Course

16


---

## Page 17

Stack example

### STKPTR

0x00

Stack

location

Contents

00*

----

01

0x00000

02

0x00000

03

0x00000

04

0x00000

05

0x00000

06

0x00000

013C  0E10     MOVLW 0x10

013E  6E20     MOVWF 0x20, ACCESS

0140  ECA4     CALL 0x148, 0

### 0142  F000     NOP

0144  EF00     GOTO 0x0

### 0146  F000     NOP

; a delay subroutine

0148  2E20     DECFSZ 0x20, F, ACCESS

014A  D7FE     BRA 0x148

### 014C  0012     RETURN 0

### PC

0x00140

M. Neil - Microprocessor Course

17

### W

0x20

0x10

0x10


---

## Page 18

Stack example

### STKPTR

0x01

Stack

location

Contents

00

----

01*

0x00144

02

0x00000

03

0x00000

04

0x00000

05

0x00000

06

0x00000

013C  0E10     MOVLW 0x10

013E  6E20     MOVWF 0x20, ACCESS

0140  ECA4     CALL 0x148, 0

### 0142  F000     NOP

0144  EF00     GOTO 0x0

### 0146  F000     NOP

; a delay subroutine

0148  2E20     DECFSZ 0x20, F, ACCESS

014A  D7FE     BRA 0x148

### 014C  0012     RETURN 0

### PC

0x00148

M. Neil - Microprocessor Course

18

### W

0x20

0x10

0x10


---

## Page 19

Stack example

### STKPTR

0x01

Stack

location

Contents

00

----

01*

0x00144

02

0x00000

03

0x00000

04

0x00000

05

0x00000

06

0x00000

013C  0E10     MOVLW 0x10

013E  6E20     MOVWF 0x20, ACCESS

0140  ECA4     CALL 0x148, 0

### 0142  F000     NOP

0144  EF00     GOTO 0x0

### 0146  F000     NOP

; a delay subroutine

0148  2E20     DECFSZ 0x20, F, ACCESS

014A  D7FE     BRA 0x148

### 014C  0012     RETURN 0

### PC

0x0014a

M. Neil - Microprocessor Course

19

### W

0x20

0x10

0x0f


---

## Page 20

Stack example

### STKPTR

0x01

Stack

location

Contents

00

----

01*

0x00144

02

0x00000

03

0x00000

04

0x00000

05

0x00000

06

0x00000

013C  0E10     MOVLW 0x10

013E  6E20     MOVWF 0x20, ACCESS

0140  ECA4     CALL 0x148, 0

### 0142  F000     NOP

0144  EF00     GOTO 0x0

### 0146  F000     NOP

; a delay subroutine

0148  2E20     DECFSZ 0x20, F, ACCESS

014A  D7FE     BRA 0x148

### 014C  0012     RETURN 0

### PC

0x00148

M. Neil - Microprocessor Course

20

### W

0x20

0x10

0x01


---

## Page 21

Stack example

### STKPTR

0x01

Stack

location

Contents

00

----

01*

0x00144

02

0x00000

03

0x00000

04

0x00000

05

0x00000

06

0x00000

013C  0E10     MOVLW 0x10

013E  6E20     MOVWF 0x20, ACCESS

0140  ECA4     CALL 0x148, 0

### 0142  F000     NOP

0144  EF00     GOTO 0x0

### 0146  F000     NOP

; a delay subroutine

0148  2E20     DECFSZ 0x20, F, ACCESS

014A  D7FE     BRA 0x148

### 014C  0012     RETURN 0

### PC

0x0014c

M. Neil - Microprocessor Course

21

### W

0x20

0x10

0x00


---

## Page 22

Stack example

### STKPTR

0x00

Stack

location

Contents

00*

----

01

0x00000

02

0x00000

03

0x00000

04

0x00000

05

0x00000

06

0x00000

013C  0E10     MOVLW 0x10

013E  6E20     MOVWF 0x20, ACCESS

0140  ECA4     CALL 0x148, 0

### 0142  F000     NOP

0144  EF00     GOTO 0x0

### 0146  F000     NOP

; a delay subroutine

0148  2E20     DECFSZ 0x20, F, ACCESS

014A  D7FE     BRA 0x148

### 014C  0012     RETURN 0

### PC

0x00144

M. Neil - Microprocessor Course

22

### W

0x20

0x10

0x00


---

## Page 23

Subroutines and functions

M. Neil - Microprocessor Course

23

! call addr  - jump to a unit of code

which does a given task (2 word

instruction)

! rcall addr - to a unit of code which

does a given task (1 word instruction

limited distance jump)

! return jumps back to address at top of

stack (1 word)

! retlw jumps back to return address

storing the given literal in W on the way

! call addr,fast – calls subroutine at

addr, but stores STATUS, BSR and W

registers in shadow registers, return with

return fast

¡ One use only, a second call fast will

overwrite previous contents of shadow

registers

¡ Useful for interrupts – see later

! Functions are just subroutines where you

pass data back and forth

! You can use W or file registers for this

but…

! … you need to make sure which file

registers are being used elsewhere in your

programme.

! pop and push – let you manipulate

the stack pointer and stack contents via

the TOSU:TOSH:TOSL SFR registers so

that you can implement your own

software stack

! All call and return instructions take 2

cycles because of change in PC


---

## Page 24

LED sequence display

M. Neil - Microprocessor Course

24

! Write a program that includes a table of data in program memory and then

reads the contents back sequentially, byte by byte, and outputs them to the

LEDs on PORTC.

¡ Chose the bytes so that they will make a pattern when they are displayed on the LEDs

! Now use a subroutine to delay the speed of the loop used to output the data

to the LEDs so that you can see the different patterns flashing as they light

the LEDS on PORTC.

¡ You can delay further by cascading delay subroutines.

¡ Allow the user to change the speed of flashing using the switches on PORTD

! You might want to create a new “Branch” for your code using Git

¡ If you have created your own Fork of the lab code then you can store new branches on

Github too

¡ Make your Fork private so you can control who has access to your work


---

## Page 25

Sometimes we need to work

with numbers larger than 8 bits

There are some operations

(multiply commands, mulwf

and mullw) that give a 16 bit

result that is stored in SFRs

### PRODH:PRODL

Other wise you need to do it

yourself using carry bits and

commands like

addwfc

subwfb

Or you can look at what the

carry bit is doing directly.

But be careful, subtraction is

effectively addition with 2’s

complement and a borrow is

equivalent to not carry – so

logic can seem reversed for sub

and dec commands

movlw high(0xDEAD)

; load 16bit number into

movfw 0x10, A

; FR 0x10

movlw low(0xDEAD)

movwf 0x11, A

; and FR 0x11

call

bigdelay

.

.

.

Bigdelay:

movlw 0x00

### ; W=0

Dloop: decf

0x11, f, A

; no carry when 0x00 -> 0xff

subwfb 0x10, f, A

; no carry when 0x00 -> 0xff

bc dloop

; if carry, then loop again

return

; carry not set so return

M. Neil - Microprocessor Course

25

Example: 16 bit delay routine


---

## Page 26

Structured Programming

M. Neil - Microprocessor Course

26

• Design your program into a main control segment, which calls sub-routines

• Subroutines should perform specific tasks or repeated functions

• Marks will be given on the modularity of your code

• Use a Top Down Modular Programming approach to design your code

• Before starting to write code make a simple design diagram outlining the tasks which need

to be done

• Take a few minutes to do this, and show it to a demonstrator

• Put lots of comments in your code


---

## Page 27

Top Down Modular Programming

M. Neil - Microprocessor Course

27

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

