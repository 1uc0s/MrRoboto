# 

---

## Page 1

### S H I F T  R E G I S T E R S :

### C O N V E R T I N G  B E T W E E N  S E R I A L  A N D P A R A L L E L  D A T A

Mark Neil - Microprocessor Course

1

Serial Communications


---

## Page 2

Serial communications

Mark Neil - Microprocessor Course

2

! Most communications is carried out over serial links

¡ Fewer wires needed

¡ Less electronics needed

¡ Must run faster

! Examples

¡ Ethernet

¡ USB – Universal Serial Bus

¡ USART – Universal Synchronous and Asynchronous serial Receiver and Transmitter

(RS232/COM ports)

¡ I2C – Inter Integrated Circuit

¡ SPI – Serial Peripheral Interface

All available in the

PIC18 as “on-chip

peripherals”


---

## Page 3

Parallel or serial?

Mark Neil - Microprocessor Course

3

! Convert numbers expressed in terms of several bits (many signal lines)

into a stream of 0s, 1s on a single line (and a Clock).

¡ Advantage: A convenient way to reduce the number of Electrical signal lines by factors

of 8, 16, 32, 64.

¡ Disadvantage: For the same transfer rate the electronics must be faster by factors of 8,

16, 32, 64.


---

## Page 4

A shift register converts 4-bit parallel to serial

Mark Neil - Microprocessor Course

4

When Parallel load is set, the

S/R bits on the Flip Flops are

arranged to latch in the bits

on the data bus (1 bit on each

Flip Flop)

On each rising edge of the

clock, The Data on the Flip

Flops is put on the Q (Output

Line), which appears at the

input of the next flip flop.

The input data is latched, and

the bits move from one FF to

the next

It takes 4 clock cycles to

move the 4 bits out to the

serial ouput line

A Four Bit Shift Register

Composed of 4 D-Flip-Flops

Parallel to Serial Conversion


---

## Page 5

Data is placed on the

parallel data bus

PL: Data Loaded

into Flip Flops

On Clock edge

Data is shifted

from each FF

to the next in

the chain

NEILNEIL - Microprocessor Course

5


---

## Page 6

8 Bit Parallel to Serial Shift Register

Mark Neil - Microprocessor Course

6


---

## Page 7

Parallel to Serial Conversion:

Parallel load a number then clock it out

Mark Neil - Microprocessor Course

7

clock

### D0

### D1

### D2

### D3

### D4

### D5

### D6

### D7

Output

0

1

1

0

1

1

0

1

1

1 Tick

1

1

0

1

1

0

1

1

2 Ticks

1

1

0

1

1

0

1

3 Ticks

1

1

0

1

1

0

4 Ticks

1

1

0

1

1

5 Ticks

1

1

0

1

6 Ticks

1

1

0

7 Ticks

1

1

8 Ticks

1


---

## Page 8

Serial to Parallel shift register

! At each clock transition, the data is shifted to the next

flip-flop in the chain

! We need to keep track of how many clock pulses we have

sent to know when the full byte is on the outputs

Mark Neil - Microprocessor Course

8


---

## Page 9

Suppose you feed a ‘1’:

Mark Neil - Microprocessor Course

9

### D0

### D1

### D2

### D3

### D4

### D5

### D6

### D7

0

0

0

0

0

0

0

0

0

### 1T

1

0

0

0

0

0

0

0

### 2T

1

1

0

0

0

0

0

0

### 3T

1

1

1

0

0

0

0

0

### 4T

1

1

1

1

0

0

0

0

### 5T

1

1

1

1

1

0

0

0

### 6T

1

1

1

1

1

1

0

0

### 7T

1

1

1

1

1

1

1

0

### 8T

1

1

1

1

1

1

1

1


---

## Page 10

Serial/parallel

peripheral module

on PIC18

There are several different

peripheral functional units on

the PIC that you can use.

The Master Synchronous Serial

Port (MSSP) unit allows the PIC

to communicate to external

devices using simple serial

protocols.

It can implement SPI and I2C

protocols.

The 2 Enhanced Universal

Synchonous/Asychronous

Receiver/Transmitters can

implement COM ports to talk to

higher level computers

10

M. Neil - Microprocessor Course

Instruction

Decode and

Control

Address

### PRODL

### PRODH

8 x 8 Multiply

8

### BITOP

8

8

### ALU<8>

8

8

### IR

3

### EUSART1

Comparator

### MSSP1/2

3/5/7(3)

2/4/6/8/10(3)/12(3)

### CTMU

Timer1

### ADC

12-Bit

### W

Instruction Bus <16>

8

State Machine

Control Signals

Decode

8

8

### EUSART2

ROM Latch

### PORTD

### PORTE

### PORTF

### PORTG

### RD0:RD7(1)

### RE0: RE7(1)

### RF1:RF7(1)

### RG0:RG5(1)

### OSC1/CLKI

### OSC2/CLKO

### VDD,

Timing

Generation

### VSS

### MCLR

Power-up

Timer

Oscillator

Start-up Timer

Power-on

Reset

Watchdog

Timer

BOR and

### LVD

Precision

Reference

Band Gap

### INTRC

Oscillator

Regulator

Voltage

### VDDCORE/VCAP

### ENVREG

16 MHz

Oscillator

Timer0

4/5/6/7/8/9(3)/10(3)

### RTCC

Timer

Timer

1/2/3

### CCP

### ECCP

1/2/3


---

## Page 11

(                       )

Read

Write

Internal

Data Bus

SSPxSR reg

### SSPM<3:0>

bit 0

Shift

Clock

SSx Control

Enable

Edge

Select

Clock Select

TMR2 Output

### TOSC

Prescaler

4, 16, 64

2

Edge

Select

2

4

Data to TXx/RXx in SSPxSR

TRIS bit

2

### SMP:CKE

SDOx

SSPxBUF reg

SDIx

SSx

SCKx

SPI module on the

### PIC

At the heart of the SPI module is

a shift register.

You can write parallel 8-bit data

to the SPI module which is then

automatically clocked out

through the shift register to

external pins.

The SPI unit can also read in

serial data from external pins

and present it as parallel 8-bit

data to your program.

SSx* pin lets you control the SPI

bus with another device as

master.

11

M. Neil - Microprocessor Course

SPI2 pins

appear on

### PORTD:

### RD4/SDO2

### RD5/SDI2

### RD6/SCK2

### RD7/SS2*


---

## Page 12

SPI timing diagram

Mark Neil - Microprocessor Course

12

You can choose the idle polarity of the clock (CKP) and the active edge

polarity of the clock (CKE).  Note that the MSb is output first!

SCKx

### (CKP = 0

SCKx

### (CKP = 1

SCKx

### (CKP = 0

SCKx

### (CKP = 1

4 Clock

Modes

SDOx

bit 7

bit 6

bit 5

bit 4

bit 3

bit 2

bit 1

bit 0

### CKE = 1)

### CKE = 0)

### CKE = 1)

### CKE = 0)

Write to

SSPxBUF

SDOx

bit 7

bit 6

bit 5

bit 4

bit 3

bit 2

bit 1

bit 0

### (CKE = 0)

### (CKE = 1)


---

## Page 13

The 74HC164 Shift Register: Serial to Parallel

Mark Neil - Microprocessor Course

13

Serial Data

In

*Reset

Parallel

out

Clock


---

## Page 14

74HC164 Function Table

Mark Neil - Microprocessor Course

14

74HC164 reads in

MSb first and

requires a positive

clock edge


---

## Page 15

SPI code example

Mark Neil - Microprocessor Course

15

SPI_MasterInit:

; Set Clock edge to negative

bcf

### CKE2

; CKE bit in SSP2STAT,

; MSSP enable; CKP=1; SPI master, clock=Fosc/64 (1MHz)

movlw (SSP2CON1_SSPEN_MASK)|(SSP2CON1_CKP_MASK)|(SSP2CON1_SSPM1_MASK)

movwf SSP2CON1, A

; SDO2 output; SCK2 output

bcf

TRISD, PORTD_SDO2_POSN, A ; SDO2 output

bcf

TRISD, PORTD_SCK2_POSN, A ; SCK2 output

return

SPI_MasterTransmit:  ; Start transmission of data (held in W)

movwf SSP2BUF, A

; write data to output buffer

Wait_Transmit:

; Wait for transmission to complete

btfss PIR2, 5

; check interrupt flag to see if data has been

sent

bra

Wait_Transmit

bcf

### PIR2, 5

; clear interrupt flag

return


---

## Page 16

High Level Design

Mark Neil - Microprocessor Course

16

The Project:

8-bit

Serial

Data

### PIC18

Parallel To

Serial

### PORTD

Data

Clock

### SPI

Shift

Register

### 74HC164

8-Bits of data

(Parallel)

Serial

to

Parallel

8-Bits of data

(Serial)

8-Bits of data

(Parallel)

LEDs (or DAC)


---

## Page 17

Low Level Design

Wire up LEDs so that you can

see the data arrive on the output

Wire up a switch to the MR* line

to allow you to clear the Shift

Register outputs (make sure you

understand how this works)

The clock and data bits should

come from the SPI2 outputs

that can be found on PORTD

17

Mark Neil - Microprocessor Course

### 74HC164

### DSA

1

### DSB

2

### CP

8

### Q0

3

### Q1

4

### Q2

5

### Q3

6

### Q4

10

### Q5

11

### Q6

12

### Q7

13

### MR

9

LEDs to read output

### VCC

1.0 k⌦

### VCC

Data: PORTD4

### (SDO2)

Clock: PORTD6

### (SCK2)

LEDs are available

on your prototyping

board

Or connect to your

### DAC


---

## Page 18

The Serial Link Test Program

Mark Neil - Microprocessor Course

18

Start

Delay several

seconds

Send new pattern to SPI

SPI Clocks the data 8 times

into 164 using PORTD4,6

Look at

the LEDs

Setup


---

## Page 19

Task Plan:

Mark Neil - Microprocessor Course

19

! Write code for the PIC18 to turn 8-bit parallel internal data into serial

data + clock using the on-chip SPI peripheral.

! Construct a device that will receive serial data, convert them to parallel

data and display them using LEDs.

! Write a program that will send several patterns down your ‘serial link’

and demonstrate that it works.

! Use your SPI code and serial to parallel converter to send data to your

DAC.


---

## Page 20

Communicating to

your desktop

computer

Your easyPIC Pro 7 board can

communicate with your PC via:

Ethernet

### USB

### UART

PIC18F87K22 only has

capability to use the UART

interface

Which is actually a UART to USB

convertor

You connect to the board by USB

from the PC

An on-board chip implements

your UART connection as a USB-

CDC device

Looks like a COM port on your PC

20

Mark Neil - Microprocessor Course

UART via USB

Modern PC computers, laptops and notebooks are

no longer equpped with RS-232 connectors and

UART controllers. They are nowdays replaced with USB

connectors and USB controllers. Still, certain technology

enables UART communication to be done over USB connection.

Controllers such as FT232RL from FTDI® convert UART signals to

the appropriate USB standard. In order to use USB-UART module on

EasyPIC  PRO™ v7, you must first install FTDI drivers on your computer.

Drivers can be found on link bellow:

USB-UART communication is being done through a FT232RL

controller, USB connector (CN12), and microcontroller UART

module. To establish this connection, you must connect RX

and TX lines of the microcontroller to the appropriate

input and output pins of the FT232RL. This

selection is done using DIP switches

SW5.1 and SW5.2.

### DATA BUS

Figure 9-1:  USB-UART connection schematics

Enabling USB-UART

In order to enable USB-UART

communication, you must push

SW5.1 (RC6) and SW5.2 (RC7)

to ON position. This connects the

RX and TX lines to appropriate

microcontroller pins and its first

UART module.

communication

page 23

EasyPIC PRO

v7

http://www.ftdichip.com/Drivers/VCP.htm


---

## Page 21

UART_Hello_World program

Mark Neil - Microprocessor Course

21

! Commit any changes you may have made to your current code

¡ Remember to do this from the project side bar to make sure you get all files that have changed

! Checkout or Switch to branch UART_Hello_World

! You should find that a new file has been added to your project

¡ If you can’t see it straight away then close and reopen the project in MPLAB

! You should also notice some differences in the way the program has been

structured

! In particular for automatic memory management and variable assignment

(this is done in the link phase of your compilation) using the compiler

directive psect (program section)

¡ Using this approach can help you structure both your code and its memory usage


---

## Page 22

Compiling and Linking

Mark Neil - Microprocessor Course

22

Data Memory

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

File1.s

File2.s

File3.s

Compile

Compile

Compile

File1.o

File2.o

File3.o

Link


---

## Page 23

UART.s

Gives names of routines (or

variables) in this file that can be

accessed from elsewhere

Defines blocks of data memory

(in this case in access ram)

Names variables in those ram

blocks, the linker chooses their

exact address

Defines bocks of code that the

linker can choose to locate

anywhere in program memory

#include <xc.inc>

global  UART_Setup, UART_Transmit_Message

psect

udata_acs   ; reserve data space in access ram

UART_counter: ds    1

; reserve 1 byte for variable UART_counter

psect

uart_code,class=CODE

UART_Setup:

bsf     SPEN

; enable

bcf     SYNC

; synchronous

bcf     BRGH

; slow speed

bsf     TXEN

; enable transmit

bcf     BRG16

; 8-bit generator only

movlw   103

; gives 9600 Baud rate (actually 9615)

movwf   SPBRG1, A

; set baud rate

bsf     TRISC, PORTC_TX1_POSN, A

; TX1 pin is output on RC6

; pin must set TRISC6 to 1

return

UART_Transmit_Message: ; Message stored at FSR2, length in W

movwf   UART_counter, A

. . .

23

Mark Neil - Microprocessor Course


---

## Page 24

main.s

Names the routines it expects to

find from elsewhere (at link

time)

The same named “udata_acs”

psect for memory in access ram

and some more variables

Another predefined memory

psect in ram where we put our

message array

A predefined psect containing

data  in program memory

Psect “code” is placed at the

reset vector (address 0x00)

And finally our program

#include <xc.inc>

extrn

UART_Setup, UART_Transmit_Message  ; external subroutines

psect

udata_acs   ; reserve data space in access ram

counter:    ds 1    ; reserve one byte for a counter variable

delay_count:ds 1    ; reserve one byte for counter in the delay routine

psect

udata_bank4 ; reserve data anywhere in RAM (here at 0x400)

myArray:    ds 0x80 ; reserve 128 bytes for message data

psect

data

; ******* myTable, data in programme memory, and its length *****

myTable:

db

'H','e','l','l','o',' ','W','o','r','l','d','!',0x0a

; message, plus carriage return

myTable_l   EQU 13

; length of data

align

2

psect

code, abs

rst:

org 0x0

goto

setup

; ******* Programme FLASH read Setup Code ***********************

setup:

bcf

### CFGS

; point to Flash program memory

bsf

### EEPGD

; access Flash program memory

. . .

24

Mark Neil - Microprocessor Course


---

## Page 25

To do…

Mark Neil - Microprocessor Course

25

! Take a look at the code and try to understand what it is doing

¡ The underlying structure should actually be very similar to your SPI code

! Connect the USB serial port to your pc

! MPLAB has a simple serial terminal window under the Tools/Embedded menu

¡ You may need to install or enable this plugin from the Tools/Plugins menu

¡ Or use a “terminal” program from Software Hub such as “Termite”

¡ Select the appropriate COM port with BAUD rate 9600 and connect

¡ On a mac it might be something like /dev/ttys.usbserial-AG0JGTWH

! Download the program to the EasyPIC board and run it

¡ Re-run the program (or press reset on the board) to repeat the message

! Look at the disassembly window to see if you can work out where the linker has put

everything

¡ You might find a .map file in the project directory structure that gives this information too


---

## Page 26

UART notes

Mark Neil - Microprocessor Course

26

! The program only implements transmit

¡ The on chip UART can also receive messages - 2-way communication is possible

! Communication does not need to be by the serial terminal

¡ You could talk to another host program

¡ Or even a python script

! This UART code is a bit inefficient in that it spends a lot of time in a loop

checking the UART to see if data has been transmitted before it can send the

next byte

¡ This is called polling

¡ At 9600 Baud it will take about 1 ms to send each byte!  Check it with your oscilloscope.

! Later we will see how this sort of problem can be solved with interrupts


---

## Page 27

Writing modular assembly code

Mark Neil - Microprocessor Course

27

! Think about this approach to how you might write modules in Python.

! You can define a set of related routines and the data that they operate

on in a single file.

! This can then be developed and tested in isolation (maybe with a simple

main.s)

! Your code can then be re-used in other projects that you write later

! From now on we will develop all out code in this way, and you will work

with or write several of these modules yourselves.


---

