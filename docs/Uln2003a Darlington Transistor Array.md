# High-Voltage High-Current Darlington Transistor Array (Rev. N)
## Document Information

**Author:** Texas Instruments, Incorporated [SLRS027,N
]

**Subject:** Data Sheet

---

## Page 1

**7C**

**6C**

**5C**

**4C**

**3C**

**2C**

**1C**

**COM**

**7**

**6**

**5**

**4**

**3**

**2**

**1**

**7B**

**6B**

**5B**

**4B**

**3B**

**2B**

**1B**

**10**

**11**

**12**

**13**

**14**

**15**

**16**

**9**

Product
Folder

Sample &
Buy

Technical
Documents

Tools &
Software

Support &
Community

**ULN2002A****,**** ULN2003A****,**** ULN2003AI**

**ULQ2003A****,**** ULN2004A****,**** ULQ2004A**

SLRS027N –DECEMBER 1976–REVISED JUNE 2015
**ULN200x, ULQ200x High-Voltage, High-Current Darlington Transistor Arrays**

The ULx2004A devices have a 10.5-kΩseries base
**1**
**Features**

resistor
to
allow
operation
directly
from
CMOS

1•
500-mA-Rated Collector Current (Single Output)
devices that use supply voltages of 6 V to 15 V. The
•
High-Voltage Outputs: 50 V
required input current of the ULx2004A device is
below that of the ULx2003A devices, and the required
•
Output Clamp Diodes

voltage is less than that required by the ULN2002A
•
Inputs Compatible With Various Types of Logic
device.
•
Relay-Driver Applications

.
**2**
**Applications**
**Device Information****(1)**
•
Relay Drivers
**PART NUMBER**
**PACKAGE**
**BODY SIZE (NOM)**
•
Stepper and DC Brushed Motor Drivers
ULx200xD
SOIC (16)
9.90 mm × 3.91 mm
•
Lamp Drivers
ULx200xN
PDIP (16)
19.30 mm × 6.35 mm
•
Display Drivers (LED and Gas Discharge)
ULN200xNS
SOP (16)
10.30 mm × 5.30 mm

ULN200xPW
TSSOP (16)
5.00 mm × 4.40 mm
•
Line Drivers
•
Logic Buffers
(1) For all available packages, see the orderable addendum at

the end of the data sheet.
**3**
**Description**
.
The ULx200xA devices are high-voltage, high-current
.
Darlington transistor arrays. Each consists of seven
NPN
Darlington
pairs
that
feature
high-voltage
**Simplified Block Diagram**
outputs
with
common-cathode
clamp
diodes
for
switching inductive loads.

The collector-current rating of a single Darlington pair
is 500 mA. The Darlington pairs can be paralleled for
higher current capability. Applications include relay
drivers, hammer drivers, lamp drivers, display drivers
(LED and gas discharge), line drivers, and logic
buffers.
For
100-V
(otherwise
interchangeable)
versions of the ULx2003A devices, see the SLRS023
data sheet for the SN75468 and SN75469 devices.

The ULN2002A device is designed specifically for use
with 14-V to 25-V PMOS devices. Each input of this
device has a Zener diode and resistor in series to
control
the
input
current
to
a
safe
limit.
The
ULx2003A devices have a 2.7-kΩseries base resistor
for each Darlington pair for operation directly with
TTL or 5-V CMOS devices.

1

An IMPORTANT NOTICE at the end of this data sheet addresses availability, warranty, changes, use in safety-critical applications,
intellectual property matters and other important disclaimers. PRODUCTION DATA.


---

## Page 2

**ULN2002A****,**** ULN2003A****,**** ULN2003AI**
**ULQ2003A****,**** ULN2004A****,**** ULQ2004A**

SLRS027N –DECEMBER 1976–REVISED JUNE 2015
**www.ti.com**

**Table of Contents**

**1**
**Features**.................................................................. 1
**7**
**Parameter Measurement Information** ................ 10
**2**
**Applications** ........................................................... 1
**8**
**Detailed Description** ............................................ 12

8.1
Overview ................................................................. 12
**3**
**Description** ............................................................. 1

8.2
Functional Block Diagrams ..................................... 12
**4**
**Revision History**..................................................... 2

8.3
Feature Description................................................. 13
**5**
**Pin Configuration and Functions**......................... 3

8.4
Device Functional Modes........................................ 13
**6**
**Specifications**......................................................... 4

**9**
**Application and Implementation** ........................ 14
6.1
Absolute Maximum Ratings ...................................... 4

9.1
Application Information............................................ 14
6.2
ESD Ratings.............................................................. 4

9.2
Typical Application ................................................. 14
6.3
Recommended Operating Conditions....................... 4

9.3
System Examples ................................................... 17
6.4
Thermal Information.................................................. 4

**10**
**Power Supply Recommendations** ..................... 18
6.5
Electrical Characteristics: ULN2002A ....................... 5

**11**
**Layout**................................................................... 18
6.6
Electrical Characteristics: ULN2003A and
ULN2004A.................................................................. 5
11.1
Layout Guidelines ................................................. 18
6.7
Electrical Characteristics: ULN2003AI ...................... 6
11.2
Layout Example .................................................... 18
6.8
Electrical Characteristics: ULN2003AI ..................... 6
**12**
**Device and Documentation Support** ................. 19
6.9
Electrical Characteristics: ULQ2003A and
12.1
Documentation Support ........................................ 19
ULQ2004A ................................................................. 7
12.2
Related Links ........................................................ 19
6.10
Switching Characteristics: ULN2002A, ULN2003A,
12.3
Community Resources.......................................... 19
ULN2004A.................................................................. 7

12.4
Trademarks........................................................... 19
6.11
Switching Characteristics: ULN2003AI .................. 7

12.5
Electrostatic Discharge Caution............................ 19
6.12
Switching Characteristics: ULN2003AI .................. 8

12.6
Glossary................................................................ 19
6.13
Switching Characteristics: ULQ2003A, ULQ2004A 8

**13**
**Mechanical, Packaging, and Orderable**
6.14
Typical Characteristics............................................ 8
**Information** ........................................................... 19

**4**
**Revision History**
NOTE: Page numbers for previous revisions may differ from page numbers in the current version.

**Changes from Revision M (February 2013) to Revision N**
**Page**

•
Added* Pin Configuration and Functions* section,* ESD Ratings* table,* Feature Description* section,* Device Functional*
*Modes*,* Application and Implementation* section,* Power Supply Recommendations* section,* Layout* section,* Device*
*and Documentation Support* section, and* Mechanical, Packaging, and Orderable Information* section .............................. 1

•
Deleted* Ordering Information* table. No specification changes. ............................................................................................. 1

•
Moved* Typical Characteristics* into* Specifications* section. ................................................................................................... 8

**Changes from Revision L (April 2012) to Revision M**
**Page**

•
Updated temperature rating for ULN2003AI in the ORDERING INFORMATION table ........................................................ 1

**Changes from Revision K (August 2011) to Revision L**
**Page**

•
Removed reference to obsolete ULN2001 device.................................................................................................................. 1

2
*Submit Documentation Feedback*
Copyright © 1976–2015, Texas Instruments Incorporated

Product Folder Links:* ULN2002A ULN2003A ULN2003AI ULQ2003A ULN2004A ULQ2004A*


---

## Page 3

1B
1
16
2B
2
15
3B
3
14
4B
4
13
5B
5
12
6B
6
11
7B
7
10
E
8
9

1C
2C
3C
4C
5C
6C
7C
COM

**ULN2002A****,**** ULN2003A****,**** ULN2003AI**

**ULQ2003A****,**** ULN2004A****,**** ULQ2004A**

**www.ti.com**
SLRS027N –DECEMBER 1976–REVISED JUNE 2015

**5**
**Pin Configuration and Functions**

**D, N, NS, and PW Package**
**16-Pin SOIC, PDIP, SO, and TSSOP**

**Top View**

**Pin Functions**

**PIN**

**I/O****(1)**
**DESCRIPTION**
**NAME**
**NO.**

1B
1

2B
2

3B
3

4B
4
I
Channel 1 through 7 Darlington base input

5B
5

6B
6

7B
7

1C
10

2C
11

3C
12

4C
13
O
Channel 1 through 7 Darlington collector output

5C
14

6C
15

7C
16

COM
8
I/O
Common cathode node for flyback diodes (required for inductive loads)

E
7
—
Common emitter shared by all channels (typically tied to ground)

(1)
I = Input, O = Output

Copyright © 1976–2015, Texas Instruments Incorporated
*Submit Documentation Feedback*
3

Product Folder Links:* ULN2002A ULN2003A ULN2003AI ULQ2003A ULN2004A ULQ2004A*


---

## Page 4

**ULN2002A****,**** ULN2003A****,**** ULN2003AI**
**ULQ2003A****,**** ULN2004A****,**** ULQ2004A**

SLRS027N –DECEMBER 1976–REVISED JUNE 2015
**www.ti.com**

**6**
**Specifications**

**6.1**
**Absolute Maximum Ratings**

at 25°C free-air temperature (unless otherwise noted)(1)

**MIN**
**MAX**
**UNIT**

VCC
Collector-emitter voltage
50
V

Clamp diode reverse voltage(2)
50
V

VI
Input voltage(2)
30
V

Peak collector current, See Figure 4 and Figure 5
500
mA

IOK
Output clamp current
500
mA

Total emitter-terminal current
–2.5
A

ULN200xA
–20
70

ULN200xAI
–40
105
TA
Operating free-air temperature range
°C
ULQ200xA
–40
85

ULQ200xAT
–40
105

TJ
Operating virtual junction temperature
150
°C

Lead temperature for 1.6 mm (1/16 inch) from case for 10 seconds
260
°C

Tstg
Storage temperature
–65
150
°C

(1)
Stresses beyond those listed under* Absolute Maximum Ratings* may cause permanent damage to the device. These are stress ratings
only, and functional operation of the device at these or any other conditions beyond those indicated under* Recommended Operating*
*Conditions* is not implied. Exposure to absolute-maximum-rated conditions for extended periods may affect device reliability.
(2)
All voltage values are with respect to the emitter/substrate terminal E, unless otherwise noted.

**6.2**
**ESD Ratings**

**VALUE**
**UNIT**

Human body model (HBM), per ANSI/ESDA/JEDEC JS-001(1)
±2000
Electrostatic
V(ESD)
V
discharge
Charged device model (CDM), per JEDEC specification JESD22-C101(2)
±500

(1)
JEDEC document JEP155 states that 500-V HBM allows safe manufacturing with a standard ESD control process.
(2)
JEDEC document JEP157 states that 250-V CDM allows safe manufacturing with a standard ESD control process.

**6.3**
**Recommended Operating Conditions**

over operating free-air temperature range (unless otherwise noted)

**MIN**
**MAX**
**UNIT**

VCC
Collector-emitter voltage (non-V devices)
0
50
V

TJ
Junction temperature
–40
125
°C

**6.4**
**Thermal Information**

**ULx200x**

**D**
**N**
**NS**
**PW**
**THERMAL METRIC****(1)**
**UNIT**
**(SOIC)**
**(PDIP)**
**(SO)**
**(TSSOP)**

**16 PINS**
**16 PINS**
**16 PINS**
**16 PINS**

RθJA
Junction-to-ambient thermal resistance
73
67
64
108
°C/W

RθJC(top)
Junction-to-case (top) thermal resistance
36
54
n/a
33.6
°C/W

RθJB
Junction-to-board thermal resistance
n/a
n/a
n/a
51.9
°C/W

ψJT
Junction-to-top characterization parameter
n/a
n/a
n/a
2.1
°C/W

ψJB
Junction-to-board characterization parameter
n/a
n/a
n/a
51.4
°C/W

(1)
For more information about traditional and new thermal metrics, see the* Semiconductor and IC Package Thermal Metrics* application
report, SPRA953.

4
*Submit Documentation Feedback*
Copyright © 1976–2015, Texas Instruments Incorporated

Product Folder Links:* ULN2002A ULN2003A ULN2003AI ULQ2003A ULN2004A ULQ2004A*


---

## Page 5

**ULN2002A****,**** ULN2003A****,**** ULN2003AI**

**ULQ2003A****,**** ULN2004A****,**** ULQ2004A**

**www.ti.com**
SLRS027N –DECEMBER 1976–REVISED JUNE 2015

**6.5**
**Electrical Characteristics: ULN2002A**

TA = 25°C

**ULN2002A**
**PARAMETER**
**TEST FIGURE**
**TEST CONDITIONS**
**UNIT**
**MIN**
**TYP**
**MAX**

VI(on)
ON-state input voltage
Figure 14
VCE = 2 V,
IC = 300 mA
13
V

High-level output voltage after
VOH
Figure 18
VS = 50 V, IO = 300 mA
VS – 20
mV
switching

II = 250 μA,
IC = 100 mA
0.9
1.1
Collector-emitter saturation
VCE(sat)
Figure 12
II = 350 μA,
IC = 200 mA
1
1.3
V
voltage

II = 500 μA,
IC = 350 mA
1.2
1.6

VF
Clamp forward voltage
Figure 15
IF = 350 mA
1.7
2
V

Figure 9
VCE = 50 V,
II = 0
50

ICEX
Collector cutoff current
II = 0
100
μA
VCE = 50 V,
Figure 10
TA = 70°C
VI = 6 V
500

II(off)
OFF-state input current
Figure 10
VCE = 50 V,
IC = 500 μA
50
65
μA

II
Input current
Figure 11
VI = 17 V
0.82
1.25
mA

VR = 50 V
TA = 70°C
100
IR
Clamp reverse current
Figure 14
μA
VR = 50 V
50

Ci
Input capacitance
VI = 0,
f = 1 MHz
25
pF

**6.6**
**Electrical Characteristics: ULN2003A and ULN2004A**

TA = 25°C

**ULN2003A**
**ULN2004A**
**TEST**
**PARAMETER**
**TEST CONDITIONS**
**UNIT**
**FIGURE**
**MIN**
**TYP**
**MAX**
**MIN**
**TYP**
**MAX**

IC = 125 mA
5

IC = 200 mA
2.4
6

IC = 250 mA
2.7
ON-state input
VI(on)
Figure 14
VCE = 2 V
V
voltage
IC = 275 mA
7

IC = 300 mA
3

IC = 350 mA
8

High-level output
VOH
voltage after
Figure 18
VS = 50 V, IO = 300 mA
VS – 20
VS – 20
mV
switching

II = 250 μA,
IC = 100 mA
0.9
1.1
0.9
1.1
Collector-emitter
VCE(sat)
Figure 13
II = 350 μA,
IC = 200 mA
1
1.3
1
1.3
V
saturation voltage

II = 500 μA,
IC = 350 mA
1.2
1.6
1.2
1.6

Figure 9
VCE = 50 V,
II = 0
50
50
Collector cutoff
ICEX
II = 0
100
100
μA
VCE = 50 V,
current
Figure 10
TA = 70°C
VI = 6 V
500

Clamp forward
IF = 350 mA
VF
Figure 16
1.7
2
1.7
2
V
voltage

Off-state input
VCE = 50 V,
II(off)
Figure 11
IC = 500 μA
50
65
50
65
μA
current
TA = 70°C,

VI = 3.85 V
0.93
1.35

II
Input current
Figure 12
VI = 5 V
0.35
0.5
mA

VI = 12 V
1
1.45

VR = 50 V
50
50
Clamp reverse
IR
Figure 15
μA
current
VR = 50 V
TA = 70°C
100
100

Ci
Input capacitance
VI = 0,
f = 1 MHz
15
25
15
25
pF

Copyright © 1976–2015, Texas Instruments Incorporated
*Submit Documentation Feedback*
5

Product Folder Links:* ULN2002A ULN2003A ULN2003AI ULQ2003A ULN2004A ULQ2004A*


---

## Page 6

**ULN2002A****,**** ULN2003A****,**** ULN2003AI**
**ULQ2003A****,**** ULN2004A****,**** ULQ2004A**

SLRS027N –DECEMBER 1976–REVISED JUNE 2015
**www.ti.com**

**6.7**
**Electrical Characteristics: ULN2003AI**

TA = 25°C

**ULN2003AI**
**TEST**
**PARAMETER**
**TEST FIGURE**
**UNIT**
**CONDITIONS**
**MIN**
**TYP**
**MAX**

IC = 200 mA
2.4

VI(on)
ON-state input voltage
Figure 14
VCE = 2 V
IC = 250 mA
2.7
V

IC = 300 mA
3

High-level output voltage after
VOH
Figure 18
VS = 50 V, IO = 300 mA
VS – 50
mV
switching

II = 250 μA,
IC = 100 mA
0.9
1.1

VCE(sat)
Collector-emitter saturation voltage
Figure 13
II = 350 μA,
IC = 200 mA
1
1.3
V

II = 500 μA,
IC = 350 mA
1.2
1.6

ICEX
Collector cutoff current
Figure 9
VCE = 50 V,
II = 0
50
μA

VF
Clamp forward voltage
Figure 16
IF = 350 mA
1.7
2
V

II(off)
OFF-state input current
Figure 11
VCE = 50 V,
IC = 500 μA
50
65
μA

II
Input current
Figure 12
VI = 3.85 V
0.93
1.35
mA

IR
Clamp reverse current
Figure 15
VR = 50 V
50
μA

Ci
Input capacitance
VI = 0,
f = 1 MHz
15
25
pF

**6.8**
**Electrical Characteristics: ULN2003AI**

TA = –40°C to 105°C

**ULN2003AI**
**PARAMETER**
**TEST FIGURE**
**TEST CONDITIONS**
**UNIT**
**MIN**
**TYP**
**MAX**

IC = 200 mA
2.7

VI(on)
ON-state input voltage
Figure 14
VCE = 2 V
IC = 250 mA
2.9
V

IC = 300 mA
3

High-level output voltage after
VOH
Figure 18
VS = 50 V, IO = 300 mA
VS – 50
mV
switching

II = 250 μA,
IC = 100 mA
0.9
1.2

VCE(sat)
Collector-emitter saturation voltage
Figure 13
II = 350 μA,
IC = 200 mA
1
1.4
V

II = 500 μA,
IC = 350 mA
1.2
1.7

ICEX
Collector cutoff current
Figure 9
VCE = 50 V,
II = 0
100
μA

VF
Clamp forward voltage
Figure 16
IF = 350 mA
1.7
2.2
V

II(off)
OFF-state input current
Figure 11
VCE = 50 V,
IC = 500 μA
30
65
μA

II
Input current
Figure 12
VI = 3.85 V
0.93
1.35
mA

IR
Clamp reverse current
Figure 15
VR = 50 V
100
μA

Ci
Input capacitance
VI = 0,
f = 1 MHz
15
25
pF

6
*Submit Documentation Feedback*
Copyright © 1976–2015, Texas Instruments Incorporated

Product Folder Links:* ULN2002A ULN2003A ULN2003AI ULQ2003A ULN2004A ULQ2004A*


---

## Page 7

**ULN2002A****,**** ULN2003A****,**** ULN2003AI**

**ULQ2003A****,**** ULN2004A****,**** ULQ2004A**

**www.ti.com**
SLRS027N –DECEMBER 1976–REVISED JUNE 2015

**6.9**
**Electrical Characteristics: ULQ2003A and ULQ2004A**

over recommended operating conditions (unless otherwise noted)

**ULQ2003A**
**ULQ2004A**
**TEST**
**PARAMETER**
**TEST CONDITIONS**
**UNIT**
**FIGURE**
**MIN**
**TYP**
**MAX**
**MIN**
**TYP**
**MAX**

IC = 125 mA
5

IC = 200 mA
2.7
6

IC = 250 mA
2.9
ON-state input
VI(on)
Figure 14
VCE = 2 V
V
voltage
IC = 275 mA
7

IC = 300 mA
3

IC = 350 mA
8

High-level output
VOH
voltage after
Figure 18
VS = 50 V, IO = 300 mA
VS – 50
VS – 50
mV
switching

II = 250 μA,
IC = 100 mA
0.9
1.2
0.9
1.1
Collector-emitter
VCE(sat)
Figure 13
II = 350 μA,
IC = 200 mA
1
1.4
1
1.3
V
saturation voltage

II = 500 μA,
IC = 350 mA
1.2
1.7
1.2
1.6

Figure 9
VCE = 50 V,
II = 0
100
50
Collector cutoff
ICEX
VCE = 50 V,
II = 0
100
μA
current
Figure 10
TA = 70°C
VI = 6 V
500

Clamp forward
VF
Figure 16
IF = 350 mA
1.7
2.3
1.7
2
V
voltage

OFF-state input
VCE = 50 V,
II(off)
Figure 11
IC = 500 μA
65
50
65
μA
current
TA = 70°C,

VI = 3.85 V
0.93
1.35

II
Input current
Figure 12
VI = 5 V
0.35
0.5
mA

VI = 12 V
1
1.45

VR = 50 V
TA = 25°C
100
50
Clamp reverse
IR
Figure 15
μA
current
VR = 50 V
100
100

Ci
Input capacitance
VI = 0,
f = 1 MHz
15
25
15
25
pF

**6.10**
**Switching Characteristics: ULN2002A, ULN2003A, ULN2004A**

TA = 25°C

**ULN2002A, ULN2003A,**

**ULN2004A**
**PARAMETER**
**TEST CONDITIONS**
**UNIT**
**MIN**
**TYP**
**MAX**

tPLH
Propagation delay time, low- to high-level output
See Figure 17
0.25
1
μs

tPHL
Propagation delay time, high- to low-level output
See Figure 17
0.25
1
μs

**6.11**
**Switching Characteristics: ULN2003AI**

TA = 25°C

**ULN2003AI**
**PARAMETER**
**TEST CONDITIONS**
**UNIT**
**MIN**
**TYP**
**MAX**

tPLH
Propagation delay time, low- to high-level output
See Figure 17
0.25
1
μs

tPHL
Propagation delay time, high- to low-level output
See Figure 17
0.25
1
μs

Copyright © 1976–2015, Texas Instruments Incorporated
*Submit Documentation Feedback*
7

Product Folder Links:* ULN2002A ULN2003A ULN2003AI ULQ2003A ULN2004A ULQ2004A*


---

## Page 8

**2**

**1.5**

**1**

**0.5**

**700**
**600**
**500**
**400**
**300**
**200**
**100**
**0**
**800**

**2.5**

**IC(tot) - Total Collector Current - mA**

**0**

**VCE(sat) - Collector-Emitter Saturation Voltage - V**
**VCE(sat)**

**II = 250** µ**A**

**II = 350** µ**A**

**II = 500** µ**A**

**TA = 25**°**C**

**0**

**IC - Collector Current - mA**

**2.5**

**800**
**0**

**100**
**200**
**300**
**400**
**500**
**600**
**700**

**0.5**

**1**

**1.5**

**2**

**II = 350** µ**A**
**II = 500** µ**A**

**VCE(sat) - Collector-Emitter Saturation Voltage - V**
**VCE(sat)**

**TA = 25**°**C**

**II = 250** µ**A**

**ULN2002A****,**** ULN2003A****,**** ULN2003AI**
**ULQ2003A****,**** ULN2004A****,**** ULQ2004A**

SLRS027N –DECEMBER 1976–REVISED JUNE 2015
**www.ti.com**

**6.12**
**Switching Characteristics: ULN2003AI**

TA = –40°C to 105°C

**ULN2003AI**
**PARAMETER**
**TEST CONDITIONS**
**UNIT**
**MIN**
**TYP**
**MAX**

tPLH
Propagation delay time, low- to high-level output
See Figure 17
1
10
μs

tPHL
Propagation delay time, high- to low-level output
See Figure 17
1
10
μs

**6.13**
**Switching Characteristics: ULQ2003A, ULQ2004A**

over recommended operating conditions (unless otherwise noted)

**ULQ2003A, ULQ2004A**
**PARAMETER**
**TEST CONDITIONS**
**UNIT**
**MIN**
**TYP**
**MAX**

tPLH
Propagation delay time, low- to high-level output
See Figure 17
1
10
μs

tPHL
Propagation delay time, high- to low-level output
See Figure 17
1
10
μs

**6.14**
**Typical Characteristics**

**Figure 1. Collector-Emitter Saturation Voltage**
**Figure 2. Collector-Emitter Saturation Voltage**
**vs Collector Current (One Darlington)**
**vs Total Collector Current (Two Darlingtons in Parallel)**

8
*Submit Documentation Feedback*
Copyright © 1976–2015, Texas Instruments Incorporated

Product Folder Links:* ULN2002A ULN2003A ULN2003AI ULQ2003A ULN2004A ULQ2004A*


---

## Page 9

**0.9**

**1.1**

**1.3**

**1.5**

**1.7**

**1.9**

**2.1**

**100**
**200**
**300**
**400**
**500**

**Output Current – mA**

**Maximum V****CE(sat)**** Voltage  – V**

**T****J**** = -40°C to 105°C**

**Maximum**

**Typical**

**100**

**150**

**200**

**250**

**300**

**350**

**400**

**450**

**500**

**250**
**350**
**450**
**550**
**650**

**Input Current – µA**

**Output Current – mA**

**V****CE**** = 2 V**
**T****J**** = -40°C to 105°C**

**Minimum**

**Conducting Simultaneously**
**N = Number of Outputs**

**500**

**400**

**300**

**200**

**100**

**90**
**80**
**70**
**60**
**50**
**40**
**30**
**20**
**10**
**0**
**100**

**600**

**Duty Cycle - %**

**0**

**N = 7**

**TA = 85**°**C**

**N = 5**

**N = 3**
**N = 2**

**N = 6**

**N = 1**

**IC - Maximum Collector Current - mA**
**C**
**I**

**N = 4**

**0**

**200**

**400**

**600**

**800**

**1000**

**1200**

**1400**

**1600**

**1800**

**2000**

**2**
**2.5**
**3**
**3.5**
**4**
**4.5**
**5**
**Input Voltage – V**

**Input Current – µA**

**T****J**** = -40°C to 105°C**

**Maximum**

**Typical**

**0**

**Duty Cycle - %**

**600**

**100**
**0**
**10**
**20**
**30**
**40**
**50**
**60**
**70**
**80**
**90**

**100**

**200**

**300**

**400**

**500**

**TA = 70**°**C**

**N = Number of Outputs**

**Conducting Simultaneously**

**N = 6**
**N = 7**
**N = 5**

**N = 3**

**N = 2**

**N = 1**

**IC - Maximum Collector Current - mA**
**C**
**I**

**N = 4**

**0**

**II - Input Current -** µ**A**

**500**

**200**
**0**
**25**
**50**
**75**
**100**
**125**
**150**
**175**

**50**

**100**

**150**

**200**

**250**

**300**

**350**

**400**

**450**

**VS = 10 V**

**VS = 8 V**

**IC - Collector Current - mA**
**C**
**I**

**RL = 10** Ω
**TA = 25**°**C**

**ULN2002A****,**** ULN2003A****,**** ULN2003AI**

**ULQ2003A****,**** ULN2004A****,**** ULQ2004A**

**www.ti.com**
SLRS027N –DECEMBER 1976–REVISED JUNE 2015

**Typical Characteristics (continued)**

**Figure 3. Collector Current vs Input Current**
**Figure 4. D Package Maximum Collector Current**

**vs Duty Cycle**

**Figure 6. Maximum and Typical Input Current**
**Figure 5. N Package Maximum Collector Current**

**vs Input Voltage**
**vs Duty Cycle**

**Figure 7. Maximum and Typical Saturated V****CE**
**Figure 8. Minimum Output Current vs Input Current**
**vs Output Current**

Copyright © 1976–2015, Texas Instruments Incorporated
*Submit Documentation Feedback*
9

Product Folder Links:* ULN2002A ULN2003A ULN2003AI ULQ2003A ULN2004A ULQ2004A*


---

## Page 10

**Open**

**VCE**
**IC**
**II**

**hFE = ****IC**
**II**

**Open**

**VCE**
**IC**
**VI(on)**

**Open**
**VCE**

**IC**
**II(off)**

**Open**

**Open**

**II(on)**

**VI**

**Open**
**VCE**

**Open**

**ICEX**

**Open**
**VCE**

**VI**

**ICEX**

**ULN2002A****,**** ULN2003A****,**** ULN2003AI**
**ULQ2003A****,**** ULN2004A****,**** ULQ2004A**

SLRS027N –DECEMBER 1976–REVISED JUNE 2015
**www.ti.com**

**7**
**Parameter Measurement Information**

**Figure 9. I****CEX**** Test Circuit**
**Figure 10. I****CEX**** Test Circuit**

**Figure 11. I****I(off)**** Test Circuit**
**Figure 12. I****I**** Test Circuit**

II is fixed for measuring VCE(sat), variable for measuring hFE.

**Figure 13. h****FE****, V****CE(sat)**** Test Circuit**
**Figure 14. V****I(on)**** Test Circuit**

10
*Submit Documentation Feedback*
Copyright © 1976–2015, Texas Instruments Incorporated

Product Folder Links:* ULN2002A ULN2003A ULN2003AI ULQ2003A ULN2004A ULQ2004A*


---

## Page 11

**90%**
**90%**
**1.5 V**
**1.5 V**
**10%**
**10%**
**40** µ**s**

≤**10 ns**
≤**5 ns**

**VIH**
**(see Note C)**

**0 V**

**VOH**

**VOL**

**Input**

**Output**

**VOLTAGE WAVEFORMS**

**200** W

**VR**

**Open**

**IR**
**IF**
**VF**

**Open**

**ULN2002A****,**** ULN2003A****,**** ULN2003AI**

**ULQ2003A****,**** ULN2004A****,**** ULQ2004A**

**www.ti.com**
SLRS027N –DECEMBER 1976–REVISED JUNE 2015

**Parameter Measurement Information (continued)**

**Figure 15. I****R**** Test Circuit**
**Figure 16. V****F**** Test Circuit**

**Figure 17. Propagation Delay-Time Waveforms**

The pulse generator has the following characteristics: PRR = 12.5 kHz, ZO = 50 Ω.

CL includes probe and jig capacitance.

For testing the ULN2003A device, ULN2003AI device, and ULQ2003A devices, VIH = 3 V; for the ULN2002A device,
VIH = 13 V; for the ULN2004A and the ULQ2004A devices, VIH = 8 V.

**Figure 18. Latch-Up Test Circuit and Voltage Waveforms**

Copyright © 1976–2015, Texas Instruments Incorporated
*Submit Documentation Feedback*
11

Product Folder Links:* ULN2002A ULN2003A ULN2003AI ULQ2003A ULN2004A ULQ2004A*


---

## Page 12

COM

Output C

E

Input B

RB
2.7 N

7.2 N
3 N

COM

Output C

E

Input B

RB
10.5 N

7.2 N
3 N

COM

Output C

E

Input B

10.5 N

7.2 N
3 N

7 V

**ULN2002A****,**** ULN2003A****,**** ULN2003AI**
**ULQ2003A****,**** ULN2004A****,**** ULQ2004A**

SLRS027N –DECEMBER 1976–REVISED JUNE 2015
**www.ti.com**

**8**
**Detailed Description**

**8.1**
**Overview**

This standard device has proven ubiquity and versatility across a wide range of applications. This is due to
integration of 7 Darlington transistors of the device that are capable of sinking up to 500 mA and wide GPIO
range capability.

The ULN2003A device comprises seven high-voltage, high-current NPN Darlington transistor pairs. All units
feature a common emitter and open collector outputs. To maximize their effectiveness, these units contain
suppression diodes for inductive loads. The ULN2003A device has a series base resistor to each Darlington pair,
thus allowing operation directly with TTL or CMOS operating at supply voltages of 5 V or 3.3 V. The ULN2003A
device offers solutions to a great many interface needs, including solenoids, relays, lamps, small motors, and
LEDs. Applications requiring sink currents beyond the capability of a single output may be accommodated by
paralleling the outputs.

This device can operate over a wide temperature range (–40°C to 105°C).

**8.2**
**Functional Block Diagrams**

All resistor values shown are nominal. The collector-emitter diode is a parasitic structure and should not be used
to conduct current. If the collectors go below GND, an external Schottky diode should be added to clamp
negative undershoots.

**Figure 19. ULN2002A Block Diagram**

**Figure 20. ULN2003A, ULQ2003A and ULN2003AI**
**Figure 21. ULN2004A and LQ2004A Block Diagram**
**Block Diagram**

12
*Submit Documentation Feedback*
Copyright © 1976–2015, Texas Instruments Incorporated

Product Folder Links:* ULN2002A ULN2003A ULN2003AI ULQ2003A ULN2004A ULQ2004A*


---

## Page 13

**ULN2002A****,**** ULN2003A****,**** ULN2003AI**

**ULQ2003A****,**** ULN2004A****,**** ULQ2004A**

**www.ti.com**
SLRS027N –DECEMBER 1976–REVISED JUNE 2015

**8.3**
**Feature Description**

Each channel of the ULN2003A device consists of Darlington connected NPN transistors. This connection
creates the effect of a single transistor with a very high-current gain (β2). This can be as high as 10,000 A/A at
certain currents. The very high β allows for high-output current drive with a very low input current, essentially
equating to operation with low GPIO voltages.

The GPIO voltage is converted to base current through the 2.7-kΩ resistor connected between the input and
base of the predriver Darlington NPN. The 7.2-kΩ and 3-kΩ resistors connected between the base and emitter of
each respective NPN act as pulldowns and suppress the amount of leakage that may occur from the input.

The diodes connected between the output and COM pin is used to suppress the kick-back voltage from an
inductive load that is excited when the NPN drivers are turned off (stop sinking) and the stored energy in the
coils causes a reverse current to flow into the coil supply through the kick-back diode.

In normal operation the diodes on base and collector pins to emitter will be reversed biased. If these diodes are
forward biased, internal parasitic NPN transistors will draw (a nearly equal) current from other (nearby) device
pins.

**8.4**
**Device Functional Modes**

**8.4.1**
**Inductive Load Drive**

When the COM pin is tied to the coil supply voltage, ULN2003A device is able to drive inductive loads and
suppress the kick-back voltage through the internal free-wheeling diodes.

**8.4.2**
**Resistive Load Drive**

When driving a resistive load, a pullup resistor is needed in order for ULN2003A device to sink current and for
there to be a logic high level. The COM pin can be left floating for these applications.

Copyright © 1976–2015, Texas Instruments Incorporated
*Submit Documentation Feedback*
13

Product Folder Links:* ULN2002A ULN2003A ULN2003AI ULQ2003A ULN2004A ULQ2004A*


---

## Page 14

IN1

IN2

ULN2003A

IN3

IN4

OUT1

OUT2

OUT3

OUT4

IN5

IN6

IN7

GND

OUT5

OUT6

OUT7

COM

3.3-V Logic

3.3-V Logic

3.3-V Logic

VSUP

VSUP

**ULN2002A****,**** ULN2003A****,**** ULN2003AI**
**ULQ2003A****,**** ULN2004A****,**** ULQ2004A**

SLRS027N –DECEMBER 1976–REVISED JUNE 2015
**www.ti.com**

**9**
**Application and Implementation**

**NOTE**
Information in the following applications sections is not part of the TI component
specification, and TI does not warrant its accuracy or completeness. TI’s customers are
responsible for determining suitability of components for their purposes. Customers should
validate and test their design implementation to confirm system functionality.

**9.1**
**Application Information**

Typically, the ULN2003A device drives a high-voltage or high-current (or both) peripheral from an MCU or logic
device that cannot tolerate these conditions. This design is a common application of ULN2003A device, driving
inductive loads. This includes motors, solenoids and relays. Figure 22 shows a model for each load type.

**9.2**
**Typical Application**

**Figure 22. ULN2003A Device as Inductive Load Driver**

**9.2.1**
**Design Requirements**

For this design example, use the parameters listed in Table 1 as the input parameters.

**Table 1. Design Parameters**

**DESIGN PARAMETER**
**EXAMPLE VALUE**

GPIO voltage
3.3 V or 5 V

Coil supply voltage
12 V to 48 V

Number of channels
7

Output current (RCOIL)
20 mA to 300 mA per channel

Duty cycle
100%

14
*Submit Documentation Feedback*
Copyright © 1976–2015, Texas Instruments Incorporated

Product Folder Links:* ULN2002A ULN2003A ULN2003AI ULQ2003A ULN2004A ULQ2004A*


---

## Page 15

(
)
J(MAX)
A
(MAX)
JA

T
T
PD
-
=
q

N

D
OLi
Li
i 1
P
V
I

=
=
´
å

**ULN2002A****,**** ULN2003A****,**** ULN2003AI**

**ULQ2003A****,**** ULN2004A****,**** ULQ2004A**

**www.ti.com**
SLRS027N –DECEMBER 1976–REVISED JUNE 2015

**9.2.2**
**Detailed Design Procedure**

When using ULN2003A device in a coil driving application, determine the following:
•
Input voltage range
•
Temperature range
•
Output and drive current
•
Power dissipation

***9.2.2.1***
***Drive Current***

The coil voltage (VSUP), coil resistance (RCOIL), and low-level output voltage (VCE(SAT) or VOL) determine the coil
current.

ICOIL = (VSUP – VCE(SAT)) / RCOIL
(1)

***9.2.2.2***
***Low-Level Output Voltage***

The low-level output voltage (VOL) is the same as VCE(SAT) and can be determined by, Figure 1, Figure 2, or
Figure 7.

***9.2.2.3***
***Power Dissipation and Temperature***

The number of coils driven is dependent on the coil current and on-chip power dissipation. The number of coils
driven can be determined by Figure 4 or Figure 5.

For a more accurate determination of number of coils possible, use the below equation to calculate ULN2003A
device on-chip power dissipation PD:

where

•
N is the number of channels active together
•
VOLi is the OUTi pin voltage for the load current ILi. This is the same as VCE(SAT)
(2)

To ensure reliability of ULN2003A device and the system, the on-chip power dissipation must be lower that or
equal to the maximum allowable power dissipation (PD(MAX)) dictated by below equation Equation 3.

where

•
TJ(max) is the target maximum junction temperature
•
TA is the operating ambient temperature
•
RθJA is the package junction to ambient thermal resistance
(3)

Limit the die junction temperature of the ULN2003A device to less than 125°C. The IC junction temperature is
directly proportional to the on-chip power dissipation.

Copyright © 1976–2015, Texas Instruments Incorporated
*Submit Documentation Feedback*
15

Product Folder Links:* ULN2002A ULN2003A ULN2003AI ULQ2003A ULN2004A ULQ2004A*


---

## Page 16

Time (s)

Output voltage - V

-0.004
0
0.004
0.008
0.012
0.016
0
1
2
3
4
5
6
7
8
9
10
11
12
13

D001
Time (s)

Output voltage - V

-0.004
0
0.004
0.008
0.012
0.016
0

2

4

6

8

10

12

14

D001

**ULN2002A****,**** ULN2003A****,**** ULN2003AI**
**ULQ2003A****,**** ULN2004A****,**** ULQ2004A**

SLRS027N –DECEMBER 1976–REVISED JUNE 2015
**www.ti.com**

**9.2.3**
**Application Curves**

The characterization data shown in Figure 23 and Figure 24 were generated using the ULN2003A device driving
an OMRON G5NB relay and under the following conditions: VIN = 5 V, VSUP= 12 V, and RCOIL= 2.8 kΩ.

**Figure 23. Output Response With Activation of Coil**
**Figure 24. Output Response With De-activation of Coil**
**(Turnon)**
**(Turnoff)**

16
*Submit Documentation Feedback*
Copyright © 1976–2015, Texas Instruments Incorporated

Product Folder Links:* ULN2002A ULN2003A ULN2003AI ULQ2003A ULN2004A ULQ2004A*


---

## Page 17

**VCC**
**V**

**RP**

**ULQ2003A**

**1**

**2**

**3**

**4**

**5**

**6**

**9**

**10**

**11**

**12**

**13**

**14**

**15**

**16**

**8**

**TTL**
**Output**

**7**

**VDD**
**V**
**ULN2004A**
**ULQ2004A**

**1**

**2**

**3**

**4**

**5**

**6**

**9**

**10**

**11**

**12**

**13**

**14**

**15**

**16**

**8**
**CMOS**
**Output**

**7**

**1**

**2**

**3**

**4**

**5**

**6**

**7**

**9**

**10**

**11**

**12**

**13**

**14**

**15**

**16**

**8**

**ULN2002A**

**P-MOS**
**Output**

**VSS**
**V**
**ULQ2003A**

**Lam**
**Test**
**TTL**
**Output**

**VCC**
**V**

**1**

**2**

**3**

**4**

**5**

**6**

**9**

**10**

**11**

**12**

**13**

**14**

**15**

**16**

**8**

**7**

**ULN2002A****,**** ULN2003A****,**** ULN2003AI**

**ULQ2003A****,**** ULN2004A****,**** ULQ2004A**

**www.ti.com**
SLRS027N –DECEMBER 1976–REVISED JUNE 2015

**9.3**
**System Examples**

**Figure 25. P-MOS to Load**
**Figure 26. TTL to Load**

**Figure 27. Buffer for Higher Current Loads**
**Figure 28. Use of Pullup Resistors to Increase**

**Drive Current**

Copyright © 1976–2015, Texas Instruments Incorporated
*Submit Documentation Feedback*
17

Product Folder Links:* ULN2002A ULN2003A ULN2003AI ULQ2003A ULN2004A ULQ2004A*


---

## Page 18

 1  

 2  
 3  
 4  

8



VCOM



7




6




5





16





E  









9  


15

14

13

12

11

10

1B
2B

3B

4B

7B

6B

5B

1C
2C

3C

4C

7C

6C

5C

GND

**ULN2002A****,**** ULN2003A****,**** ULN2003AI**
**ULQ2003A****,**** ULN2004A****,**** ULQ2004A**

SLRS027N –DECEMBER 1976–REVISED JUNE 2015
**www.ti.com**

**10**
**Power Supply Recommendations**

This device does not need a power supply. However, the COM pin is typically tied to the system power supply.
When this is the case, it is very important to ensure that the output voltage does not heavily exceed the COM pin
voltage. This discrepancy heavily forward biases the fly-back diodes and causes a large current to flow into
COM, potentially damaging the on-chip metal or over-heating the device.

**11**
**Layout**

**11.1**
**Layout Guidelines**

Thin traces can be used on the input due to the low-current logic that is typically used to drive ULN2003A device.
Take care to separate the input channels as much as possible, as to eliminate crosstalk. TI recommends thick
traces for the output to drive whatever high currents that may be needed. Wire thickness can be determined by
the current density of the trace material and desired drive current.

Because all of the channels currents return to a common emitter, it is best to size that trace width to be very
wide. Some applications require up to 2.5 A.

**11.2**
**Layout Example**

**Figure 29. Package Layout**

18
*Submit Documentation Feedback*
Copyright © 1976–2015, Texas Instruments Incorporated

Product Folder Links:* ULN2002A ULN2003A ULN2003AI ULQ2003A ULN2004A ULQ2004A*


---

## Page 19

**ULN2002A****,**** ULN2003A****,**** ULN2003AI**

**ULQ2003A****,**** ULN2004A****,**** ULQ2004A**

**www.ti.com**
SLRS027N –DECEMBER 1976–REVISED JUNE 2015

**12**
**Device and Documentation Support**

**12.1**
**Documentation Support**

**12.1.1**
**Related Documentation**

For related documentation, see the following:

*SN7546x Darlington Transistor Arrays*, SLRS023

**12.2**
**Related Links**

The table below lists quick access links. Categories include technical documents, support and community
resources, tools and software, and quick access to sample or buy.

**Table 2. Related Links**

**TECHNICAL**
**TOOLS &**
**SUPPORT &**
**PARTS**
**PRODUCT FOLDER**
**SAMPLE & BUY**
**DOCUMENTS**
**SOFTWARE**
**COMMUNITY**

ULN2002A
Click here
Click here
Click here
Click here
Click here

ULN2003A
Click here
Click here
Click here
Click here
Click here

ULN2003AI
Click here
Click here
Click here
Click here
Click here

ULN2004A
Click here
Click here
Click here
Click here
Click here

ULQ2003A
Click here
Click here
Click here
Click here
Click here

ULQ2004A
Click here
Click here
Click here
Click here
Click here

**12.3**
**Community Resources**

The following links connect to TI community resources. Linked contents are provided "AS IS" by the respective
contributors. They do not constitute TI specifications and do not necessarily reflect TI's views; see TI's Terms of
Use.

**TI E2E™Online Community***** TI's Engineer-to-Engineer (E2E) Community.*** Created to foster collaboration

among engineers. At e2e.ti.com, you can ask questions, share knowledge, explore ideas and help
solve problems with fellow engineers.

**Design Support***** TI's Design Support*** Quickly find helpful E2E forums along with design support tools and

contact information for technical support.

**12.4**
**Trademarks**
E2E is a trademark of Texas Instruments.
All other trademarks are the property of their respective owners.

**12.5**
**Electrostatic Discharge Caution**

These devices have limited built-in ESD protection. The leads should be shorted together or the device placed in conductive foam
during storage or handling to prevent electrostatic damage to the MOS gates.

**12.6**
**Glossary**

SLYZ022 —* TI Glossary*.

This glossary lists and explains terms, acronyms, and definitions.

**13**
**Mechanical, Packaging, and Orderable Information**

The following pages include mechanical packaging and orderable information. This information is the most
current data available for the designated devices. This data is subject to change without notice and revision of
this document. For browser based versions of this data sheet, refer to the left hand navigation.

Copyright © 1976–2015, Texas Instruments Incorporated
*Submit Documentation Feedback*
19

Product Folder Links:* ULN2002A ULN2003A ULN2003AI ULQ2003A ULN2004A ULQ2004A*


---

## Page 20

**PACKAGE OPTION ADDENDUM**

www.ti.com
5-May-2015

Addendum-Page 1

**PACKAGING INFORMATION**

**Orderable Device**
**Status**

(1)

**Package Type Package**
**Drawing**

**Pins Package**
**Qty**

**Eco Plan**

(2)

**Lead/Ball Finish**

(6)

**MSL Peak Temp**

(3)

**Op Temp (°C)**
**Device Marking**

(4/5)

**Samples**

ULN2001AD
OBSOLETE
SOIC
D
16
TBD
Call TI
Call TI

ULN2001ADR
OBSOLETE
SOIC
D
16
TBD
Call TI
Call TI

ULN2001AN
OBSOLETE
PDIP
N
16
TBD
Call TI
Call TI

ULN2002AD
OBSOLETE
SOIC
D
16
TBD
Call TI
Call TI

ULN2002AN
ACTIVE
PDIP
N
16
25
Pb-Free
(RoHS)

CU NIPDAU
N / A for Pkg Type
-20 to 70
ULN2002AN

ULN2002ANE4
ACTIVE
PDIP
N
16
25
Pb-Free
(RoHS)

CU NIPDAU
N / A for Pkg Type
-20 to 70
ULN2002AN

ULN2003AD
ACTIVE
SOIC
D
16
40
Green (RoHS
& no Sb/Br)

CU NIPDAU
Level-1-260C-UNLIM
-20 to 70
ULN2003A

ULN2003ADE4
ACTIVE
SOIC
D
16
40
Green (RoHS
& no Sb/Br)

CU NIPDAU
Level-1-260C-UNLIM
-20 to 70
ULN2003A

ULN2003ADG4
ACTIVE
SOIC
D
16
40
Green (RoHS
& no Sb/Br)

CU NIPDAU
Level-1-260C-UNLIM
-20 to 70
ULN2003A

ULN2003ADR
ACTIVE
SOIC
D
16
2500
Green (RoHS
& no Sb/Br)

CU NIPDAU | CU SN
Level-1-260C-UNLIM
-20 to 70
ULN2003A

ULN2003ADRE4
ACTIVE
SOIC
D
16
2500
Green (RoHS
& no Sb/Br)

CU NIPDAU
Level-1-260C-UNLIM
-20 to 70
ULN2003A

ULN2003ADRG3
ACTIVE
SOIC
D
16
2500
Green (RoHS
& no Sb/Br)

CU SN
Level-1-260C-UNLIM
-20 to 70
ULN2003A

ULN2003ADRG4
ACTIVE
SOIC
D
16
2500
Green (RoHS
& no Sb/Br)

CU NIPDAU
Level-1-260C-UNLIM
-20 to 70
ULN2003A

ULN2003AID
ACTIVE
SOIC
D
16
40
Green (RoHS
& no Sb/Br)

CU NIPDAU
Level-1-260C-UNLIM
-40 to 105
ULN2003AI

ULN2003AIDE4
ACTIVE
SOIC
D
16
40
Green (RoHS
& no Sb/Br)

CU NIPDAU
Level-1-260C-UNLIM
-40 to 105
ULN2003AI

ULN2003AIDG4
ACTIVE
SOIC
D
16
40
Green (RoHS
& no Sb/Br)

CU NIPDAU
Level-1-260C-UNLIM
-40 to 105
ULN2003AI

ULN2003AIDR
ACTIVE
SOIC
D
16
2500
Green (RoHS
& no Sb/Br)

CU NIPDAU | CU SN
Level-1-260C-UNLIM
-40 to 105
ULN2003AI

ULN2003AIDRE4
ACTIVE
SOIC
D
16
2500
Green (RoHS
& no Sb/Br)

CU NIPDAU
Level-1-260C-UNLIM
-40 to 105
ULN2003AI

ULN2003AIDRG4
ACTIVE
SOIC
D
16
2500
Green (RoHS
& no Sb/Br)

CU NIPDAU
Level-1-260C-UNLIM
-40 to 105
ULN2003AI


---

## Page 21

**PACKAGE OPTION ADDENDUM**

www.ti.com
5-May-2015

Addendum-Page 2

**Orderable Device**
**Status**

(1)

**Package Type Package**
**Drawing**

**Pins Package**
**Qty**

**Eco Plan**

(2)

**Lead/Ball Finish**

(6)

**MSL Peak Temp**

(3)

**Op Temp (°C)**
**Device Marking**

(4/5)

**Samples**

ULN2003AIN
ACTIVE
PDIP
N
16
25
Pb-Free
(RoHS)

CU NIPDAU | CU SN
N / A for Pkg Type
-40 to 105
ULN2003AIN

ULN2003AINE4
ACTIVE
PDIP
N
16
25
Pb-Free
(RoHS)

CU NIPDAU
N / A for Pkg Type
-40 to 105
ULN2003AIN

ULN2003AINSR
ACTIVE
SO
NS
16
2000
Green (RoHS
& no Sb/Br)

CU NIPDAU
Level-1-260C-UNLIM
-40 to 105
ULN2003AI

ULN2003AIPW
ACTIVE
TSSOP
PW
16
90
Green (RoHS
& no Sb/Br)

CU NIPDAU
Level-1-260C-UNLIM
-40 to 105
UN2003AI

ULN2003AIPWE4
ACTIVE
TSSOP
PW
16
90
Green (RoHS
& no Sb/Br)

CU NIPDAU
Level-1-260C-UNLIM
-40 to 105
UN2003AI

ULN2003AIPWG4
ACTIVE
TSSOP
PW
16
90
Green (RoHS
& no Sb/Br)

CU NIPDAU
Level-1-260C-UNLIM
-40 to 105
UN2003AI

ULN2003AIPWR
ACTIVE
TSSOP
PW
16
2000
Green (RoHS
& no Sb/Br)

CU NIPDAU | CU SN
Level-1-260C-UNLIM
-40 to 105
UN2003AI

ULN2003AIPWRG4
ACTIVE
TSSOP
PW
16
2000
Green (RoHS
& no Sb/Br)

CU NIPDAU
Level-1-260C-UNLIM
-40 to 105
UN2003AI

ULN2003AJ
OBSOLETE
CDIP
J
16
TBD
Call TI
Call TI
-55 to 125

ULN2003AN
ACTIVE
PDIP
N
16
25
Pb-Free
(RoHS)

CU NIPDAU | CU SN
N / A for Pkg Type
-20 to 70
ULN2003AN

ULN2003ANE3
PREVIEW
PDIP
N
16
TBD
Call TI
Call TI
-20 to 70
ULN2003AN

ULN2003ANE4
ACTIVE
PDIP
N
16
25
Pb-Free
(RoHS)

CU NIPDAU
N / A for Pkg Type
-20 to 70
ULN2003AN

ULN2003ANSR
ACTIVE
SO
NS
16
2000
Green (RoHS
& no Sb/Br)

CU NIPDAU
Level-1-260C-UNLIM
-20 to 70
ULN2003A

ULN2003ANSRE4
ACTIVE
SO
NS
16
2000
Green (RoHS
& no Sb/Br)

CU NIPDAU
Level-1-260C-UNLIM
-20 to 70
ULN2003A

ULN2003ANSRG4
ACTIVE
SO
NS
16
2000
Green (RoHS
& no Sb/Br)

CU NIPDAU
Level-1-260C-UNLIM
-20 to 70
ULN2003A

ULN2003APW
ACTIVE
TSSOP
PW
16
90
Green (RoHS
& no Sb/Br)

CU NIPDAU
Level-1-260C-UNLIM
-20 to 70
UN2003A

ULN2003APWG4
ACTIVE
TSSOP
PW
16
90
Green (RoHS
& no Sb/Br)

CU NIPDAU
Level-1-260C-UNLIM
-20 to 70
UN2003A

ULN2003APWR
ACTIVE
TSSOP
PW
16
2000
Green (RoHS
& no Sb/Br)

CU NIPDAU | CU SN
Level-1-260C-UNLIM
-20 to 70
UN2003A

ULN2003APWRG4
ACTIVE
TSSOP
PW
16
2000
Green (RoHS
& no Sb/Br)

CU NIPDAU
Level-1-260C-UNLIM
-20 to 70
UN2003A


---

## Page 22

**PACKAGE OPTION ADDENDUM**

www.ti.com
5-May-2015

Addendum-Page 3

**Orderable Device**
**Status**

(1)

**Package Type Package**
**Drawing**

**Pins Package**
**Qty**

**Eco Plan**

(2)

**Lead/Ball Finish**

(6)

**MSL Peak Temp**

(3)

**Op Temp (°C)**
**Device Marking**

(4/5)

**Samples**

ULN2004AD
ACTIVE
SOIC
D
16
40
Green (RoHS
& no Sb/Br)

CU NIPDAU
Level-1-260C-UNLIM
-20 to 70
ULN2004A

ULN2004ADE4
ACTIVE
SOIC
D
16
40
Green (RoHS
& no Sb/Br)

CU NIPDAU
Level-1-260C-UNLIM
-20 to 70
ULN2004A

ULN2004ADG4
ACTIVE
SOIC
D
16
40
Green (RoHS
& no Sb/Br)

CU NIPDAU
Level-1-260C-UNLIM
-20 to 70
ULN2004A

ULN2004ADR
ACTIVE
SOIC
D
16
2500
Green (RoHS
& no Sb/Br)

CU NIPDAU | CU SN
Level-1-260C-UNLIM
-20 to 70
ULN2004A

ULN2004ADRE4
ACTIVE
SOIC
D
16
2500
Green (RoHS
& no Sb/Br)

CU NIPDAU
Level-1-260C-UNLIM
-20 to 70
ULN2004A

ULN2004ADRG4
ACTIVE
SOIC
D
16
2500
Green (RoHS
& no Sb/Br)

CU NIPDAU
Level-1-260C-UNLIM
-20 to 70
ULN2004A

ULN2004AN
ACTIVE
PDIP
N
16
25
Pb-Free
(RoHS)

CU NIPDAU
N / A for Pkg Type
-20 to 70
ULN2004AN

ULN2004ANE4
ACTIVE
PDIP
N
16
25
Pb-Free
(RoHS)

CU NIPDAU
N / A for Pkg Type
-20 to 70
ULN2004AN

ULN2004ANSR
ACTIVE
SO
NS
16
2000
Green (RoHS
& no Sb/Br)

CU NIPDAU
Level-1-260C-UNLIM
-20 to 70
ULN2004A

ULQ2003AD
ACTIVE
SOIC
D
16
40
Green (RoHS
& no Sb/Br)

CU NIPDAU
Level-1-260C-UNLIM
-40 to 85
ULQ2003A

ULQ2003ADG4
ACTIVE
SOIC
D
16
40
Green (RoHS
& no Sb/Br)

CU NIPDAU
Level-1-260C-UNLIM
ULQ2003A

ULQ2003ADR
ACTIVE
SOIC
D
16
2500
Green (RoHS
& no Sb/Br)

CU NIPDAU
Level-1-260C-UNLIM
-40 to 85
ULQ2003A

ULQ2003ADRG4
ACTIVE
SOIC
D
16
2500
Green (RoHS
& no Sb/Br)

CU NIPDAU
Level-1-260C-UNLIM
ULQ2003A

ULQ2003AN
ACTIVE
PDIP
N
16
25
Pb-Free
(RoHS)

CU NIPDAU
N / A for Pkg Type
-40 to 85
ULQ2003A

ULQ2004AD
ACTIVE
SOIC
D
16
40
Green (RoHS
& no Sb/Br)

CU NIPDAU
Level-1-260C-UNLIM
-40 to 85
ULQ2004A

ULQ2004ADG4
ACTIVE
SOIC
D
16
40
Green (RoHS
& no Sb/Br)

CU NIPDAU
Level-1-260C-UNLIM
ULQ2004A

ULQ2004ADR
ACTIVE
SOIC
D
16
2500
Green (RoHS
& no Sb/Br)

CU NIPDAU
Level-1-260C-UNLIM
-40 to 85
ULQ2004A

ULQ2004ADRG4
ACTIVE
SOIC
D
16
2500
Green (RoHS
& no Sb/Br)

CU NIPDAU
Level-1-260C-UNLIM
ULQ2004A


---

## Page 23

**PACKAGE OPTION ADDENDUM**

www.ti.com
5-May-2015

Addendum-Page 4

**Orderable Device**
**Status**

(1)

**Package Type Package**
**Drawing**

**Pins Package**
**Qty**

**Eco Plan**

(2)

**Lead/Ball Finish**

(6)

**MSL Peak Temp**

(3)

**Op Temp (°C)**
**Device Marking**

(4/5)

**Samples**

ULQ2004AN
ACTIVE
PDIP
N
16
25
Pb-Free
(RoHS)

CU NIPDAU
N / A for Pkg Type
-40 to 85
ULQ2004AN


**(1)** The marketing status values are defined as follows:
**ACTIVE:** Product device recommended for new designs.
**LIFEBUY:** TI has announced that the device will be discontinued, and a lifetime-buy period is in effect.
**NRND:** Not recommended for new designs. Device is in production to support existing customers, but TI does not recommend using this part in a new design.
**PREVIEW:** Device has been announced but is not in production. Samples may or may not be available.
**OBSOLETE:** TI has discontinued the production of the device.


**(2)** Eco Plan - The planned eco-friendly classification: Pb-Free (RoHS), Pb-Free (RoHS Exempt), or Green (RoHS & no Sb/Br) - please check http://www.ti.com/productcontent for the latest availability
information and additional product content details.
**TBD: ** The Pb-Free/Green conversion plan has not been defined.
**Pb-Free (RoHS):** TI's terms "Lead-Free" or "Pb-Free" mean semiconductor products that are compatible with the current RoHS requirements for all 6 substances, including the requirement that
lead not exceed 0.1% by weight in homogeneous materials. Where designed to be soldered at high temperatures, TI Pb-Free products are suitable for use in specified lead-free processes.
**Pb-Free (RoHS Exempt):** This component has a RoHS exemption for either 1) lead-based flip-chip solder bumps used between the die and package, or 2) lead-based  die adhesive used between
the die and leadframe. The component is otherwise considered Pb-Free (RoHS compatible) as defined above.
**Green (RoHS & no Sb/Br):** TI defines "Green" to mean Pb-Free (RoHS compatible), and free of Bromine (Br)  and Antimony (Sb) based flame retardants (Br or Sb do not exceed 0.1% by weight
in homogeneous material)


**(3)** MSL, Peak Temp. - The Moisture Sensitivity Level rating according to the JEDEC industry standard classifications, and peak solder temperature.


**(4)** There may be additional marking, which relates to the logo, the lot trace code information, or the environmental category on the device.


**(5)** Multiple Device Markings will be inside parentheses. Only one Device Marking contained in parentheses and separated by a "~" will appear on a device. If a line is indented then it is a continuation
of the previous line and the two combined represent the entire Device Marking for that device.


**(6)** Lead/Ball Finish - Orderable Devices may have multiple material finish options. Finish options are separated by a vertical ruled line. Lead/Ball Finish values may wrap to two lines if the finish
value exceeds the maximum column width.

**Important Information and Disclaimer:**The information provided on this page represents TI's knowledge and belief as of the date that it is provided. TI bases its knowledge and belief on information
provided by third parties, and makes no representation or warranty as to the accuracy of such information. Efforts are underway to better integrate information from third parties. TI has taken and
continues to take reasonable steps to provide representative and accurate information but may not have conducted destructive testing or chemical analysis on incoming materials and chemicals.
TI and TI suppliers consider certain information to be proprietary, and thus CAS numbers and other limited information may not be available for release.

In no event shall TI's liability arising out of such information exceed the total purchase price of the TI part(s) at issue in this document sold by TI to Customer on an annual basis.

 **OTHER QUALIFIED VERSIONS OF ULQ2003A, ULQ2004A :**


---

## Page 24

**PACKAGE OPTION ADDENDUM**

www.ti.com
5-May-2015

Addendum-Page 5

• Automotive: ULQ2003A-Q1, ULQ2004A-Q1

 NOTE: Qualified Version Definitions:

• Automotive - Q100 devices qualified for high-reliability automotive applications targeting zero defects


---

## Page 25

**TAPE AND REEL INFORMATION**

*All dimensions are nominal

**Device**
**Package**
**Type**

**Package**
**Drawing**

**Pins**
**SPQ**
**Reel**
**Diameter**
**(mm)**

**Reel**
**Width**
**W1 (mm)**

**A0**
**(mm)**

**B0**
**(mm)**

**K0**
**(mm)**

**P1**
**(mm)**

**W**
**(mm)**

**Pin1**
**Quadrant**

ULN2003ADR
SOIC
D
16
2500
330.0
16.4
6.5
10.3
2.1
8.0
16.0
Q1

ULN2003ADR
SOIC
D
16
2500
330.0
16.8
6.5
10.3
2.1
8.0
16.0
Q1

ULN2003ADR
SOIC
D
16
2500
330.0
16.4
6.5
10.3
2.1
8.0
16.0
Q1

ULN2003ADRG3
SOIC
D
16
2500
330.0
16.8
6.5
10.3
2.1
8.0
16.0
Q1

ULN2003ADRG4
SOIC
D
16
2500
330.0
16.4
6.5
10.3
2.1
8.0
16.0
Q1

ULN2003AIDR
SOIC
D
16
2500
330.0
16.8
6.5
10.3
2.1
8.0
16.0
Q1

ULN2003AIDRG4
SOIC
D
16
2500
330.0
16.4
6.5
10.3
2.1
8.0
16.0
Q1

ULN2003AIPWR
TSSOP
PW
16
2000
330.0
12.4
6.9
5.6
1.6
8.0
12.0
Q1

ULN2003AIPWR
TSSOP
PW
16
2000
330.0
12.4
6.9
5.6
1.6
8.0
12.0
Q1

ULN2003AIPWRG4
TSSOP
PW
16
2000
330.0
12.4
6.9
5.6
1.6
8.0
12.0
Q1

ULN2003APWR
TSSOP
PW
16
2000
330.0
12.4
6.9
5.6
1.6
8.0
12.0
Q1

ULN2003APWR
TSSOP
PW
16
2000
330.0
12.4
6.9
5.6
1.6
8.0
12.0
Q1

ULN2003APWRG4
TSSOP
PW
16
2000
330.0
12.4
6.9
5.6
1.6
8.0
12.0
Q1

ULN2004ADR
SOIC
D
16
2500
330.0
16.8
6.5
10.3
2.1
8.0
16.0
Q1

ULN2004ADRG4
SOIC
D
16
2500
330.0
16.4
6.5
10.3
2.1
8.0
16.0
Q1

ULN2004ADRG4
SOIC
D
16
2500
330.0
16.4
6.5
10.3
2.1
8.0
16.0
Q1

ULQ2003ADR
SOIC
D
16
2500
330.0
16.4
6.5
10.3
2.1
8.0
16.0
Q1

ULQ2003ADRG4
SOIC
D
16
2500
330.0
16.4
6.5
10.3
2.1
8.0
16.0
Q1

**PACKAGE MATERIALS INFORMATION**

www.ti.com
17-Sep-2015

Pack Materials-Page 1


---

## Page 26

*All dimensions are nominal

**Device**
**Package Type**
**Package Drawing**
**Pins**
**SPQ**
**Length (mm)**
**Width (mm)**
**Height (mm)**

ULN2003ADR
SOIC
D
16
2500
367.0
367.0
38.0

ULN2003ADR
SOIC
D
16
2500
364.0
364.0
27.0

ULN2003ADR
SOIC
D
16
2500
333.2
345.9
28.6

ULN2003ADRG3
SOIC
D
16
2500
364.0
364.0
27.0

ULN2003ADRG4
SOIC
D
16
2500
333.2
345.9
28.6

ULN2003AIDR
SOIC
D
16
2500
364.0
364.0
27.0

ULN2003AIDRG4
SOIC
D
16
2500
333.2
345.9
28.6

ULN2003AIPWR
TSSOP
PW
16
2000
364.0
364.0
27.0

ULN2003AIPWR
TSSOP
PW
16
2000
367.0
367.0
35.0

ULN2003AIPWRG4
TSSOP
PW
16
2000
367.0
367.0
35.0

ULN2003APWR
TSSOP
PW
16
2000
367.0
367.0
35.0

ULN2003APWR
TSSOP
PW
16
2000
364.0
364.0
27.0

ULN2003APWRG4
TSSOP
PW
16
2000
367.0
367.0
35.0

ULN2004ADR
SOIC
D
16
2500
364.0
364.0
27.0

ULN2004ADRG4
SOIC
D
16
2500
367.0
367.0
38.0

ULN2004ADRG4
SOIC
D
16
2500
333.2
345.9
28.6

ULQ2003ADR
SOIC
D
16
2500
333.2
345.9
28.6

ULQ2003ADRG4
SOIC
D
16
2500
367.0
367.0
38.0

**PACKAGE MATERIALS INFORMATION**

www.ti.com
17-Sep-2015

Pack Materials-Page 2


---

## Page 27


---

## Page 28


---

## Page 29


---

## Page 30


---

## Page 31


---

## Page 32


---

## Page 33


---

## Page 34

**IMPORTANT NOTICE**

Texas Instruments Incorporated and its subsidiaries (TI) reserve the right to make corrections, enhancements, improvements and other
changes to its semiconductor products and services per JESD46, latest issue, and to discontinue any product or service per JESD48, latest
issue. Buyers should obtain the latest relevant information before placing orders and should verify that such information is current and
complete. All semiconductor products (also referred to herein as “components”) are sold subject to TI’s terms and conditions of sale
supplied at the time of order acknowledgment.

TI warrants performance of its components to the specifications applicable at the time of sale, in accordance with the warranty in TI’s terms
and conditions of sale of semiconductor products. Testing and other quality control techniques are used to the extent TI deems necessary
to support this warranty. Except where mandated by applicable law, testing of all parameters of each component is not necessarily
performed.

TI assumes no liability for applications assistance or the design of Buyers’ products. Buyers are responsible for their products and
applications using TI components. To minimize the risks associated with Buyers’ products and applications, Buyers should provide
adequate design and operating safeguards.

TI does not warrant or represent that any license, either express or implied, is granted under any patent right, copyright, mask work right, or
other intellectual property right relating to any combination, machine, or process in which TI components or services are used. Information
published by TI regarding third-party products or services does not constitute a license to use such products or services or a warranty or
endorsement thereof. Use of such information may require a license from a third party under the patents or other intellectual property of the
third party, or a license from TI under the patents or other intellectual property of TI.

Reproduction of significant portions of TI information in TI data books or data sheets is permissible only if reproduction is without alteration
and is accompanied by all associated warranties, conditions, limitations, and notices. TI is not responsible or liable for such altered
documentation. Information of third parties may be subject to additional restrictions.

Resale of TI components or services with statements different from or beyond the parameters stated by TI for that component or service
voids all express and any implied warranties for the associated TI component or service and is an unfair and deceptive business practice.
TI is not responsible or liable for any such statements.

Buyer acknowledges and agrees that it is solely responsible for compliance with all legal, regulatory and safety-related requirements
concerning its products, and any use of TI components in its applications, notwithstanding any applications-related information or support
that may be provided by TI. Buyer represents and agrees that it has all the necessary expertise to create and implement safeguards which
anticipate dangerous consequences of failures, monitor failures and their consequences, lessen the likelihood of failures that might cause
harm and take appropriate remedial actions. Buyer will fully indemnify TI and its representatives against any damages arising out of the use
of any TI components in safety-critical applications.

In some cases, TI components may be promoted specifically to facilitate safety-related applications. With such components, TI’s goal is to
help enable customers to design and create their own end-product solutions that meet applicable functional safety standards and
requirements. Nonetheless, such components are subject to these terms.

No TI components are authorized for use in FDA Class III (or similar life-critical medical equipment) unless authorized officers of the parties
have executed a special agreement specifically governing such use.

Only those TI components which TI has specifically designated as military grade or “enhanced plastic” are designed and intended for use in
military/aerospace applications or environments. Buyer acknowledges and agrees that any military or aerospace use of TI components
which have*** not*** been so designated is solely at the Buyer's risk, and that Buyer is solely responsible for compliance with all legal and
regulatory requirements in connection with such use.

TI has specifically designated certain components as meeting ISO/TS16949 requirements, mainly for automotive use. In any case of use of
non-designated products, TI will not be responsible for any failure to meet ISO/TS16949.

**Products**
**Applications**

Audio
www.ti.com/audio
Automotive and Transportation
www.ti.com/automotive

Amplifiers
amplifier.ti.com
Communications and Telecom
www.ti.com/communications

Data Converters
dataconverter.ti.com
Computers and Peripherals
www.ti.com/computers

DLP® Products
www.dlp.com
Consumer Electronics
www.ti.com/consumer-apps

DSP
dsp.ti.com
Energy and Lighting
www.ti.com/energy

Clocks and Timers
www.ti.com/clocks
Industrial
www.ti.com/industrial

Interface
interface.ti.com
Medical
www.ti.com/medical

Logic
logic.ti.com
Security
www.ti.com/security

Power Mgmt
power.ti.com
Space, Avionics and Defense
www.ti.com/space-avionics-defense

Microcontrollers
microcontroller.ti.com
Video and Imaging
www.ti.com/video

RFID
www.ti-rfid.com

OMAP Applications Processors
www.ti.com/omap
**TI E2E Community**
e2e.ti.com

Wireless Connectivity
www.ti.com/wirelessconnectivity

Mailing Address: Texas Instruments, Post Office Box 655303, Dallas, Texas 75265

Copyright © 2015, Texas Instruments Incorporated


---

