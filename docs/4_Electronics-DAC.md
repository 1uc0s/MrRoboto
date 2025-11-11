# 

---

## Page 1

### L O G I C  G A T E S

### A D D E R S

### F L I P - F L O P S

### R E G I S T E R S

### P A R A L L E L  C O M M S

### D I G I T A L  T O  A N A L O G  C O N V E R T E R

Electronics – Parallel communication

Mark Neil - Microprocessor Course

1


---

## Page 2

Mark Neil - Microprocessor Course

2

!  How do you actually make a 0 or 1 ?

It is clear that depending

upon the position of the  J1

switch the line will be either

‘0’ or ‘1’

Pull-up resistor

Making a Zero or a One

This is actually

a NOT gate!

Press the

button (1), you

get a 0 on the

output


---

## Page 3

Mark Neil - Microprocessor Course

3

!  How do you actually make a 0 or 1 in CMOS?

0

### +V

1

### +V

?

### +V

?

### +V

“Tri-state” output

High impedance

### BANG!

### J1

### J2

Making a Zero or a One


---

## Page 4

Binary Logic

Mark Neil - Microprocessor Course

4

! Once the bits are generated, we want to be able to perform various

operations on those bits

! The operations which the microprocessor carries out can all be

constructed with a few simple circuits

! The basic building blocks are logic “gates”


---

## Page 5

Mark Neil - Microprocessor Course

5

### A

### B

### AND

0

0

0

0

1

0

1

0

0

1

1

1

### A

### B

### OR

0

0

0

0

1

1

1

0

1

1

1

1

### A

### NOT

0

1

1

0

• You may have

seen and

remember

simple gates

such as AND,

### OR, NOT

• Any digital

device can be

made out of

either ORs and

NOTs or ANDs

and  NOTs.

Binary Logic truth tables


---

## Page 6

Mark Neil - Microprocessor Course

6

! Are actually the simplest 2-input gates to build

CMOS NAND and NOR gates


---

## Page 7

DeMorgan’s Theorem

Mark Neil - Microprocessor Course

7

! You can swap ANDs with ORs if at

the same time you invert all inputs

and outputs :

! CMOS Not gate

Or make a NOT by wiring the 2

inputs of a NAND or NOR together


---

## Page 8

Mark Neil - Microprocessor Course

8

!  Any digital device can be made with

just NANDs or just NORs

Exclusive OR with just NANDs or NORs

### A

### B

### XOR

0

0

0

0

1

1

1

0

1

1

1

0


---

## Page 9

Additions of two bits: The half adder

Mark Neil - Microprocessor Course

9

### A

### B

### C

### S

0

0

0

0

1

0

0

1

0

1

0

1

1

1

1

0

! Adding two bits

generates two bits of

output

¡ 1 “Sum Bit” S

¡ 1 “Carry Bit” C

! The truth table for this

operation is shown along

with an implementation

using two gates


---

## Page 10

Full Adder

Mark Neil - Microprocessor Course

10

! In order to add larger numbers, we

need to be able to bring the carry

from the lower order bits, and add

this to the sum

! The inputs are:

¡  the two bits to be added (A,B)

¡ The Carry Bit (C)

! The outputs are:

¡ The Sum Bit (S)

¡ The Carry Out Bit (C+)

! We can build this from two half

adders and an XOR gate

### A

### B

### C

### C+

### S

0

0

0

0

0

0

1

0

0

1

1

0

0

0

1

1

1

0

1

0

0

0

1

0

1

0

1

1

1

0

1

0

1

1

0

1

1

1

1

1


---

## Page 11

Adding more and more bits

Mark Neil - Microprocessor Course

11

! With the Full adder building block

we can generalize to produce a

circuit which adds larger numbers

! 4-bit adder

¡ adds two 4-bit numbers to give a 4-

bit result plus a carry bit.


---

## Page 12

Mark Neil - Microprocessor Course

12

! Registers are electronic devices

¡ capable of storing 0’s or 1’s

! D-FLIP-FLOPs are the most elementary registers

¡ can store one bit

! 8 DFFs clocked together make a one byte register

¡ Capable of storing 8 bits

Storing Zeros and Ones: Registers


---

## Page 13

Mark Neil - Microprocessor Course

13

Gate level design of an SR latch

### S

### R

### Q

### Q*

### H

### H

### H

### L

### H

### H

### L

### H

### H

### L

### L

### H

### L

### H

### H

### L

### L

### L

### H

### H

•

S/R high is ambiguous, but stable

•

This circuit “remembers” that S

went low

Ambiguous

but stable

SR Latch: 1 bit memory


---

## Page 14

Gated D Latch

Mark Neil - Microprocessor Course

14

Ensures that S and R are always complementary.

When the Clock is high – D is transferred to the outputs of the latch and it is held

there when the clock is low


---

## Page 15

Master Slave – D Flip Flop

Mark Neil - Microprocessor Course

15

! Data is stored in

the “Master” latch

(Qm) when the

clock is high

! When the clock

goes from high to

low

¡ The data is held in

the Master

¡ The Data is stored in

the slave latch

output

! The Qs output can

only change when

the clock goes from

high to low


---

## Page 16

Mark Neil - Microprocessor Course

16

! 8 bit register in a single package

### ! 74F574

! Also contains tri-state outputs

### CLK

Byte coming in

Byte Stored

Byte Register


---

## Page 17

Mark Neil - Microprocessor Course

17

! Centre of every computer

! Composed of building blocks we

have been learning about

¡ Adders

¡ Flip Flops

¡ Registers

! We also need to have a data bus

to move data in and out

Arithmetic Logic Unit (ALU)


---

## Page 18

Parallel communications on a Computer Bus

Mark Neil - Microprocessor Course

18

! The processor within a computer communicates with the other computer

modules via a device called: Bus.

! Many different Bus architectures exist in the market such as PCI; PCIe; VME….

! Parallel bus architectures include a:

¡ address bus: where the data is going to or coming from

¡ data bus: the actual data to be transferred

¡ control bus: clocks, triggers, data direction etc.

! In a bus all bits of a byte or word are transferred simultaneously.

! If we have a byte wide bus and a transfer frequency of 1MHz then we have a bus

speed of 1Mbytes/sec

! Hence, this is called Parallel Data Transfer (opposed to Serial Data Transfer that

we will learn next)


---

## Page 19

The PIC18

Internally the PIC18 has its own

buses.

The Block diagram in particular

shows the internal 8-bit data bus

to which nearly everything is

connected.

If you look carefully you can find

address and control lines here

too.

M. Neil - Microprocessor Course

19


---

## Page 20

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

20

Mark Neil -

Microproces

sor Course


---

## Page 21

Adding up with an Operational Amplifier

Mark Neil - Microprocessor Course

21

! (Current) Summing Amplifier

Vout = - (V1+V2+V3)

Rules for op-amp circuits:

1. No Current flows into the inputs

2. The gain is really big (typically ~105)

3. So (because of negative feed back)

the voltage difference between the

inputs can be assumed to be zero

The “virtual earth approximation”

V1/10k+V2/10k+V3/10k = -Vout /10k


---

## Page 22

A 3-bit DAC by adding stepped currents on an Op. Amp.

Mark Neil - Microprocessor Course

22

! R-2R Network to convert digital to analog

Switch states (b2, b1, b0)

So:

### 𝑰𝟐= 𝟐𝑰𝟏= 𝟒𝑰𝟎=

𝑽𝒓𝒆𝒇

### 𝟐𝑹

𝑽𝒐= −𝑹𝒇𝑰𝒐𝒖𝒕

𝑰𝒐𝒖𝒕= 𝒃𝟐𝑰𝟐+ 𝒃𝟏𝑰𝟏+ 𝒃𝒐𝑰𝒐

= 𝟒𝒃𝟐+ 𝟐𝒃𝟏+ 𝒃𝒐𝑰𝒐

𝑽𝒐= −𝑹𝒇

### 𝑹

𝟒𝒃𝟐+ 𝟐𝒃𝟏+ 𝒃𝒐

𝟖

𝑽𝒓𝒆𝒇


---

## Page 23

The TLC7524 DAC

For your analog signal generator

you will be using an 8-bit R-2R

ladder network to build your

### DAC

Inputs from a the PIC18 are used

to control the states of the

switches in the ladder

23

Mark Neil -

Microproces

sor Course


---

## Page 24

Operation

The basic operational idea of the

DAC we will be building is

simply to have a series of

switches which control a resistor

network

Depending on which bits are set,

the currents fed into out1 (and

out2) change

Add an op-amp and you have an

8-bit Digital to Analog convertor

24

Mark Neil -

Microproces

sor Course


---

## Page 25

DAC Operation

The output signal will need to be

fed into an external op-amp to

turn the current into a voltage.

Data should be put on the data

bus using one of the PIC18

PORTs

CS* can be held low, but use

the WR* pin to latch in data to

the TLC7524

One problem with this

arrangement is that the output is

–ve so you need op-amps with

dual supplies (+15V and -15V)

25

Mark Neil -

Microproces

sor Course


---

## Page 26

DAC Schematic –

current mode

You can write numbers to the

DAC in a similar way as an

external latch using the PIC18

Ports

With Vref=Vcc/2=+2.5V the

range of output voltages will be

0V to -2.5V.

Use a negative Vref to get

positive output voltages

26

Mark Neil -

Microproces

sor Course

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

8-bit input

data from Pic

### PORT


---

## Page 27

Connecting up the

op-amp

Remember that it needs power

supplies too

You should use +15V (pin 7) and

-15V  (pin 4) to power for the op-

amp if using current mode and a

741 or similar op-amp

No connection to pins 1, 5  or 8

Keep +15V and -15V as far away

as possible from anything digital

as these will generally only cope

with voltages in the 0-5V range

27

Mark Neil -

Microprocesso

r Course

1

2

3

4

8

7

6

5

### NC

### V+

Output

### NC

### NC

−In

+In

### V−


---

## Page 28

High Level Design :External 8-bit register

Mark Neil - Microprocessor Course

28

We want to construct :

PIC Pro – V7

Board

8-Bits of data in

### PORTJ (I/O)

PORTD (Output Only)

### WR*, (CS)

Address/

Control bus

TLC7542 + Op Amp

### (DAC)

Analog signal

Data Bus  In

Oscilloscope

Many of the external devices that we use later on, such as LCD, have just this kind of interface


---

## Page 29

Write Cycles of the

### TLC7524

The DAC has internal registers

to store the input Data (1 Byte)

and signals which control the

write operation  (CS*, WR*):

Leave CS* low all the time

You will need to write code to

implement the WR* signal (or

you could leave it pulled low all

the time by connecting it to

ground).

Check that your code satisfies

the timing requirements

29

Mark Neil -

Microproces

sor Course


---

## Page 30

Protoboard connectors

Mark Neil - Microprocessor Course

30

This end plugs

into protoboard

This end connects to

EasyPIC Pro V7 via

ribbon cable

Resistors protect your

microprocessor from

short circuits

Test points for

checking port values

with ‘scope probe

Ground pin

LED indicates power

from EasyPIC Pro V7 –

100mA max


---

## Page 31

Breakout connector schematic

Mark Neil - Microprocessor Course

31


---

## Page 32

The control bus

Mark Neil - Microprocessor Course

32

! You will need 1 control lines to make the circuit work

¡ WR* – Write Pulse

! Choose which line of PORTD you are going to use for this signal and

remember to set it as an outputs by clearing the associated TRISD bit

! Ensure that your clock pulse lines is high unless you are writing to the DAC.

¡ Writing to DAC is continuous while WR* is low but then holds on the rising edge of WR*

! Write a function that writes a triangular waveform to the DAC

¡ Use your previous count-up code, you may need a delay too…

¡ Or you could transfer data from a look-up table in program memory to your DAC


---

## Page 33

How to Draw Schematics:

Mark Neil - Microprocessor Course

33


---

## Page 34

Some Comments:

Mark Neil - Microprocessor Course

34

! Make a detailed schematic of your circuit with all ICs and the IC pin

assignments.

! Make sure that you understand your design BEFORE you start building

it

! Build the device in steps that you can check. Don’t build the entire

design before testing.

¡ Colour-code your connections.

¡ Think about what tests you can carry out to check that everything works at each step.

¡ Check your power supplies and ground (0V), are they connected correctly?

! Use the oscilloscope (it works as a DVM too) to see what is going on and

debug your circuit.


---

