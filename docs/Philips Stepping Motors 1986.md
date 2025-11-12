# Philips Stepping Motors 1986
## Page 1

f%? 
"O 
"Q. 

::J 
co 

3 
g_ 
0 
ii! 
Ol 
::J a. 

~ * 
Stepping motors and 
a. 

CD 

Components and 
materials· 

Book C17 
1986 

~ 
associated electronics 
a 
::J 
(')" 
*en *

...... 
(!) 
()) 
en 


---

## Page 2

STEPPING MOTORS AND ASSOCIATED ELECTRONICS 

*page *

*Preface *
ii 

Stepping motors, General 
Survey of types . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 2 

Introduction ............................................ 3 
Principles . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 4 
Practical aspects .......................................... 10 
Typical motor calculation ................................... 19 
Terminology ............................................ 24 
Additional information to motor specifications ..................... 26 
4-phase unipolar motors .................................... 27 
2-phase bipolar motors ..................................... 30 
4-phase bipolar motors ..................................... 31 

Device specifications ........................................ 32 

Associated electronics 

Integrated circuit for 4-phase unipolar stepping motors ............... 135 
Electronic drive unit, 4-phase unipolar .......................... 139 
Electronic drive unit, 2-phase bipolar ........................... 143 
Electronic drive unit, 4-phase bipolar ........................... 147 

Index of catalogue numbers ................................... 151 


---

## Page 3

**PREFACE **

New materials and manufacturing methods have enabled us to introduce motors to our range that have 
considerably improved characteristics and are at the same time less expensive. Some replace types that 
are widely used by many customers and, for this reason, are identical in fit and function to those they 
replace but with advantages in characteristics and price. 

Notes 

All mechanical drawings are in accordance with the European (third angle) projection. 

Dimensions are given in mm. 

Forces are given in newtons (N); 1 N = 100 g = 3,53 ounce (oz). 

Torques are given in mil Ii-newton-metres (mNm); 1 mNm = 10 gem= 0, 139 ounce inch. 

Performance curves are derived from measurements made on typical motors. 

The sense of rotation, clockwise (cw) or counterclockwise (ccw), is as viewed from the spindle end of 
the motor. 

When ordering, please use the catalogue number. 


---

## Page 4

**DA ****TA ****HANDBOOK ****SYSTEM **

Our Data Handbook System comprises more than 60 books with specifications on electronic compo· 
nents, subassemblies and materials. It is made up of four series of handbooks: 

ELECTRON TUBES 
BLUE 

SEMICONDUCTORS 
RED 

INTEGRATED CIRCUITS 
PURPLE 

COMPONENTS AND MATERIALS 
GREEN 

The contents of each series are listed on pages iv to viii. 

The data handbooks contain all pertinent data available at the time of publication, and each is revised 
and reissued periodically. 

When ratings or specifications differ from those published in the preceding edition they are indicated 
with arrows in the page margin. Where application information is given it is advisory and does not 
form part of the product specification. 

Condensed data on the preferred products of Philips Electronic Components and Materials Division is 
given in our Preferred Type Range catalogue (issued annually). 

Information on current Data Handbooks and on how to obtain a subscription for future issues is 
available from any of the Organizations listed on the back cover. 
Product specialists are at your service and enquiries will be answered promptly. 

February 1984 
iii 


---

## Page 5

l ___ _ 

ELECTRON TUBES (BLUE SERIES) 

The blue series of data handbooks comprises: 

T1 
Tubes for r.f. heating' 

T2a 
Transmitting tubes for communications, glass types 

T2b 
Transmitting tubes for communications, ceramic types 

T3 
Klystrons 

T4 
Magnetrons for microwave heating 

T5 
Cathode-ray tubes 
Instrument tubes, monitor and display tubes, C.R. tubes for special applications 

TS 
Geiger-Muller tubes 

TS 
Colour display systems 
Colour TV picture tubes, colour data graphic display tube assemblies, deflection units 

T9 
Photo and electron multipliers 

T10 
Plumbic.on camera tubes and accessories 

T11 
Microwave semiconductors and components 

T12 
Vidicon and Newvicon camera tubes 

T13 
Image intensifiers and infrared detectors 

T15 
Dry reed switches 

T16 
Monochrome tubes and deflection units 
Black and white TV picture tubes, monochrome data graphic display tubes, deflection units 


---

## Page 6

**SEMICONDUCTORS (RED SERIES) **

The red series of data handbooks comprises: 

S1 
Diodes 
Small-signal silicon diodes, voltage regulator diodes (< 1,5 W), voltage reference diodes, 
tuner diodes, rectifier diodes 

S2a 
Power diodes 

S2b 
Thyristors and triacs 

S3 
Small-signal transistors 

S4a 
Low-frequency power transistors and hybrid modules 

S4b 
High-voltage and switching power transistors 

S5 
Field-effect transistors 

S6 
R.F. power transistors and modules 

S7 
Surface mounted semiconductors 

S8a 
Light-emitting diodes 

S8b 
Devices for optoelectronics 
Optocouplers, photosensitive diodes and transistors, infrared light-emitting diodes and 
infrared sensitive devices, laser and fibre-optic components 

S9 
Power MOS transistors 

S10 
Wideband transistors and wideband hybrid IC modules 

S11 
Microwave transistors 

S12 
Surface acoustic wave devices 

S13 
Semiconductor sensors 

(February 1986 
v 


---

## Page 7

vi 

INTEGRATED CIRCUITS (PURPLE SERIES) 

The purple series of data handbooks comprises: 

EXISTING SERIES 

IC1 
Bipolar ICs for radio and audio equipment 

IC2 
Bipolar ICs for video equipment 

IC3 
ICs for digital systems in radio, audio and video equipment 

IC4 
Digital integrated circuits 
CMOS HE40008 family 

IC5 
Digital integrated circuits -
ECL 

Superseded by: 

IC01N 

IC02Na and IC02Nb 

IC01 N, IC02Na and IC02Nb 

ICOBN 
ECL10000 (GX family), ECL 100000 (HX family). dedicated designs 

IC6 
Professional analogue integrated circuits 
IC03N and Supplement to IC11 N 

IC7 
Signetics bipolar memories 

IC8 
Signetics analogue circuits 
IC11N 

IC9 
Signetics TTL logic 
IC09N and IC15N 

IC10 
Signetics Integrated Fuse Logic (IFL) 
IC13N 

IC11 
Microprocessors, microcomputers and peripheral circuitry 
IC14N 

Moreh 19861 


---

## Page 8

NEW SERIES 

IC01N 

IC02Na 

IC02Nb 

IC03N 

IC04N 

IC05N 

IC06N* 

IC07N 

IC08N 

IC09N 

IC10N 

Radio, audio and associated systems 
Bipolar, MOS 

Video and associated systems 
Bipolar, MOS 
Types MAB8031AH to TDA1524A 

Video and associated systems 
Bipolar, MOS 
Types TDA2501 to TEA 1002 

Integrated circuits for telephony 

HE4000B logic family 
CMOS 

HE4000B logic family - incased ICs 
CMOS 

High-speed CMOS; PC74HC/HCT/HCU 
Logic family 

High-speed CMOS; PC54/74HC/HCT/HCU - uncased ICs 
Logic family 

ECL 10K and 100K logic families 

TTL logic series 

Memories 
MOS, TTL, ECL 

IC11N 
Linear LSI 

Supplement 
Linear LSI 
to IC11N 

IC12N 

IC13N 

IC14N 

IC15N 

Note 

Semi-custom gate arrays & cell libraries 

ISL, ECL, CMOS 

Semi-custom 
Integrated Fuse Logic 

Microprocessors, microcontrollers & peripherals 
Bipolar, MOS 

FAST TTL logic series 

Books available in the new series are shown with their date of publication. 

(published 1985) 

(published 1985) 

(published 1985) 

(published 1985) 

(published 1984) 

(published 1986) 

(published 1984) 

(published 1986) 

(published 1985) 

(published 1986) 

(published 1985) 

(published 1985) 

(published 1984) 

* Supersedes the IC06N 1985 edition and the Supplement to IC06N issued Autumn 1985. 

~~~~~~~~~~~~

(Apc;11986 
vii 


---

## Page 9

COMPONENTS AND MATERIALS (GREEN SERIES) 

The green series of data handbooks comprises: 

C1 
Programmable controller modules 
PLC modules, PC20 modules 

C2 
Television tuners, coaxial aerial input assemblies, surface acoustic wave filters 

C3 
Loudspeakers 

C4 
Ferroxcube potcores, square cores and cross cores 

C5 
Ferroxcube for power, audio/video and accelerators 

C6 
Synchronous motors and gearboxes 

C7 
Variable capacitors 

CB 
Variable mains transformers 

C9 
Piezoelectric quartz devices 

C10 
Connectors 

C11 
Non-linear resistors 

C12 
Potentiometers, encoders and switches 

C13 
Fixed resistors 

C14 
Electrolytic and solid capacitors 

C15 
Ceramic capacitors 

C16 
Permanent magnet materials 

C17 
Stepping motors and associated electronics 

C18 
Direct current motors 

C19 
Piezoelectric ceramics 

C20 
Wire-wound components for TVs and monitors 

C21 * Assemblies for industrial use 

HNI L FZ/30 series, NORbits 60-, 61-, 90-series, input devices 

C22 
Film capacitors 

*To be issued shortly 

viii 
October 1985 


---

## Page 10

STEPPING MOTORS 


---

## Page 11

GENERAL 

SURVEY OF TYPES 

series 
step angle 
holding torque 
catalogue number 
degrees 
mNm 
page 

PERMANENT MAGNET STEPPING MOTORS 

4-phase unipolar motors 

ID06 
7,5° 
70 
9904 112 06001 
33 
7,5° 
70 
06101 
33 
1027 
7,5° 
140 
27001 
37 
7,5° 
150 
27101 
37 
1028 
15° 
80 
28001 
45 
150 
85 
28101 
45 
ID31 
7,5° 
30 
31001 
59 
7,5° 
34 
31101 
59 
ID31E 
7,5° 
28 
31004 
63 
7,5° 
32 
31104 
63 
ID31E 
7,5° 
42 
31006 
67 
7,5° 
46 
31106 
67 
1032 
7,5° 
10 
32001 
75 
7,5° 
10 
32101 
75 
ID33E 
7,5° 
130 
33004 
83 
7,5° 
130 
33104 
83 
1033 
7,5° 
150 
33105 
87 
ID34E 
15° 
75 
34004 
91 
15° 
80 
34104 
91 
ID35E 
7,5° 
85 
35014 
95 
7,5° 
85 
35114 
95 
7,5° 
85 
35016 
99 
7,5° 
95 
35116 
99 
ID36E 
15° 
60 
36014 
111 
15° 
60 
36114 
111 

2-phase bipolar motors 

ID27B 
7,5° 
170 
9904 112 27201 
41 
ID28B 
150 
110 
28201 
49 
ID31BE 
7,5° 
55 
31206 
71 
ID32BE 
7,5° 
11,5 
32204 
79 
ID35BE 
7,5° 
90 
35214 
103 
7,5° 
125 
35216 
107 

4-phase bipolar motors 

ID29B 

I 

3,75° 
300 
9904 112 29201 
52 
ID30B 
7,5° 
210 
30201 
55 

HYBRID STEPPING MOTORS 
HR15 
1,8° 
55 
990411515101 J 

115 
1,8° 
60 
15201 
119 
1,8° 
60 
15401 
123 
HR23 
1,8° 
450 
23 ... 
127 

2 
Ap<H 19861 


---

## Page 12

**GENERAL **

**INTRODUCTION **

A stepping motor converts digital information into proportional mechanical movement; it is an electro-
mechanical device whose spindle rotates in discrete steps, following command pulses in number and 
speed, when operated from a source that provires programmed current reversals. 

After the appearance of the stepping motor in applications traditionally employing digital control, the 
advantages of precise and rapid positioning of objects using electronics became more obvious and this, 
in turn, led to a greater variety of applications. These now include: 

-
paper and magnetic tape drives; 
-
teletype and strip printers; 
-
camera iris control, film transport and colour film sorting; 
-
co-ordinate plotters, incremental chart recorders and variable speed chart drives; 
-
medical equipment, e.g. blood samplers, lung analysers and kidney pumps; 
-
fuel flow control, valve control and variable speed syringe pumps; 
-
taxi-meters, card readers, production line pulse counters, and automatic weighing and labelling 
systems; 
-
digital-to-analogue converters and remote position indicating equipment. 

All have one thing in common - controlled motion. Wherever controlled movement and/or positioning 
is necessary, the stepping motor can be applied. And usually to advantage. 

From a mechanical viewpoint, the stepping motor has simple positional control, reliability and 
p_recision - it has, however, introduced the need for electronics. Where previously, simple, mechanically 
operated switches often provided adequate control, the need for a better method has arisen. The 
advantages of stepping motor systems have been gained at some expense to the simplicity of the motor 
control: although still unsophisticated by modern standards, some electronic circuits are necessary. 

The full benefit of a stepping motor can only be realized if it is correctly driven. It requires a d.c. 
supply, an electronic switch and a source of control pulses (digital information). The appropriate d.c. 
supply is routed to the motor via the electronic switch. In effect, the motor moves through one step 
for each control pulse applied to the electronic switch. The angle of the step depends upon the type 
of motor and can be from as little as 1,80 to as much as 150. Consequently, if 24 pulses are fed to the 
switch, the shaft of a motor with a 15° step-angle will complete one revolution. The time taken for 
this action is entirely a function of the rate at which control pulses are applied. These may be generated 
by an oscillator with adjustable frequency, or derived from one of a variety of sources: perforated tape, 
magnetic tape, etc. 

(January 1981 
3 


---

## Page 13

**GENERAL **l 

The range of stepping motors compri5es': 
- permanent magnet versions 
- hybrid versions 

**PRINCIPLES **

PERMANENT MAGNET STEPPING MOTORS, 

The step angle of a permanent magnet stepping motor depends upon th·e relationship between the 
number of magnetic poles on its stator assembly and the number of magnetic poles on its rotor. Since · 
the latter is a cylindrical permanent magnet, the poles are fixed,, arid their number is limited, due to 
the characteristics of the magnetic material. Enlarging the magnet diameter to provide for a larger 
number of rotor poles results in a drastic increase in the rotor inertia.,This reduces the starting 
capabilities of such a motor beyond practical use. With a permanent magnet rotor, only relatively large 
step angles can be obtained. However, further reduction of the step angle can be achieved 'by using 

more stators. This enables step angles down to 3,750 to be obtained, 
The stator assembly comprises two or more stators, each having a coll through which turrerit is passed 
to form a magnetic field. By reversing the direction of current flowing in a coil, therefore, the north and 
south poles can be transposed. Reversittg the current-flow through successive stator coils creates a 
rotating magnetic field which the permarient-magnet rotor follows. Speed of rotat.ion is thus 
governed by the rate at which the stator coils (and hence the electro-magnetic poles) are switched and 
the direction of rotation by the ,actual switching sequence. , 

There are two methods by which the current-flow· through stator coils can be reversed and this has led 
to two classes of stepping motor: those designed for unipolar drive·and those for bipolar drive. 
For ease of description, illustrations in this section which give a diagramatic representation of a perma-
nent magnet stepping motor show only a 2-pole rotor although it could have as many as 24: the 
operating principles, however, are the same. · 

Motors for Unipolar drive, 

Each stator coil of a moi:or designed for unipolar drive is provided with a centre-tap which is connected 
to one side of the supply, say, the po5itive. The direction of current flowing through a coil is then deter-
mined by the end to which the negative supply line is connected via a switching dev,ice. Switching coil-. 
halves results in the magnetic poles of,the relevant stator being reversed. 

*2-STA TOR MOTORS (4-PHASE} *
Fig. 1a shows a 4-phase stepping motor in which phases P,and Rare energized: the rotor assumes the 
position indicated. If switch S1 is now operated (phases Q and R energized), the conditions illustrated 
in Fig. 1 b obtain, i.e. the rotor has moved through 90 degrees. From this it can be seen that by operating 
switches S1 and S2 alternately, the rotor can be made to rotate in goo steps. The direction of rotation 
can be reversed by altering the switching sequence. 

Motors for Bipolar drive 

The stator coils of a motor designed for bipolar. drive have no centre-tap. Instead of using alternate 
coil-halves to produce a reversal of current-flow ,through the stator windings (as for unipolar drive), the 
current is now reversed through the, entire coil by switching both supply lines. Operation of a motor 
with bipolar drive is identical to that of one with unipolar drive,. 

*2-STA TOR MOTORS (2-PHASE} *

Operation of a 2-phase motor with bipolar dr'ive is shown Jn Fig~ 2. · 

*4-STA TOR MOTORS (4-PHASE} *
The 4-phase motor with bipolar drive is shown in Fig. 3. 

• 
.. .. ~b~ 1983 I 


---

## Page 14

**GENERAL **

**UNIPOLAR OPERATION **

~statocPQ 
s1Tla)Y ~~ 
,e 

s 
4 
s 

N 2~ 
IJ] 

N 
4 
S 

Fig. la. 
Fig. lb. 
Two stator motors (4-phase). 

**BIPOLAR OPERATION **

Fig. 2a. 
Fig. 2b. 
Two stator motors (2-phase). 

September 1983 
5 


---

## Page 15

**GENERAL **l __ _ 

Fig. 3a. 
Fig. 3b. 

Fig. 3 Four stator motors (4-phase). 


---

## Page 16

**GENERAL **

**Features ****of ****the bipolar drive **

The advantages of using motors with bipolar drive are shown in Fig. 4. This compares the performance 
of one of the unipolar motors with its bipolar version. A considerable increase in available torque is 
apparent using the bipolar version: the associated electronics, however, are necessarily somewhat more 
complex. 

Fig. 4. 

100 

**torque **
(mNmJ 

1--s 

75 

50 

25 

0 10 

6,25 

A 

A: unipolar motor; 
B: bipolar motor. 

-
+-

30 
18,75 

----
**1' **
........ 

]SJ 
~ 
~ 

~pull- in 
' 

-......... 

100 
62,5 

~ 

300 
187,5 

[\ 

***1\ ***

},_ 

***K ***

" 

**1\ **
1000 

625 

\ 

pull-out 
' ' T\ 

~ .. 

3000 
1875 

r; 

' 

**l\. **

~ 
**K **
10000 

6250 

'\ 

30000 steps/s 
18750 rev/min 

September 1983 
**7 **


---

## Page 17

**8 **

**GENERAL **

**HYBRID ****STEPPING MOTORS **

Our hybrid stepping motor technology is based upon a principle which gives options in step angle and 
motor size beyond those possible with the common design of hybrid stepping motors. This new design 
consists of four stator cups assembled face to face around a ring coil thus, forming two closed stator 
parts joined by a permanent magnet. The inner circumference of each stator cup has teeth, the number 
of teeth depending on the step angle required. The rotor consists of four discs, with the same number 
of teeth as the stator cups. The rotor discs are offset from each other by half a tooth-pitch in a pattern 
dictated by the necessary energizing sequence of the ring coils. The teeth of the stator cups are in line. 
The permanent magnet flux is distributed through each stator part and closed via the rotor. When the 
stator coils are energized alternately and in both directions a rotating magnetic field is produced which 
the rotor follows. At each step in the energizing sequence, the teeth of one rotor disc line-up with the 
teeth of the stator cups. 

Fig. 5 shows the basic design of this 4-phase motor. For simplicity, one tooth per rotor disc and 
stator cup is shown giving a step angle of 90 degrees. 
Theoretically, any number of teeth per disc/cup can be chosen which gives freedom of choice in step 
angle not possible with the common hybrid stepping motor designs. 

Possible step angles = 360 degrees, 
nxz 
where n = number of phases 
z = number of teeth/disc 

for n = 4, z = 50, step angle= 360/4 x 50 = 1,8° 
(200 steps/rev) 
n = 4, z = 48, step angle= 360/4 x 48 = 1,8750 ( 192 steps/rev) 
n = 4, z = 24, step angle= 360/4 x 24 = 3,750 
( 96 steps/rev) 

Fig. 6 shows the position of the four rotor discs in a motor with a step angle of 22,50. 

**ring ****coil **

**part ****1 **
7ZS3 **724 **

Fig. 5 
Ring-coil hybrid stepping motor, showing the paths of the permanent-magnet flux <Ppm and 
coil flux <Pc for one coil excitation mode. For this mode <Pc adds to c/lpm in disc **1 **and substracts from 
it in disc 2. 

M•reh 19861 


---

## Page 18

**GENERAL **

**stator cup **

**phase ****angle ****o****0 **
180° 
270° 

**7Z85375 **

Fig. 5b The positions of the four rotor discs of Fig. 5a. 

**stator cup **
**3 **
•••• 
**phase ****angle **
**o****0 **
**180° **
**90° **
**270° **

**7Z85374 **

Fig. 6 Positions of the rotor discs with respect to each other for a motor with four teeth on stator 
cups and rotor discs. 

*801016·25·01 *

Fig. 7 Industrial design of the Philips hybrid motor, showing a cut-away view of the industrial design 
with 50 teeth on stator and rotor. 

9 


---

## Page 19

--

**PRACTICAL ASPECTS OF STEPPING MOTORS **

Proper selection of the right stepping motor for a specific application calls for a thorough understanding 
of the characteristics of the motor and its drive circuitry. Figure 8 shows schematically the four con-
stituent parts of a stepping motor system together with the most important aspects of each. These will 
be briefly considered below. 

CONTROL 

LOGICS 

- Oscillator 
-
*Y:. *step/full step 
-
Ramping 

**THE **STEPPING MOTOR 
Step angle 

D.C. SUPPLY 

ELECTRONIC 

DRIVER 

- Unipolar 
- Bipolar 
- Chopper 

Fig. 8. 

-
Battery 
- Transformer: rectifier 

STEPPING 

MOTOR 

- Step angle 
-· Step angle accuracy 
- Torque 
-
Holding torque 
-
Detent torque 
-
Dynamic torque 

_,,. The standard step angles are: 

10 

0,90 - 400 steps per revolution 

1,80 - 200 steps per revolution 
3,6° - 100 steps per revolution 
3, 75o· -
96 steps per revolution 
7 ,5° -
48 steps per revolution 
15,0° -
24 steps per revolution 

Any incremental movement can be made that is a multiple of these step angles. For example, 6 steps 
of 7,5° would give a movement of 450_ 

Positional accuracy 

The no load (or constant) accuracy of each step is specified for each motor in the range. For example, 
motor 9904 112 35 ... has a step angle of 7,50 and will position within 20' (i.e., 5%) whether it moves 
1 step or 1000. The error is non-cumulative and averages to zero in 4 steps, i.e., 360 electrical degrees. 
Every four steps the rotor returns to the same position with respect to magnetic polarity and flux paths. 

For this reason, when very accurate positioning is required, it is advisable to divide the required movement 
into multiples of four steps. This is known as the 4-step mode. 

Mmh\9861 


---

## Page 20

---'----------J 

**GENERAL **

**Torque **

Three types of torque need to be considered in stepping motors: 

*Holding torque *

At standstill, when energized, a certain amount of torque is required to deflect a motor 1 step. This is 
known as the holding torque and is specified for each motor in the range. When a torque is applied that 
exceeds the holding torque the motor will rotate continuously. The holding torque is normally higher than 
the working torque and acts as a strong brake in holding a load in position. The higher it is the more 
accurately the load is retained in position. 

*Detent torque *
Due to their permanent magents, permanent magnet and hybrid stepping motors have a braking 
torque even when unenergized. This is the detent torque. 

*Working (dynamic) torque *

The dynamic characteristics of a stepping motor are described by the curves of torque versus stepping 
rate. Typical curves are shown in Fig. 9. 

40 

torque 
(mNm) 

30 

20 

10 

0 

10 
12,5 

--· 

::::-..;; -

30 
37,5 

,...t-. 
........... 
pull-in Kpull-out 
~ 

!'-... 

'!\. 

""" 

100 
125 

1\ 

~ 

300 
375 

!\ 

1000 
1250 

7Z82281 1 

3000 
steps/s 
3750 
rev/min 

Fig. 9 Torque versus stepping rate of motor 9904 112 31104. 

The *pull-in curve *shows the load a motor can start and stop without losing steps when operated at a 
constant stepping rate. 

The *pull-out curve *shows the torque available when the motor is gradually accelerated to and de-
celerated from its required working speed. The area between the two curves is known as the slew range. 

These characteristic curves are the key to the selection of the right motor and the control and drive 
circuits. Some hint.son defining the requirements and on the applicable calculations required are given 
in the following section. 


---

## Page 21

**GENERAL **

Overshoot 

When making a single step a rotor tends to overshoot and oscillate about its final position as shown in 
Fig. 10. This is normal behaviour for any pulsed dynamic system. The actual repsonse depends on the 
load and on the power input provided by the drive. The reponse can be modified by increasing the 
frictional load or by adding mechanical damping. However, mechanical dampers such as friction discs 
or fluid flywheels add to system cost and complexity. It is usually better to damp electronically. 

**full-step **

**angle **

0 
10 
20 30 40 
50 60 70 
BO 
t (ms) 

Fig. 10 Single-step response. 

**7295033 **

Two method are commonly used - the simplest being to delay the final pulse in an incremental train. 
Alternatively, every pulse, or just the final pulse in a train can be modified (as shown in Fig. **11) **into: 

A forward pulse at to 

A reverse pulse at t1 

A final forward pulse at t2 

**full-step **

**angle **

**time **
**7295034 **

Fig. 11 Electronically damped response. 

Step **function - multiple stepping **

There are often several alternatives when a given incremental movement must be made. For example, 
a rotation of 90° can be reached in 6 steps of a 150 motor, 12 steps of a 7,5o motor or in 50 steps of a 
1,ao motor. 

Generally, a movement executed in a large number of small steps will result in less overstioot, be stiffer 
and more accurate than one executed in larger steps. Also there is more opportunity to control the 
velocity by starting slowly, accelerating to full speed and then decelerating to a standstill with minimum 
oscillation about the final position. 

12 
J'""'"' 19841 


---

## Page 22

**GENERAL **

Resonance 

A stepping motor operated on no-load over its entire operating frequency range will disclose resonance 
points that are either audible or can be detected by vibration sensors. If any are objectionable, these 
frequencies should be avoided, a softer drive used, extra inertia or external damping added. 

DRIVE METHODS 
The normal drive method is the 4-step sequence mentioned in the section on positional accuracy. How-
ever, other methods can be used depending on the coil configuration and the logic pattern in which the 
coils are switched. 

Unipolar or bipolar? 

There are three types of motor in the range: 4-phase unipolar, 2-phase and 4-phase bipolar. 

*4-phase **unipolar *motors have two coils on one bobbin for each stator (bifilar winding). The two-stator 
stepping motors have, therefore, 4 coils. Because the coils occupy the same space as a single coil in 
equivalent bipolar types, the wire is thinner and coil resistance higher. 
Unipolar motors may require only a simple drive circuit - only four power transistors instead of eight. 
Moreover, the switching time, needed to prevent two switched-on transistors short-circuiting the supply, 
as with bipolar drives, is less critical. 

So unipolar motors with simplified drive have less torque at low stepping rates than their bipolar counter-
parts, although at higher stepping rates it is the same. 

*Bipolar *motors have but 1 coi I per bobbin so that 2-stator motors have 2 coi Is and 4-stator motors 
4 coils. Stator flux is reversed by reversing the currents through the winding. As shown in Fig. 12, a 
push-pull bipolar drive is needed. Care must be taken with switching times to ensure that two opposing 
transistors are not switched-on at the same time. Properly operated, bipolar windings give optimum 
motor performance at low to medium stepping rates. 

Wave drive 

Energizing one winding at a time, as shown in Fig. 12, is called wave excitation. It produces the same 
increment as the 4-step sequence. Since only one winding is energized, holding torque and working 
torque are reduced by 30%. This can, within limits, be compensated by increasing supply voltage. 
Advantage of this form of drive is higher efficiency, but at the cost of reduced step accuracy. 

Half-step mode 

It is also possible to step a motor in a half-step sequence, thus producing half steps, 3,750 steps from a 
7 ,5° motor, for example. A possible drawback for some applications is that the holding torque is strong 
and weak on alternate steps, because on one step two windings are energized and on the other only one. 
Also, because winding and flux paths differ on alternate steps, accuracy will be worse than when full-
stepping. The principle of the half-step is shown in Fig. 13 and the proper switching sequence in Fig. 12. 

January 1984 
13 


---

## Page 23

**GENERAL **

0203 

1 
ON 

2 
ON 

3 
ON 

4 
ON 

5 
OFF 

6 
OFF 

7 
OFF 

8 
OFF 

1 
ON 

1' 
2' 

*+V *
*+V *

Fig. 12b, 

BIPOLAR -- 2 PHASE 

14 
J'""'"' 19841 

0104 

OFF 

OFF 

OFF 

OFF 

ON 

ON 

ON 

ON 

OFF 

3' 
4' 

Fig. 12a. 

BIPOLAR - 4 PHASE 

0607 0508 010011 09012 014015 013016 
FULL STEP 

OFF 
ON 
OFF 
ON 
OFF --~--j 
-- ---
ON 
OFF 
OFF 
ON 
OFF 
ON 

ON 
OFF 
ON 
OFF 
OFF 
ON 

ON 
OFF 
ON 
OFF 
ON 
OFF 

ON 
OFF 
ON 
OFF 
ON 
OFF 

OFF ON 
ON 
OFF 
ON 
OFF---1 
• t 
cw 
ccw 
OFF 
ON 
OFF 
ON 
ON 
OFF 

OFF 
ON 
OFF 
ON 
OFF 
ON 

OFF 
ON 
OFF 
ON 
OFF 
ON 

0203 0104 0607 0508 
FULL STEP 

1 
ON 
OFF 
OFF 
ON 

2 
ON 
OFF 
ON 
OFF 

3 
OFF ON 
ON 
OFF 
i *1 *

4 
OFF 
ON 
OFF 
ON 
cw 
ccw 
1 
ON 
OFF 
OFF 
ON 

1 
ON 
OFF 
OFF 
ON 
HALF STEP 
2 
ON 
OFF 
OFF 
OFF 

3 
ON 
OFF 
ON 
OFF 

4 
OFF 
OFF 
ON 
OFF 

5 
OFF 
ON 
ON 
OFF 
6 
OFF 
ON 
OFF 
OFF 

7 
OFF 
ON 
OFF 
ON 

+ **t **
cw 
ccw 

8 
OFF OFF 
OFF 
ON 

**7295029 **
1 
ON 
OFF 
OFF 
ON 

1 
ON 
OFF 
OFF 
OFF 
WAVE DRIVE 
2 
OFF 
OFF 
ON 
OFF 

3 
OFF 
ON 
OFF OFF 
4 
OFF 
OFF 
OFF 
ON 
t 

1 
ON 
OFF 
OFF 
OFF 
CW 
CCW 


---

## Page 24

l GENERAL 

FULL STEP 

• **t **
cw 
ccw 

1 
ON 
OFF 
OFF 
ON 
HALF STEP 
2 
ON 
OFF 
OFF 
OFF 

3 
ON 
OFF 
ON 
OFF 

4 
OFF 
OFF 
ON 
OFF 

f~ 
OFF 
ON 
ON 
OFF 
**7295030 **
~ **t **
6 
OFF 
ON 
OFF 
OFF 

7 
OFF 
ON 
OFF 
ON 
Fig. 12c. 
cw 
ccw 

~ 
~- OFF jcJFF 
ON 

1 
ON 
OFF jo_FF ~ 
UNIPOLAR - 4 PHASE 

1 
ON 
OFF 
OFF 
OFF 
WAVE DRIVE 

2 
OFF 
OFF 
ON 
OFF 

3 
OFF 
ON 
OFF 
OFF 

4 
OFF 
OFF 
OFF 
ON 
+ **t **

1 
ON 
OFF 
OFF 
OFF 
cw 
ccw 

Fig. 13 Principle of half step mode. 

January 1984 
**15 **


---

## Page 25

**GENERAL **

**SUPPLY **

When a motor is operated at a fixed rated voltage its torque output decreases as step rate rises. This is 
because the increasing back EMF and the rise time of the coil current limits the power actually delivered 
to the motor. The effect is governed by the ratio of inductance to resistance (L/R) in the circuit. 

The effect can be compensated by either increasing the power supply voltage to maintain constant 
current as stepping rate increases, or by increasing supply voltage by a fixed amount and adding series 
resistors to the circuit. 

**L/R ****drive **
Series resistors are chosen to give required L/R ratio; resistors three times the winding resistance would 
give a ratio of L/4R. Their rating should be: 

watts= (current per winding) 2 x R 

Supply voltage would then be increased to four times the motor rated voltage to maintain rated current. 

If the increased power consumption is objectionable some other drive method such as a bi-level voltage 
supply or a chopper supply should be used, as shown in Fig. 14. 
Note: because of their higher winding resistance unipolar motors have a better L/R ratio than their 
bipolar equivalents. 

**7Z95031 **

Fig. 14 L/4R drive. 

16 
January 1984 


---

## Page 26

**GENERAL **

**Bi-level ****drive **

With a bi-level drive the motor is operated below rated voltage at zero steps/s (holding) and above rated 
voltage when stepping. It is most efficient for fixed stepping rates. The high voltage may be turned on 
by current sensing resistors or, as in the circuit of Fig. 15, by means of the inductively generated turn-
off current spikes. At zero steps/s the windings are energized from the low voltage. As the windings are 
switched in the 4-step sequence, suppression diodes Dl, D2, D3 and D4 turn on the high voltage supply 
transistors Sl and S2. 

**Vrow **

**7295!)26 **

Fig. 15 Unipolar bi-level drive. 

**Chopper ****drive **

A chopper drive maintains current at an average level by switching the supply on until an upper current 
level is reached and then switching it off until a lower level is reached. A chopper drive is best suited 
to fast acceleration and variable frequency applications. It is more efficient than an analogue constant 
current regulated supply. In the chopper circuit shown in Fig. 16, V+ would be typically 5 to 10 times 
the motor rated voltage. 

+V 

**7295025 **

Fig. 16 Unipolar chopper drive. 


---

## Page 27

I' 

**GENERAL **

**Spike ****suppression **

When windings are turned-off, high-voltage spikes are induced which could damage the drive circuit if 
not suppressed. They are usually suppressed by a diode across each winding. A disadvantage is that 
torque output is reduced unless the voltage across the transistors is allowed to build up to about twice 
the supply voltage. The higher this voltage the faster induced fields and currents collapse and performance 
is, therefore, better. For this reason a zener diode or series resistor is usually added as in Fig. 17. 

+V 

B2 

**7295027 **

Fig. 17 Voltage suppression circuit. 

**Performance ****limitations **

At standstill or low step rates, increasing the supply voltage produces proportionally higher torque until 
the motor magnetically saturates. Near saturation the motor becomes less efficient so that increased 
power is unjustifiable. 

The maximum speed of a stepping motor is limited by inductance and eddy current losses. At a certain 
step rate the heating effect of these losses limits any further attempt to get more speed or torque out 
a motor by driving it harder. 

**18 **
January 19841 


---

## Page 28

**GENERAL **

**TYPICAL STEPPING MOTOR CALCULATION **

PULL-IN CURVE to be used where load is purely frictional and no provision is made for acceleration. 

For example: A frictional load of 45 mNm must be moved 67,5° in 0,06 s or less. No provision is made 
for acceleration. 

Solution: 
67 ,5o is 9 steps for a motor with a step angle of 7 ,5°. 

A stepping rate of v = ~ 
= 150 steps/s or higher is needed. 

From Fig. 18 (the curves for motor type 9904 112 35214) the maximum pull-in rate at 
45 mNm is 180 steps/s. 

Clearly, motor type 9904 112 35214 can safely be used at 150 steps/s where a torque of 
over 50 mNm is available. 

PULL-OUT CURVE to be used in conjunction with the equation torque= inertia x acceleration (T = J01) 
when the load is inertial and/or acceleration control is provided. In the above equation 01 is in radians/s2. 

**torque **
(mNm) 

75"='~="~.~±-_+_-+~~+l~--H.-++~.~-+---t~r-+-+-++t+-~~t---+-+-+-+-+++-I 
---

""'b..pull-out 

I~ 

50t--~--+~+-+-+-+-H-t+--'-.---+---t~r-+-+-+»-++-~~+---+---+-+-++++-I 
..... , 

~ 
-~ 
f------i i>-+-H 
**pull-in **

j_~ 
~ 
J_ 
' 
~ 
**t **
\ 

I 
~ 
~ 
J_ 
l 
~ 

25t--~-+~+--t-+-+-H-++~--t-+-_,.~r-+-+-t+t+-~.....,_t---+-+-+-+-+++-I 

j_ 
l 
~ 
o~~~~~~~~~~~~~~~~.._._...._~~~~~~~~ 

10 
30 
100 
180 
300 
1000 
3000 
**steps/s **
12,5 
37,5 
125 
375 
1250 
3750 
**rev/min **

Fig. 18 Torque versus stepping rate of motor 9904 112 35214. 

January 1984 
19 


---

## Page 29

**GENERAL **

RAMPING 
A voltage controHed oscillator with associated charging capacitor is usually used for acceleration 
control (or ramping). Different RC constants will give different ramping times. Fig. 19 shows a typical 
curve of step rate against time for an incremental movement with equal acceleration and deceleration 
times. 

step.pin~·k:· 
. . . 1 

**max. ****stepping ****rate **' 

**rate **

**Atacc **
**Atrun **
**time **

**7Z95032 **

Fig. 19 Step rate versus time. 

Frequency division can ;itso be used for acceleration contr.ol. For example, starting at quarter rate then 
accelerating successively to half, three-quaters and, fina.lly, to full frequency rate. 

1. Applications where acceleration or deceleration time is allowed 

ilv 
TJ = JT x flt x K 

Where T J = Torque 
JT =rotor inertia plus load inertia (g.m 2) 

K = ste:Sirev (bringing steps/s to radians/s) 

K = 0,0314 for 1,ao step angle 

= 0,065 for 3,750 step angle 
= 0, 130 for 7 ,5o step angle 
= 0,261 for 150 
step angle 

Applications using acceleration ramping sometimes require a series of estimates before a final decision is 
made. Howeve,r, these take little time, as can be seen in the example below. 

For example: Frictional torque.plus inertial load with acceleration control. 

Ao assembly device. must move 4 mm in less than 0,5 s. The motor drives a lead screw 
through a.gear. Gear and lead screw having been so selected that the 4 mm movement 
is·inade in100 steps· of a 7,5o motor. The total inertial load (rotor+ gear+ lead screw) 
. is25 xJ0'4 g.m 2 • The frictional load TF is 4 mNm. 

v = 100 steps = 200 steps/s 

0,5 s 


---

## Page 30

**GENERAL **

So a stepping motor must be selected that delivers more than 4 mNm at a step rate higher than 
200 steps/s. Type 9904 112 32101 seems a possibility (see the curve of Fig. 20). 

**torque **
**fmNm} **
d--
7,751---- -~t- ~ 

~ 
..... 

**IX:: ****fSpull-out **

fT 
pull-i~ 

l 

0~~~~-1....--'--'-.L..4......_...._~__,l_._i_.__..._._.J.l..Ju..JLL-~~.L-.....l.--J......l....l..-l....J..LI 

10 
12,5 

30 
37,5 

100 
125 
225 300 

375 

1000 
1250 

3000 

3750 

Fig. 20 Torque versus stepping rate, motor 9904 112 32101. 

**steps/s **

**rev/min **

Make a first estimate of a working rate (lower than maximum running rate) and determine the torque 
available to accelerate the inertia (excess over TF)· From the Fig. 20, the motor delivers 7.75 mNm at 
210 steps/s. 

T1 - TF = 7,75 - 4 = 3,75 mNm 

Apply a safety factor of 60%. 

3,75 x 0,6 = 2,25 mNm 

Calculate acceleration time using the equation: 

2 25 = 25x 10-4 x 210x 0,13 

' 
At 

Acceleration (and deceleration) time is, therefore, 0,03 s 

Number of steps to accelerate and decelerate is: 

NA+ No =.':.Atx 2=vAt= 210x 0,03= 7 steps 
2 

January 1984 
**21 **


---

## Page 31

Time at the working rate is: 

At 
=NT - (NA+ No) = 100- 7 = 0 443 s 
run 
working rate 
210 
' 

Total time to move is: 

Atrun + Atacc + AtcJec = 0.433 + 0,03 + 0,03 = 0;503 s 

This time very slightly exceeds that allowed, but it is a first estimate and allows us to decide which way 
to go - whether to accept the slightly longer time or to recalculate at a slightly higher stepping rate, 
say 220 steps/s. Torque will be very slightly less, which means that acceleration takes fractionally longer, 
but total time will be less. 

2. Applications where no acceleration time is allowed 

Although no acceleration time is allowed the motor may lag up to 2 steps (180 electrical degrees). If the 
motor accelerates from zero steps/s to v steps/s, there will be a lag time, Av of~-s. 

The torque equation is, therefore: 

Where the symbols have the same significance as before. 

For example: Friction plus inertia with no acceleration ramping. 

A stepping motor is to be used to drive a digital tape capstan. The frictional drag is 6 mNm 
and the capstan inertia is 8 x 10-4 g.m 2• The capstan must rotate in increments of 7,5o at 

170 steps/s. 

Select a motor with a torque in excess of 6 mNm at 170 steps/s, say the 9904 112 32204 
motor. 

Total inertia = rotor inertia + load inertia 
Jr=JR +h 

22 
January 1984 

= 12,6 x 10-4 , + 18 x 10-~, g.in 2 

= 10,6 x 10-4 g.m 2 


---

## Page 32

___ 
J 
**GENERAL **

There is no acceleration ramping so: 

(K is0,13) 

1702 
TJ = 10,6x 10-4 x-2-
x 0,13= 2 mNm 

Total torque= TF + TJ = 6 + 2 = 8 mNm 

Referring to the pull-out curve in Fig. 21 we see that the 9904 112 32204 motor can deliver 9,2 mNm 
at 170 steps/s. Which means that a substanstial (15%) safety margin is also available. 

torque 
(mNm) 

~==t=- l-+-1-1 
t--
t-. 
N 
I---

f--·---+-+--+--'-+-+'1''-..++----·-+--+--+-+~-i:,,,J,_,,.+-l-1------1---+--t---+--'-l--l-W 

jo,, 
7,5t----+--+--+--+-+-+-++~f'\:---+--+-+-+-+-+-"""'1'"---+--+--+--+--"-+-+-+-< 

-----t--+--1--+-+tie++-~:s_--+--1---+-+-+-++++->~-+---+--+-+++++-l 

1------+-~'-'--'-•~+----:s_"--+---l--+-'-+--+--l--U-~~'"S:--l----l---+--+-'-l-l-W 

~--~ -+-+--+-+---t-+-+-+--pu_ll-_in_2'SJ~---+-+--1t-l-+-H++++--3;:~\H--l--+-r+~-+-< 

-- -+--I- l--H 

- --+-1-H 

---+-t-1-
---+\+· 

f =l ~ _.::f--+-++ 
---~=t f--+--+--+-H-'H 
- - H 
H 
------
I--+-- --1-H 

2.5 >----+---+---t-+-H-+-++-++-++-++++--------~=-~~-~:s::~"'\j:_=:-~::.~::_====::=:=~=:~~::~ 

-+--+-l-+-+-++1------4 -
~ 
---- t-- - --+--+-+-+-+++--+---t---+--!-4'.++-bl f-1------l--~ --+·-+-+-'--1--+-l 

10 

12.5 

30 

37,o 

100 

125 

300 

375 

1000 
1250 

3000 
3750 

steps/s 

rev/min 

Fig. 21 Torque versus stepping rate, motor 9904 112 32204. 

SUMMARY OF KEY TORQUE EVALUATIONS 
The speed-torque characteristic curves are the key to selecting the right motor and control drive method 
for a specific application. 

Define characteristics of load to be driven 

Use the pull-in curve if no acceleration control is to be used and if the load is purely frictional. 

Use the pull-out curve and 

i-f ramping control provided, use TJ = JT x ~ 
x K 

2 
if ramping control not provided, use T = JT x ~x K 

*( *J'"""' 1984 
2J 


---

## Page 33

**24 **

**GENERAL **l __ _ 

**TERMINOLOGY **
(in alphabetical order) 

Detent Torque: The maximum torque that can be applied to the spindle of an unexcited motor 
without causing continuous rotation. Unit: mNm. 

Deviation: The change in spindle position from the unloaded holding position when a certain torque 
is applied to the spindle of an excited motor. Unit: degrees. 

Holding Torque: The maximum steady torque that can be externally applied to the spindle of an 
excited motor without causing continuous rotation. Unit: mNm. 

Maximum Pull-In Rate (Speed): The maximum switching rate (speed) at which an unloaded motor 
can start without losing steps. Unit: steps/s (rev/min). 

Maximum Pull-Out Rate (Speed): The maximum switching rate (speed) which the unloaded motor 
can follow without losing steps. Unit: steps/s (rev/min). 

Maximum Working Torque: The maximum torque that can be obtained from the motor. Unit: mNm. 

Overshoot: The maximum amplitude of the oscillation around the final holding position of the rotor 
after cessation of the switching pulses. Unit: degrees. 

Permanent Overshoot: The number of steps the rotor moves after cessation of the switching pulses. 
Unit: steps. 

Phase: Each winding connected across supply voltage. 

Pull-In Rate (Speed): The maximum switching rate (speed) at which a frictionally loaded motor can 
start without losing steps. Unit: steps/s (rev/min). 

Pull-In Torque: The maximum torque that can be applied to a motor spindle when starting at the 
pull-in rate. Unit: mNm. 

Pull-Out Rate (Speed): The maximum switching rate (speed) which a frictionally loaded motor can 
follow without losing steps. Unit: steps/s (rev/min). 

Pull-Out Torque: The maximum torque that can be applied to a motor spindle when running at the 
pull-out rate. Unit: mNm. 

Start Range: The range of switching rates within which a motor can start without losing steps. 

Step Angle: The nominal angle that the motor spindle must turn through between adjacent step 
positions. Unit: degrees. 

Stepping Rate: The number of step positions passed by a fixed point on the rotor per second. Unit: steps/s. 

Slew Range: The range of switching rates within which a motor can run unidirectionally and follow the 
switching rate (within a certain maximum acceleration) without losing steps, but cannot start, stop or 
reverse. 

J'"""" 1981 I *( *
**PHILIPS **


---

## Page 34

**General **
J 
---

torque 

pull-out torque -

pull-in torque -
-
-
-

pull -in rate (speed) J 

STEPPING MOTOR CHARACTERISTICS 

curve A= pull-out torque 
curve B =pull-in torque 

l L 
pull-out rate (speed) 
max. pull- in rate (speed) 
**1Z66755.2 **

**GENERAL **

frequency 
(steps/second) 
L 
max. pull-out 

rate (speed) 

November 1983 
25 


---

## Page 35

GENERAL J 

**ADDITIONAL INFORMATION TO MOTOR SPECIFICATIONS **

The following pages contain full specifications for each motor type. Values given are typical, they apply 
at an ambient temperature of 15 oc to 35 oc, an atmospheric pressure of 860 to 1060 mbar and a 
relative humidity of 45 to 75%. 

The following points should be noted: 

Maximum motor temperatures 

Temperature increase in the motors depends upon their power consumption. Motors employing unipolar 
drive unit 9904 131 03006 or integrated circuit SAA 1027, operate from a low supply voltage and have a 
low power input which limits the increase in motor temperature. If motors with unipolar drive are oper· 
ated at low ambient temperatures, a higher supply voltage, giving correspondingly higher torque, is 
permissible. 

Motors employing bipolar constant current drive operate from a high (e.g. 40 V) supply voltage and 
have a higher input power which causes a greater increase in motor temperature. They should either be 
mounted on a surface that will act as a heatsink or have forced cooling. 

At ambient temperatures above 25 °c, the torque of motors, both for unipolar and bipolar drive, will 
decrease by approximately 0,2% per K, due to change in copper resistance and to the temperature 
coefficient of the magnet. There is also a derating at low ambient temperatures, more so for unipolar 
motors operating in the slew range: pull-in, however, is not affected. 

Instability of a stepping motor's performance can occur under certain circumstances. The mass moment 
of the rotor and its load, together with the magnetic stiffness, forms a spring system which causes: 

-
a resonance at low stepping rates; 
--
-
hunting around the required speed at high stepping rates. 

These unstable areas are indicated by broken lines on the performance curves appearing in this section. 

Resonance can be minimized by applying the correct amount of friction to the motor drive-spindle. 

Hunting can be minimized by attaching a "Lancaster damper" to the motor spindle. A Lancaster 
damper basically consists of a disc that is frictionally attached over the motor spindle. Ordinarily the 
disc rigidly follows the rotational speed of the spindle but when hunting occurs, it moves through a 
small angle in relation to the spindle and absorbs the fluctuation in speed. The mass moment of the 
disc and the required friction depend entirely upon the application and must be individually determined 
in each case. 

26 
A"'"" 1984 I 


---

## Page 36

GENERAL 

4-PHASE UNIPOLAR STEPPING MOTORS 

permanent magnet type 

DESCRIPTION 

The motors have a 4-phase stator and a permanent magnet rotor with 24 poles (step angle of 7° 30') or 
12 poles (step angle of 150). The motor coils are adapted for optimum matching to the 4-phase unipolar 
integrated circuit SAA 1027 or to the 4-phase electronic driver module 9904 131 03006 (see relevant 
data sheets). 

CONNECTION DIAGRAMS 

• Motors with 6 leads or connecting tags and integrated circuit SAA1027. 

I system 

100!1 
Rs 
MOTOR COILS 

O,lµF 
,------3·~· 
H 
+ Vcc1 
Rx 

c 
14 
4 
13 
-
15 
11 

R 
SAA1027 
M 
Mal 
'1 
I 

12 
_______ J 

VEE1 
VEE2 

7283605.2 

Fig. 1 Resistor value Rs can be found in Table 1. C =count input (previously T); R =reset (previously 
S); M =mode input to select c.w. or c.c.w. (previously R). 

Table 1 

motor 
Rs 
I system 
--!-------------
9904 112 06001 
180 n 
0,67W 
200mA 
27001 
15on 
1,15 w 
600mA 
28001 
150Q 
1,15 w 
600 mA 
31001 
180 n 
0,67W 
400mA 
31004 
18on 
0,67W 
400mA 
31006 
180 n 
0,67W 
400mA 
32001 
270Q 
0,33W 
300mA 
33004 
150Q 
0,67 w 
600mA 
34004 
150Q 
0,67W 
600mA 
35014 
18on 
0,67W 
600mA 
35016 
180 n 
0,67W 
600mA 
36014 
180 n 
0,67W 
600mA 

*( *
Moreh 1986 
27 


---

## Page 37

GENERAL l ___ _ 

-

28 

• Motors with 8 leads and integrated circuit SAA 1027 

c 

R 

M 

I system -

10on 
0,1µF 
~ 
+ Vcc1 

14 
15 

SAA1027 

VEE1 

Rs 

Rx 
Vcc2 

13 
Ma4 
11 
Ma3 

8 Ma2 

6 Ma1 

12 

VEE2 

MOTOR COILS. 
;;---,;:i 

3' 

'2 
2' 

1' 

I 
' 
L---...J 

7273240.2 

Fig. 2 Resistor value RB can be found in Table 1. 

• Motors with 6 leads or connecting tags and electronic drive unit 9904 131 03006 

+5V 

2 c 
+ 
MOTOR COILS 

DRIVE 
5 
UNIT 

,------ ;;:i 

I 

4 

7Z85944.1 

Fig. 3 Resistor value Rv and capacitor value Cv can be found in Table 2. 

Table 2 

motor 
Rv 
Cv 

9904112 31104 
8,2.Q 
220 µF 
31106 
8,2il· 
220µF 
32101 
15 n 
100 µF 
33104 
5 n 
not applicable 
34104 
5 n 
not applicable 
35114 
6 n 
not applicable 
35116 
6 n 
not applicable 
36114 
6 n 
not applicable 
990411515101 
0 n 
not applicable 

"'"" 1986 I 


---

## Page 38

4-phase unipolar stepping motors 

• Motors with 8 leads and electronic drive unit 9904 131 03006 

DRIVE 

UNIT 

1 

2 c 

+5V 

MOTOR COILS 
,-----4' 

7285946.1 

Fig. 4 Resistor value Rv and capacitor value Cv can be found in Table 3. 

Table 3 

motor 
Rv 
Cv 

9904 112 06101 
15.Q 
50 µF 
27101 
10 n 
50µF 
28101 
1on 
50µF 
31101 
18 n 
33µF 

GENERAL 

-

29 


---

## Page 39

**GENERAL **l __ _ 

**2-PHASE BIPOLAR STEPPING MOTORS **

permanent magnet type 

DESCRIPTION 

The motors have a 2-phase stator and a permanent magnet rotor with 24 poles (step angle of 70 30') or 
12 poles (step angle of 150). The design is similar to the unipolar motors. The stator flux from a bipolar 
winding is reversed by reversing the current through the winding. With a constant current drive the 
bipolar motors can be used at high stepping rates. For continuous operation at high stepping rates, the 
temperature rise of the motor due to iron losses should be taken into account for calculating the 
maximum ambient temperature. 

The temperature rise of the windings in bipolar motors is lower than in unipolar motors due to lower 
current and more windings. 

CONNECTION DIAGRAM 

• Motors and electronic drive unit 9904131 03007 

+5V 

2 c 

3 M 

4 OV 

5 
ov 
DRIVE 

UNIT 
6 +VMM 

MOTOR COILS 

7 Ma1 

S Mbl 
1' 

9 Ma2 

Mb2 
10 

**1****2' **
I 
___ J 

**7Z85945 ****.1 **

Fig. 1. 


---

## Page 40

___ 
j 
**GENERAL **

**4-PHASE BIPOLAR STEPPING MOTORS **

**permanent magnet type **

**DESCRIPTION **

These motors have a 4-phase stator and a permanent magnet rotor with 24 poles (stepping angle 30 45') 
or 12 poles (stepping angle 70 30'). 
The stator flux is obtained by energizing all 4 phases. The current through one of the coils is reversed, 
thus reversing the flux due to it. 
With a constant current drive these motors can be slewed at very high stepping rates. However, it should 
be noted that the motors are not designed to run continuously at high stepping rates; the iron losses in 
the motor will cause it to overheat. 

**CONNECTION DIAGRAM **

• **Motors ****with ****bipolar ****4-phase ****electronic ****drive ****unit 9904 ****131 ****03008 **

4-PHASE 

BIPOLAR 

DRIVE 

UNIT 

+5V 

1 

2 R 

M 

5 

6 

c 
av 

av 

7 + VMM 

B Mal 

g Mb1 

10 Ma2 

ll Mb2 

12 Ma3 

lJ Mb3 

14 Ma4 

15 Mb4 

Fig. i. 

MOTOR COILS 
,-----1 

'1· 
I 
I 
•2· 
I 

3 
I 
I 

4 

4· 
I 
L _____ J 

**7Z85952 **


---

## Page 41

**9904 ****112 **
**9904 ****115 **

1006 

1031 

1033- 1034 

32 
February 1984 

**STEPPING ****MOTORS **

*830711-01-02 *
*761224-10-06 *

1027 

*830711-07-19 *
*830711-01-17 *

1032 

*830711-01-03 *
*830771-01-20 *

1035 - 1036 

*830711-07-04 *

HR23 


---

## Page 42

ID06-series 
J 
----

9904 112 06001 
9904 112 06101 

4-PHASE UNIPOLAR STEPPING MOTORS 

permanent magnet version 

QUICK REFERENCE DATA 

motor type 
99C4 112 06001 
9904 112 06101 

performance 
integrated circuit 
drive unit 
obtained with 
SAA1027 
9904 131 03006 

Step angle 
70 30' 
70 30' 
Max. working torque 
40mNm 
50mNm 
Holding torque 
70 mNm 
70mNm 
Max. pull-in 
110 steps/s 
200 steps/s 
Max. pull-out 
-
320 steps/s 

APPLICATION 

Motor 9904 112 06001 is adapted for drive with integrated circuit SAA 1027. This motor is for appli-
cations where the system efficiency prevails and circuitry design is simple and straight-forward. 

Motor 9904 112 06101 is adapted for drive unit 9904 131 03006. This motor is ideally suited for vari-
able speed drive where high pull-out capabilities of the motor are required. 

TECHNICAL DATA 

Outlines 

_.,. **17±0,S **, _____ 76 **2 ****max **-----<l 

4_g,,, 1 ;:, 
. 
t 
•-' [·---'----'-" 
o L 
44 
**10-oos **---= 
-
----------
**max **

-50,7max-

r-t- L----~-l 
I t 
. : -: 

21ol7~~ 
- ~ 
l 

±10 

l 

Fig. 1. 

1 1 
50 
55 
±0,2 ±0,5 

*l *

7Z69035 

November 1983 
33 


---

## Page 43

9904 112 06001 
9904 112 06101 

catalogue number 

Power consumption of motor only 
Maximum working torque 
Holding torque 
Torque derating 
Maximum pull-in rate 
Maximum pull-out rate 
Resistance per phase at 20 °c 
Inductance per phase 
Current per phase 
Thermal resistance, coil-ambient 
Permissible ambient temperature range 
Permissible storage temperature range 
Permissible motor temperature 
Insulation resistance at 500 V (CEE 10) 
Step angle 
Step angle tolerance, not cumulative 

Number of steps per revolution 
Direction of rotation 
Rotor inertia 
Mass 
Maximum radial force 
Maximum axial force 
Bearings 

Connections 

9904 112 06001 

6,4 
40 
70 
-0,4 

110 

45 
130 
250 
12 

-20 to+ 50 
-40 to+ 100 

120 
>2 
7°30' 
± 20' 
48 
reversible 
90 
320 

15 
1,5 
slide 

9904 112 06101 

4 
50 
70 
-0,4 
200 
320 

12 
35 
400 
12 
-20 to+ 70 
-40 to+ 100 

120 
>2 
70 30' 
± 20' 
48 
reversible 
90 
320 

15 
1,5 
slide 

The connecting leads are colour-coded (see Fig. 1) and are connected to the drive unit or to the 
integrated circuit as shown in General section of 4-phase unipolar stepping motors. 

applied 

torque 
(mNm) 

34 
November 1983 

100 ~ 

80 

60 

40 

20 

I/ 
0 

0 

*y *
1d 
*v *
*x *

2,5 

7Z73244 1 
. ---y------,-----r-· 

/ 
Ll 
IL 
l7 

7,5 

deviation (degrees) 

Fig. 2 Applied torque versus deviation. 

w 
mNm 
mNm 
%/K 
steps/s 
steps/s 
n 
mH 
mA 
K/W 
oc 
oc 
oc 
Mrl 

gcm 2 
g 
N 
N 


---

## Page 44

**4-phase ****unipolar ****stepping ****motors **

**Motor ****9904 ****112 06001 with integrated circuit ****SAA ****1027 **

100 

torque 
lmNm) 

75 

50 

25 

**f--**

0 

10 
12,5 

**r-.... **

30 
37,5 

b T"' pull-in 

~ 

I\ 

**l\ ****1 **
100 
125 

300 
375 

1000 
1250 

**9904 ****112 ****06001 **

**9904 ****112 ****06101 **

**7Z73 ****256 **

3000 
steps/s 
3750 
rev/min 

Fig. 3 Torque versus stepping rate, measured at room temperature. 

**Motor ****9904 ****112 06101 with drive unit ****9904131 ****03006 **

torque 
(mNm) 1------1--1--l--+-+-+-+++---+----11--+-l--+-+-H-f----+-+--t-+-+-++t-t 

~---1---+-+-+_,11-F'~pul~ull-out--+--+-+-1-+-1----+---l---+--+-+-+-H-J 

25L-~.L.--l--i.-4-_j._j_-l-W-::s:~~__j_-~~,l-+-l-l-l-l-l-l-~-+--+--+-++++-H 

**-1 **
**l\ **

i 
Ql._ _ 
__J _ 
_J___L_L--LL.LLL---'-__l-'-"-L....1.-1-LLI---+-~-'--"--'--'-'-'-' 
10 
30 
100 
300 
1000 
3000 
steps/s 
12,5 
37,5 
125 
375 
1250 
3750 
rev/min 

Fig. 4 Torque versus stepping rate, measured at room temperature. 

November 1983 
**35 **


---

## Page 45

36 

0,4 

pull-in 

(WJ 

0,3 

0,2 
*v *
*? *

rr 

IJ 
rz 

17 
17 
17 

**7266793 ****2 **

\ \ ~ 
***v ***
*I' *
I/ 

0,1 
7 
*vf *
*r7 *

~ 

0 

10 
12,5 

7i 
/ 
*y *

30 
37,5 

pull-in 

100 
125 

300 
375 

pull-out 
IT 
IT 

1000 
1250 

3000 
steps/s 
3750 
rev/min 

Fig. 5 Output power versus stepping rate measured at room temperature. 
(type 9904112 06101) 

.. ~, ... 1 

1,0 

pull-out 
(WJ 

0,75 

0,5 

0,25 

0 


---

## Page 46

1027-series 
J 
- -

9904 112 27001 
9904 112 27101 

4-PHASE UNIPOLAR STEPPING MOTORS 

permanent magnet version 

QUICK REFERENCE DATA 

motor type 
9904 112 27001 
9904 112 27101 

performance 
integrated circuit 
drive unit 
obtained with 
SAA1027 
9904 131 03006 

Step angle 
7° 30' 
7° 30' 
Max. working torque 
100 mNm 
110 mNm 
Holding torque 
140 mNm 
150 mNm 
Max. pull-in rate 
80 steps/s 
275 steps/s 
Max. pull-out rate 
-
275 steps/s 

APPLICATION 

Motor 9904 112 27001 is adapted for drive with IC SAA 1027 and offers a simple and economic 
solution for applications where a step-wise rotational function is wanted. Expensive and complex 
mechanisms can be replaced by this motor and drive. 

Motor 9904 112 27101 is adapted for drive unit 9904 131 03006 and offers higher torque and speed 
in those applications where variable speed is needed. 

Main application areas of both versions include chart recorders, X-Y plotters, paper feed mechanisms 
in terminal and telex printers, medical instrumentation, industrial control, etc. 

The design and rigid construction of the motors ensure a long, maintenance-free life. 

November 1983 
37 


---

## Page 47

9904 112 27001 
9904 112 27101 

TECHNICAL DATA 

catalogue number 
9904 112 27001 
9904 112 27101 

Power consumption of motor only 
6,8 
6,8 
w 
Maximum working torque 
100 
110 
mNm 
Holding torque 
140 
150 
mNm 
Torque derating 
-0,4 
-0.4 
%/K 
Maximum pull-in rate 
BO 
275 
steps/s 
Maximum pull-out rate 
275 
steps/s 
Resistance per phase at 20 oc 
39 
9,8 
.n 
Inductance per phase 
240 
60 
mH 
Current per phase 
290 
580 
mA 
Thermal resistance, coil-ambient 
8 
8 
K/W 
Permissible ambient temperature range 
-20 to+ 70 
-20to + 70 
oc 
Permissible storage temperature range 
-40 to+ 100 
-40to + 100 
oc 
Permissible motor temperature 
120 
120 
oc 
Insulation resistance at 500 V (CEE 10) 
>2 
>2 
Mil 
Step angle 
70 30' 
7°30' 
Step angle tolerance, not cumulative 
± 15' 
± 15' 
Number of steps per revolution 
48 
48 
Direction of rotation 
reversible 
reversible 
Rotor inertia 
70 
70 
gcm2 
Mass 
610 
610 
g 
Maximum radial force 
50 
50 
N 
Maximum axial force 
20 
20 
N 
Bearings, front 
ball 
ball 
Bearings, rear 
slide, bronze 
slide, bronze 

Connections 

The connecting leads are colour-coded (see Fig. 5) and are connected to the IC or drive unit as shown 
in the General Section on 4-phase unipolar stepping motors. 

38 
November 1983 

applied 

torque 
(mNm) 
~ 
1601--+--+-+-+--+--+--+-+-+--1---cd'-""+=--+-+-~ 
vr-1 
*y *

120>--+--+-+--+--+--J,.-1!--~L-1'-+--+--1---''"--'--+--1-~ 

VI 
80>--f--l--!--~/T-A---1---1---1--+--I~•---'---'~'--' 

*y *

40>--+--~LJ,.__._--+--l~!--+--+-+--+--+---l---1--+--I 

/ 

o IL 

0 
2,5 
7,5 
deviation (degrees) 

Fig. 1 Applied torque versus deviation. 


---

## Page 48

**4-phase ****unipolar ****stepping ****motors **

**Motor ****9904 ****112 27001 with integrated circuit SAA 1027 **

**9904 ****112 ****27001 **

**9904 ****112 ****27101 **

200r-~--.~-,.--.--.-..,.-,r--r-n-~~.,.---.~,....-,-.-~...,.,..~~-.-~.,.-~...--'7F
26~
98~
74;,...., 

pull-in 
torque 
(mNm) 

100 **r-.... **

010 

12,5 

30 
37,5 

100 
125 

300 
375 

1000 
1250 

3000 
steps/s 
3750 
rev/min 

Fig. 2 Pull-in torque versus stepping rate at room temperature. 

**Motor ****9904112 ****27101 with drive unit ****9904131 ****03006 **

200 

torque 
(mNm) 

150 

***i---:::. ******Q ***- I-

100 

50 

0 10 

12,5 

·-

30 
37,5 

· .. ~ -r-

""~ 
~ 
pull-i~pull-out 

100 
125 

~ \\ 

~ \ 

**j **

300 
375 

1000 
1250 

7269872 2 

3000 
steps/ s 
3750 
rev/min 

Fig. 3 Torque versus stepping rate, measured at room temperature. 

November 1983 
**39 **


---

## Page 49

**9904 ****112 ****27001 **
**9904 ****112 ****27101 **

**40 **

2 

output 
power 
(W) 

1,5 

0,5 

***r"" ***

0 

10 
12,5 

**Outlines **

~-rl_ 
*I *
~ 
**lZ **
:::::71 

30 
37,5 

/ *z *
v/-\~ 

VV1lZ 
I\ 
Ill 

~ 
*w *
~ 

100 
125 

pull-in 
pull-out 

300 
375 

J 

1000 
1250 

7Z69870 1 

3000 
steps/s 
3750 
rev/min 

Fig. 4 Output power versus stepping rate measured at room temperature. 
(type 9904112 27101) 

18±::,.--,_r __ 
58-,1 m-ax __ 
1. 
< 

,..__ ___ **0 ****69,1 ****max---•• **

1~055±0,1-1 

-
· -4,5±0,2 
I 

067,5 
12-003 
-+' ---t----1-1 

6 =g:g~~ 

Note 

Y•llow1~ ~ 
**black ****1' **
**red **
**2' **
**grey **
**2 **
**3 ****yellow **
**3' ****black **
**lead length 175±15 ****--**
**4' ****red **
**4 ****grey **

lead length 190±15 --

Fig. 5. 

Special versions having a spindle with a diameter of 3 mm and a length of 8,2 ± 0,5 mm for use with a 
gearbox may be available upon request. 

··~h ""'I 


---

## Page 50

**ID27B **
j **9904 ****112 ****27201 **
---

**2-PHASE BIPOLAR STEPPING MOTOR **

**QUICK REFERENCE DATA **

Performance obtained with electronic drive unit 9904 131 03007 

Step angle 

Maximum working torque 

Holding torque 

Maximum pull-in rate 

Maximum pull-out rate 

**TECHNICAL DATA **

**Outlines **

**Note **

11167,5 

'

1' =brown/white 
**1 =brown **

**lead ****length ****1'7:5±15--**
**2' ****=red/white **
**2 =red **

lead length 190± 15 --

Fig. 1. 

70 30' 

130 mNm 

170 mNm 

450 steps/s 

5000 steps/s 

**·----0 ****69,1 ****max----· **

r---o5s±o,1-1 

' -4,5±0,2 
' 

Special versions having a spindle with a diameter of 3 mm and a length of 8,2 ± 0,5 mm may be 
available upon request in minimum order quantities, and involve longer delivery times. 

*( *
Mo~h 1986 

-

**41 **


---

## Page 51

**9904 ****112 ****27201 **l __ _ 

**42 **

catalogue number 

Power consumption of motor only 
Maximum working torque 
Holding torque 
Torque derating 
Maximum pull-in rate 
Maximum pull-out rate 
Number of phases 
Resistance per phase at 20 oc 
Inductance per phase 
Current per phase 
Permissible ambient temperature range 
Permissible storage temperature range 
Permissible motor temperature 
Insulation resistance at 500 V (CEE10) 
Step angle 
Step-angle tolerance, non-cumulative 
Number of steps per revolution 
Direction of rotation 
Rotor inertia 
Mass 
Maximum radial force 
Maximum axial force 
Bearings, front 
rear 

**Connections **

9904 112 27201 

3,75W 

130 mNm 
170 mNm 
-0,4%/K 
450 steps/s 
5000 steps/s 
2 
7,5n 
90mH 
500 mA 
see General section of Stepping motors 
-40 to + 100 oc 
120°c 
>2 Mn 
7° 30' 
± 15' 
48 
reversible 
70 gem' 
610 g 
50 N 
20 N 
ball 
slide 

The connecting leads are colour-coded and are connected to the electronic drive unit 9904 112 03007 
drive as shown in General section of 2-phase bipolar stepping motors. 

**applied **
**torque **
(mNm) 

J'""""'" I 

200 

160 

120 

80 

40 

**7276468 ****1 **
1=r+--+--+-+-+-+-+--+-I--+-T_J=· -: 
LI 

::=::=:::~:-----1+_--+-_--+:L:v--,_E· 
-+-_---it-1--+r----+c----j-

r--- -
j----j----+---t----t----hL'l~+-
. f--+--
*1.L *
I 
t--+--+--+-4-4[/'1---;l'--+--+--t---+-+-t--t--+-

f---t--i - 1-17 ---t-t--+---+----+--t-- --+---1-

:=:::.A:V'"=:=:=:=:=:=:=:=:=:-___ 4-=== 

o IL1_L+---+~---~- ~-~--+ __ IJ_T--+-~-= 

0 
2,5 
7,5 

**deviation (degrees) **

Fig. 2 Applied torque versus deviation. 


---

## Page 52

**2-phase bipolar stepping motor **
**9904 ****112 ****27201 **

**l\Jlotor ****9904 ****112 27201 with drive unit ****9904 ****131 ****03007 **

**torque **
(mNm) 

1251----+--~-...... =+--+-+-+-+++----t--"'-__,,,,.i--+--+-+-+-f-H---+--+---+-+--l--+-+-H 
-· +--+-:'"+L-..~. kt--+-+++---··- -t---1l'--.~::"'lcl-+-1--+-++1---+·- -+--t-+-t-~-l 

IS 

1001----+--+--+--+-+-+-+++--'~~~-+--+-+--+-'l-+-f-H---+--+---+-+--l--+-+-H 

' 

75t----+--+--+--+-+-+-+++------t,........~r-+--+--+--+-<~,.......--+--+_.-+-+-+-+-+-I 

t----+--+---+-+-+--+-+++-----11----T pu 11- in +--+-+++---'i,,_ pu 11-out -+-+-+--+-t--t--H 

501-----+--+--+--+-+-+-t-++---+------t-1++--+--t-+-++<--::s:~..:-i.--+--+-+-t-+-+-+-H 

:I 
~ 
25t----+--+--+--+-+-+-+-++------tl----+--+++--+-<~-+----+-_,__.-+-+-+-+-+-I 

**output **
**power **
(W) 

D... 

O'-----'----'-----'---'---'---'--l-l....__ _ 
___,._____._--'--'-...L.Ji...W-L---'-----'---'--'-~1"-<c.:::i.o....u 
10 
30 
100 
300 
1000 
3000 
steps/s 
12,5 
37,5 
125 
375 
1250 
3750 
rev/min 

Fig. 3 Torque versus stepping rate, measured at room temperature. 

**7292577 **
10,.----,---.---,--,---,.--,.-,--,.,-----,----,-,,-,rr,..,..._.~:--r---,--r-rT"T"TTl 

*lL *
~ 

1-----+--+--+--+-+-+-+-++---t----+--+--+-ll.*-'~-+----+--'l...,_Ku11-ouq-

_LJ 
*!L *
*i *
*IL *
l\ 

2,51----+--+--+--+-+-++++-;;r~,c_-+-~~]::s.;J,-+-t-+-t--t--+---+-,-+--i-+-+--H-+-I 

H ~ f" 
f--1""" -H 
o~~=t::rttttt==t:!~I:ttt1!t==t=trt:t!!tl 

10 
12,5 

30 
37,5 

100 
300 
125 
375 
1000 
1250 
3000 
3750 
**steps/s **
**rev/min **

Fig, 4 Output power versus stepping rate, measured at room temperature. 

*( *J'""'" 1984 
" 


---

## Page 53


---

## Page 54

1028-series 
j 
- -

**9904 ****112 ****28001 **
**9904 ****112 ****28101 **

**4-PHASE UNIPOLAR STEPPING MOTORS **

permanent magnet version 

**QUICK REFERENCE DATA **

motor type 
9904 112 28001 
9904 112 28101 

performance 
integrated circuit 
drive unit 
obtained with 
SAA1027 
9904 131 03006 

Step angle 
15° 
150 
Max. working torque 
60mNm 
65mNm 
Holding torque 
80mNm 
85mNm 
Max. pull-in 
90 steps/s 
200 steps/s 
Max. pull-out 
-
250 steps/s 

**APPLICATION **

Motor 9904 112 28001 is adapted for drive with IC SAA 1027 and offers a simple and economic solution 
for applications where a step-wise rotational function is wanted. Expensive and complex mechanisms can 
be replaced by this motor and drive. 

Motor 9904 112 28101 is adapted for drive unit 9904 131 03006 and offers higher torque and speed in 
those applications where variable speed is needed. 

Main application areas of both versions include chart recorders, X-Y plotters, paper feed mechanisms 
in terminal and telex printers, medical instrumentation, industrial control, etc. 

The design and rigid construction of the motors ensure a long, maintenance-free life. 

November 1983 
45 


---

## Page 55

**9904 ****112 ****28001 **l 
**9904 ****112 ****28101 **

...._~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 

**TECHNICAL DATA **

catalogue number 
9904 112 28001 
9904112 28101 

Power consumption of motor only 
6,8 
6,8 
w 
Maximum working torque 
60 
65 
mNm 
Holding torque 
80 
85 
mNm 
Torque derating 
-0,4 
-0,4 
%/K 
Maximum pull-in rate 
90 
200 
steps/s 
Maximum pull-out rate 
-
250 
steps/s 
Resistance per phase at 20 oc 
39 
9,8 
.Q 
Inductance per phase 
200 
45 
mH 
Current per phase 
290 
580 
mA 
Thermal resistance, coil-ambient 
8 
8 
K/W 
Permissible ambient temperature range 
-20 to +70 
-20to+ 70 
oc 
Permissible storage temperature range 
-40 to+ 100 
-40 to+ 100 
oc 
Permissible motor temperature 
120 
120 
oc 
Insulation resistance at 500 V (CEE 10) 
>2 
>2 
m.Q 
Step angle 
15° 
150 
Step angle tolerance, not cumulative 
± 30' 
±30' 
Number of steps per revolution 
24 
24 
Direction of rotation 
reversible 
reversible 
Rotor inertia 
70 
70 
gcm2 

Mass 
610 
610 
g 
Maximum radial force 
50 
50 
N 
Maximum axial force 
20 
20 
N 
Bearings 
slide (bronze) 
slide (bronze) 

**Connections **

The connecting leads are colour-coded (see Fig. 5) and are connected to the IC or drive unit as shown in 
the General Section on 4-phase unipolar stepping motors. 

**46 **
November 1983 

**applied **

**torque **
(mNm) 

100 .-.--.-.---.----.-.--.--r---,~.-.--.--1+zs=2~11~0~1 
_...rt-1 
~ 
ao~~~--<~<--<--41/"__,17'_,....__,-+-+-+-+--< 

601--+--+--+--+---+-~Y"',__+--+---+--+---+---+--+--+--l 

V1 

401--+--+--+-~V__,l--l--+--+---+--+---+--+--+--+--l 

JZ: 

20 
*v *
171 
*olL *

0 
10 
15 
**deviation (degrees) **

Fig. 1 Applied torque versus stepping rate. 


---

## Page 56

**4-phase ****unipolar ****stepping ****motors **

**Motor ****9904 ****112 28001 with integrated circuit SAA 1027 **

200 

pull-in 
torque 
(mNmJ 

150 

100 

50 

0 

10 

25 

~ " 
I'\ 

30 
75 

I~ 

I\ 

~ 

100 
250 

-- +---

300 
750 

1000 
2500 

**9904 ****112 ****28001 **
**9904 ****112 ****28101 **

7l598?3 

3000 
steps/s 
7500 
rev/min 
Fig. 2 Pull-in torque versus stepping rate at room temperature. 

**Motor ****9904 ****112 28101 with drive unit ****9904 ****131 ****03006 **

torque 

7Z69875.2 

~-----+---+---t---t--t--i--H-t-----+----t---!---+--+--+-+-++-----+---+----+--·t--t-t-1 

1-------+--+---t---t--+--l-H-t----+----t-__,---+-+--+-+++----+--+---~-+-t--H 
(mNm) t-----+--+---+--++-1-t-1-t-----+-----+--1--+--+-++~+----+-+----+--+~--t-++l 

~ h,. 
pull-in 
I 
~ ~ 
j_ 
---+--t--+-~1-1-------+----+---+--+-+-+-i-t-1 

50 
[/'~ 

1-f-----~~~:~~:~:~:~::::+-~_,_I~---· ~--.ipu_l_l-o_u,_t::::-=~.:-:--t:::'=_-_:__-_:__-_:__-~:-=--=-:-=--=.~:'=_:::: 

\~ 

251--~l--+--f--l-+-l-+-++~-\_-\-!--1t+--+-+-H-+++~--+~+-+-+-f-+-+~ 

t--------~--+----+-~-+--l-+-f-t---~,._.__--+t--_,___,f-+--+-+-++----t----t-+--+--t--t-++-1 

0~~~~~~~~~~~~11-~~~~~~~~~~~~~~ 

10 
30 
100 
300 
25 
75 
250 
750 

1000 
2500 

3000 
7500 

steps/s 
rev/min 

Fig. 3 Torque versus stepping rate, measured at room temperature. 

*( *
l\Jovember 1983 
**47 **


---

## Page 57

9904 112 28001 
9904 112 28101 

4 

output 
power 
(W) 

3 

2 

C7' 

0 

10 
12,5 

--i.... 
*? *-
~ 
*y: *~ ' 

l:b" 
~ 
]# 

30 
37,5 

100 
125 

1 

pull-in 

"\ 1 

~ 
\ 

300 
375 

pull-out 

1000 
1250 

7269871.1 

3000 
steps *Is *
3750 
rev/min 

Fig. 4 Output power versus stepping rate measured at room temperature. 
(type9904112 28101) 

Outlines 

Note 

!~~::i·=i t~Jyellow 
=I 
3'black 
lead length 175±15 --
4.' red 
4 grey 

lead length 190±15 --

Fig. 5. 

·---- 0 69,1 max----· 

1~ 
056±0,1----.1 

.... ' --4,5±0,2 

--$-

Special versions having a spindle with a diameter of 3 mm and a length of 8,2 ± 0,5 mm for use with a 
gearbox may be available upon request. 

48 
Mo~h 19861 


---

## Page 58

**-ID28B **_ _  
J **9904 ****112 ****28201 **

**2-PHASE BIPOLAR STEPPING MOTOR **

permanent magnet version 

**QUICK REFERENCE ****DATA **

Performance obtained with electronic drive unit 9904 131 03007 

Step angle 

Maximum working torque 

Holding torque 

Maximum pull-in rate 

Maximum pull-out rate 

**TECHNICAL ****DATA **

**Outlines **

**Note **

12167,5 

'

1' =brown/white 

**1 ****=brown **

**lead length 175±15 ****--**
***i *****= ****red/white **
**2 ****=red **

**lead length ****190± ****15 **--

Fig. **1. **

15° 

90mNm 

110mNm 

275 steps/s 

3200 steps/s 

**,----0 ****69,1 ****max ****___ **
**_., **

1~056±0,1-1 

-
' **--4,5±0,2 **

Special versions having a spindle with a diameter of 3 mm and a length of 8,2 ± 0,5 mm may be 
available upon request in minimum order quantities, and involve longer delivery times. 

*( *
Mo"h 1986 
49 


---

## Page 59

**9904 ****112 ****28201 **l __ _ 

50 

catalogue number 
9904 112 28201 
---------------------------!------------------
Power consumption of motor only 
Maximum working torque 
Holding torque 
Torque derating 
Maximum pull-in rate 
Maximum pull-out rate 
Number of phases 
Resistance per phase at 20 oc 
Inductance per phase 
Current per phase 
Permissible ambient temperature range 
Permissible storage temperature range 
Permissible motor temperature 
Insulation resistance at 500 V (CEE10) 
Step angle 
Step-angle tolerance, non-cumulative 
Number of steps per revolution 
Direction of rotation 
Rotor inertia 
Mass 
Maximum radial force 
Maximum axial force 
Bearings, front 
rear 

3,75W 
90mNm 
110 mNm 
-0,4%/K 
275 steps/s 
3200 steps/s 
2 
7,5.n 
70 mH 
500mA 
see General section of Stepping motors 
-40 to + 100 oc 
120 oc 
>2MS2 

150 
± 30' 
24 
reversible 
70 gcm2 
610 g 
50 N 
20 N 
ball 
slide 
-----------------··---·-·----·-----------~------

Connections 

The connecting leads are colour-coded and are connected to the electronic drive unit 9904 112 03007 
as shown in General section of 2-phase bipolar stepping motors. 

''"""V 19841 

**applied **

**torque **
(mNm) 

1601--+--+--+---+-+-'-+--+--+----+--+-+-'1---l-----l 

olL 

0 
10 
15 
**deviation ****(degrees) **

Fig. 2 Applied torque versus deviation. 


---

## Page 60

2-phase bipolar stepping motor 
9904 112 28201 

Motor 9904112 28201 with drive unit 9904131 03007 

100 

torque 
(mNm) 

75 

50 

... 
~--
-
*,c_-*

--t-o_ 

1---
25 

0 

10 
25 

30 
75 

.... 

*R *

r---... b--, 

~ 
\ :I 

_lpult-in 

100 
250 

-\ 

il 
~ 

~ 
I 

300 
750 

b.. 

~ 

p;J 

pull-out 

~ -\ 

-\ 

1000 
2500 

~ 

::s: 

3000 
7500 

7276473.1 

steps/s 
rev/min 

Fig. 3 Torque versus stepping rate, measured at room temperature. 

output 
power 

(WI 

15 

12,5 

10 

7,5 

2,5 

0 

10 
25 

30 
75 

~ 

*r-*
~ -

100 
250 

rzF 
lL 
*-± *
*_t *
*L *

~ull-in 

~ 

-l: 

300 
750 

.L2'." 

1000 
2500 

~ -

3000 
7500 

7292578 

pull-out 

steps/s 
rev/min 

Fig. 4 Output power versus stepping rate, measured at room temperature. 

*( *
Joooo<y 1984 
51 


---

## Page 61

9904 112 29201 l_!D29B--

4-PHASE BIPOLAR STEPPING MOTOR 

permanent magnent version 

QUICK REFERENCE DATA 

__ _,.. Performance obtained with electronic drive unit 9904 131 03008 

Step angle 

Maximum working torque 

Holding torque 

Maximum pull-in rate 

Maximum pull-out rate 

TECHNICAL DATA 

Outlines 

30 45' 

280mNm 

300 mNm 

900 steps/s 

12000 steps/s 

I
------. 0 69,1 max --1 

-4----- D 56± 0,1----------

___---
! 
r=--=--=-10-0max===·-~r·-

11l67,5 

j 
-t-

conn~cti r;; mn l11TI 

leads 
*YfflVffl *

175~±15 ~ 

Fig, 1, 

-
Connecting leads 

1 = brown 
1' = brown/white 
2 = red 
2' = red/white 
3 = orange 
3' = orange/white 
4 =yellow 
4' =yellow/white 

52 
M•reh 19861 


---

## Page 62

4-phase bipolar stepping motor 

catalogue number 

Power consumption of motor only 
Maximum working torque 
Holding torque 
Torque derating 
Maximum pull in rate 
Maximum pull-out rate 
Number of phases 
Resistance per phase at 20 oc 
Inductance per phase 
Current per phase 

9904 112 29201 

7,5W 
280 mNm 
300 mNm 
-0,4%/K 
900 steps/s 

12000 steps/s 
4 
7,5 n. 
90mH 
500mA 

9904 112 29201 

Permissible ambient temperature range 
Permissible storage temperature range 
Permissible motor temperature 
Insulation resistance at 500 V 

see General section of Stepping motors 
-40 to + 100 oc 

Step angle 
Step-angle tolerance, non-cumulative 
Number of steps per revolution 
Direction of rotation 
Rotor inertia 
Mass 
Maximum radial force 
Maximum axial force 
Bearings, front 
rear 

Connections 

120 oc 
>2Mil 
3045• 
± 15' 
96 
reversible 
160 gcm2 
1100 g 
50 N 
20 N 
ball 
slide 

The connecting leads are colour-coded and are connected to the electronic drive unit 9904 112 03008 -
as shown in General section of 4-phase bipolar stepping motors. 

applied 

torque 
(mNm) 

400+--+--+-+-+--+--+-+-+-+--l~+--+--+-+-4 

200+--+--+-+-4~--lboo"'-+--+-+--+-+--+--+-+-+--I 

1001--+--i..<'~4~--l~I---+--+-+--+--+--+--+-+-+-~ 

/1 

1,25 
2,5 
3.75 
deviation (degrees) 

Fig. 2 Applied torque versus deviation. 

*( *
."'"" 1984 
53 


---

## Page 63

9904 112 29201 
l_ID29B--

-
Motor 9904 112 29201 with drive unit 9904 131 03008 

400 

torque 
(mNml 

300 

200 

100 

0 

10 
6,25 

-F 

30 
18,75 

i---.. 
~ 
~ 

!'-., 

100 
62,5 

[SJ 

i\. 

'J 

~ 

300 
187,5 

~ 

~ 

~ 
pull-in 

1000 

625 

\I pull-out 

rs: 

3000 

1875 

7Z76474 1 

N 

]"--.,, 

10000 
30000 
steps/s 
6250 
18750 
rev/min 

Fig. 3 Torque versus stepping rate, measured at room temperature. 

20 

output 
power 

(WI 

15 

10 

0 

10 

kl;.., 
........,... 

6,25 

30 
18,75 

JL 
Lll 
*.L1 *
rz 
*L *
*v *
~z 
*v *

100 
62,5 

300 
187,5 

*I *
~ 
*_L *
*rt *

J'j pull-in 

1000 

625 

3000 

1875 

7Z92579 

I~ 

Ii 
[_pull-out 
1 
I l ± 
l 

_l 

10000 
30000 
steps/s 
6250 
18750 
rev/min 

Fig. 4 Output versus stepping rate, measured at room temperature. 

54 
A"'"n 19841 


---

## Page 64

-10308 _ _  
j **9904 ****112 ****30201 **

**4-PHASE BIPOLAR STEPPING MOTOR **

permanent magnet version 

QUICK REFERENCE DATA 

Performance obtained with electronic drive unit 9904 131 03008 

Step angle 
70 30' 

Maximum working torque 

Holding torque 

Maximum pull-in rate 

Maximum pull-out rate 

TECHNICAL DATA 

Outlines 

Connecting leads 

1 =brown 
2 =red 
3 =orange 
4 =yellow 

1 ' = brown/white 
2' = red/white 
3' =orange/white 
4' = yellow/white 

190 mNm 

210 mNm 

520 steps/s 

7000 steps/s 

_s------rno~·--- ~=+i::o,s -
I 
___ fL 

11167,5 
-
12_g03 
I 
-----t-- -
' 
5-0,010 **t **
*l *
-0,018 

-T-

Fig. 1. 

--

I *( *
Meech 1986 
55 


---

## Page 65

**9904 ****112 ****30201 **

catalogue number 

Power consumption of motor only 
Maximum working torque 
Holding torque 
Torque derating 
Maximum pull-in rate 
Maximum pull-out rate 
Number of phases 
R esista nee per phase 
Inductance per phase 
Current per phase 
Permissible ambient temperature range 
Permissible storage temperature range 
Permissible motor temperature 
Insulation resistance at 500 V (CEE100) 
Step angle 
Step-angle tolerance, non-cumulative 
Number of steps per revolution 
Direction of rotation 
Rotor inertia 
Mass 
Maximum radial force 
Maximum axial force 
Bearings, front 
rear 

**Connections **

9904 112 30201 

7,5W 
190 mNm 
210 mNm 
-0,4%/K 
520 steps/s 
7000 steps/s 
4 
7,5 n 
70 mH 
500 mA 
see General section of Stepping motors 
-40 to+ 100 oc 
120 °c 
>2Mn 
70 30' 
± 30' 
48 
reversible 
160 gcm2 

1100 g 
50 N 
20 N 
ball 
slide 

~~~~~~~~~~~~~ 

-
The connecting leads are colour-coded and are connected to the electronic drive unit 9904 112 03008 
as shown in the General section of 4-phase bipolar stepping motors. 

**applied **
**torque **
(mNm) 
*,i.-r *

200f--+--+---+--+--+--r:/lf--~.LJ~-+--t--\f--+--+---+-~ 

*v *
1501---+--+-+--+--A---+--+-+-+--l--ll--+--+-+-~ 

100 f--+--+--1.171'--+-~-+--+--+---+--+-+--+--+--+-~ 

2,5 
7,5 
**deviation ****(degrees) **

Fig. 2 Applied torque versus deviation. 

.. 
.,.,., ... , 


---

## Page 66

**4-phase ****bipolar ****stepping ****motor **
**9904 ****112 ****30201 **

**Motor ****9904112 ****30201 with drive unit ****9904131 ****03008 **

**torque **
(mNm) 

2501----1---+-l----l-++-l-++---+-+--+-++-H-++---+--+--+-+--++TI 

1501----l---+--1--l-l-+-l-l-+--~cs:---1--~~!Sk-+-l-l-Hl-----l--+-+-+-l-+-l--l-l 

+----+---l---1--4-+--1-1++---+-:S---"I"'-.'.'."PUll ·in +-N pull-out --4--1--+-+--+-++-H 

100'---'---'---11----l-l-...L..l...W.---+-+--K°u...l-.L-l-LLI'-'---'--+-+-+-l-.j....j.._,_, 
'_S 

5ol-----l--l--+-++-1-+-1+---l---+-+-+H-H-++---+-~_,,.'IS:--1-+-+++-H 

::s 

II 

O'---'---'--'--'-'---'-'...W.---+-+--+-L...U..LLLJ....--+--"-.J..L.J.-L..1..-W.J 

30 

**output **
**power **

IW) 

25 

20 

15 

10 

10 
12,5 

o 
10 
12,5 

30 
37,5 

100 
125 
300 
375 

1000 
1250 
3000 
3750 
**steps/s **

**rev/min **

Fig. 3 Torque versus stepping rate, measured at room temperature. 

30 
37,5 

2 
./':.....--

100 
125 

7 
7_ 

7 
:::: 
~ I\ 

300 
375 

*v *

**pull-in **

rt 

*±-*
7 
7 *if *

1000 
1250 

**7292580 **

1.....-t-.. 
7 
7 

B 

**pull-out **

3000 
3750 
**steps/s **
**rev/min **

Fig. 4 Output power versus stepping rate, measured at room temperature. 

*( *
..... 1986 

-

-

57 


---

## Page 67


---

## Page 68

I D31-series 
J 
9904 112 31001 
9904 112 31101 
------

4-PHASE UNIPOLAR STEPPING MOTORS 

permanent magnet version 

QUICK REFERENCE DATA 

motor type 
9904 112 31001 
990411231101 

performance 
integrated circuit 
drive unit 
obtained with 
SAA1027 
9904 131 03006 

Step angle 
7° 30' 
70 30' 
Max. working torque 
22mNm 
24mNm 
Holding torque 
30mNm 
34mNm 
Max. pull-in rate 
180 steps/s 
400 steps/s 
Max. pull-out rate 
-
500 steps/s 

APPLICATION 

Motor 9904 112 31001 is adapted for drive with IC SAA 1027. This motor is for applications where 
system efficiency prevails. 

Motor 9904 112 31101 is adapted for drive unit 9904 131 03006 and offers higher torque and speed in 
those applications where variable speed is needed. 

Main application areas of both versions include paper feed mechanisms for small printers, punched tape 
transport mechanisms, serving machines, adjustment of needle and transport stroke, automotive, car-
burettor control, etc. 

TECHNICAL DATA 

Outlines 

Connecting leads 

1 =yellow 
A ~·: ~~:~k 

2' =red 

r 3 =yellow 

3' =black 
B '[ 4 =grey 
4' =red 

8,2.:!:0,5-71-23,8.:!:0,3-
-3±0,5 

!3'51 
70,5 ~g .. ~ 

-~1.t B --01 
- _, 
--1-~.5 

-
6-

Fig. 1. 

*( *
Moroh 1986 

-

59 


---

## Page 69

9904 112 31001 
9904 112 31101 

catalogue number 
9904 112 31001 
990411231101 

Power consumption of motor only 
4 
4 
w 
Maximum working torque 
22 
24 
mNm 
Holding torque 
30 
34 
mNm 
Torque derating 
-0,4 
-0,4 
%/K 
Maximum pull-in rate 
180 
400 
steps/s 
Maximum pull-out rate 
500 
steps/s 
Resistance per phase at 20 oc 
62 
17 
n 
Inductance per phase 
160 
45 
mH 
Current per phase 
190 
325 
mA 
Thermal resistance, coil-ambient 
12 
12 
K/W 
Permissible ambient temperature range 
-20 to+ 70 
-20 to+ 70 
oc 

Permissible storage temperature range 
-40 to+ 100 
-40 to+ 100 
oc 

Permissible motor temperature 
120 
120 
oc 

Insulation resistance at 500 V (CEE 10) 
>2 
>2 
M.Q 
Step angle 
70 30' 
7o 30' 
Step angle tolerance, not cumulative 
± 20' 
± 20' 
Number of steps per revolution 
48 
48 
Direction of rotation 
reversible 
reversible 
Rotor inertia 
11 
11 
gcm 2 

Mass 
200 
200 
g 
Maximum radial force 
5 
5 
N 
Maximum axial force 
1,5 
1,5 
N 
Bearings 
slide (bronze} 
slide (bronze) 

Connections 

The connecting leads are colour-coded (see Fig. 1) and are connected to the IC or drive unit as shown 
in the General Section on 4-phase unipolar stepping motors. 

applied 

torque 
(mNm) 

60 
N~~b" 19831 

/ 17 

30r--t--+--+---+---l--+--l7"-+--+--l~~l--+--+---1 

V1 
[7 

20----+----+----+-/1~!7-A----+----+----+----+----+--+--+--+--+---I 

10----+---b.L1~-+--+-+---+--+--+--+--+----+---+---~ 
I/ 
olL 

0 
2,5 
7,5 
deviation (degrees) 

Fig. 2 Applied torque versus deviation. 


---

## Page 70

**4-phase ****unipolar ****stepping ****motors **

**Motor ****9904112 ****31001 with integrated circuit SAA1027 **

40 

torque 
(mNm) 

30 

20 

10 

0 

I"'" 

10 
12,5 

**l""--J **

30 
37,5 

~ 

['lj 

N pull-in 

~ \ 

100 
125 

~ \ 

~ 

300 
375 

1000 
1250 

**9904 ****112 ****31001 **

**9904 ****112 ****31101 **

**7Z76482 **

3000 
steps/ s 
3750 
rev/min 

Fig. 3 Torque versus stepping rate, measured at room temperature. 

**Motor ****9904112 ****31101 with drive unit ****9904131 ****03006 **

torque f------l--+--+-+-+-t-+1+---+----t-+--r-+-+-t-++---+--+--+-+-t--t--t-H 
(mNm) f------l--+--+-+-+-t-+1+---+----l-j--;f-+-+--l-++---+---+--+-+-1-++-H 

1------l---+--+--+-+-+-+-++----+--pu l l -in 
---;;;; --
~v 
t- ---+--+--+-+-
-'F-'l-+--~-7""1~- -''------~·-+-++++--- --+-- -+---+--+--1--+-+-H 
-
~ 
~ 
pull-out 
t--
:s: 
"""\ 

20 t-------jf---+-+--j-+-+-+++--~-+---+~4+--+-1-+-j4+-----l-+--+--t-t--jl-+H 

~ 
1----+---+-+-+-+++-1-+----+-1_-\--t----+--+-+ti-+-----+---+--+-+-+-+++-1 
10f------l--+--+-+-+-t-+1+---+--\t-t+-1r-+-+-t-++---+--+--+-+-t--t--t-H 

~ 

t--
0 
I'\ 
10 
30 
100 
300 
1000 
3000 
steps/s 
12,5 
37,5 
125 
375 
1250 
3750 
rev/min 

Fig. 4 Torque versus stepping rate, measured at room temperature. 

(November 1983 
**61 **


---

## Page 71

**9904 ****112 ****31001 **
**9904 ****112 ****31101 **

1,0 

output 
power 
(W) 

0,75 

0,50 

0,25 

..-
0 10 

12,5 

0-' 
...R' 
~ 

30 
37,5 

*f *
*J_ *
*-ll-*
*V7 *
~v 
J..' 

100 
125 

l2J 
7_ 
*rf *

~ 

11 

pull-in 

300 
375 

pull-out 
[ 
ll 
1 1 
1000 
1250 

**7Z76479 **

3000 
steps/s 
3750 
rev/min 

Fig. 5 Output power versus stepping rate, measured at room temperature. 
(type990411231101) 

62 
•• ,,,., , ... I 


---

## Page 72

**ID31 **E-series 
J **9904 ****112 ****31004 **

**9904 ****112 ****31104 **
- -

**4-PHASE UNIPOLAR STEPPING ****MOTORS **

permanent magnet, economy version 

**QUICK REFERENCE ****DATA **

motor type 
990411231004 
9904112 31104 
performance 
integrated circuit 
drive unit 
obtained with 
SAA1027 
9904 131 03006 
Step angle 
7°30' 
7° 30' 
Max. working torque 
20mNm 
24mNm 
Holding torque 
28mNm 
32mNm 
Max. pull-in rate 
240 steps/s 
400 steps/s 
Max. pull-out rate 
-
500 steps/s 

**APPLICATION **

These motors are designed as economy versions. They have six solder tag connections for automated 
production. 

**TECHNICAL ****DATA **

**Outlines **

8,2±0,5 
.... 
r25 max- 1--3±0,5 
-11-1 
-- --2.5 

0 3 -0,008 
-0,002 
•-+ 
010_8.05 == 
***-+-1-***
**t **
run out 
0,07 max 

1 --10,6 --
-- --1.s 

l 
**t **051 
18,3 max 

+ 

Fig. 1. 

*( *
"'"h 1986 

-

63 


---

## Page 73

**9904 ****112 ****31004 **
**9904 ****112 ****31104 **

catalogue number 
9904 112 31004 
9904 112 31104 

Power consumption of motor only 
3,8 
3,5 
w 
-
Maximum working torque 
20 
24 
mNm 
Holding torque 
28 
32 
mNm 
Torque derating 
-0,4 
-0,4 
%/K 
Maximum pull-in rate 
240 
400 
steps/s 
Maximum pull-out rate 
500 
steps/s 
Resistance per phase at 20 oc 
65 
11 
n 
Inductance per phase 
100 
16 
mH 
Current per phase 
175 
400 
mA 
Thermal resistance, coil-ambient 
13 
13 
K/W 
Permissible ambient temperature range 
-20 to+ 70 
-20 to+ 70 
oc 
Permissible storage temperature range 
-40 to+ 100 
-40 to+ 100 
oc 
Permissible motor temperature 
120 
120 
oc 
Insulation resistance at 500 V (CEE 10) 
>2 
>2 
Mn 
Step angle 
70 30' 
7° 30' 
Step angle tolerance, not cumulative 
± 25' 
± 25' 
Number of steps per revolution 
48 
48 
Direction of rotation 
reversible 
reversible 
Rotor inertia 
11 
11 
gcm2 

Mass 
170 
170 
g 
Maximum radial force 
5 
5 
N 
Maximum axial force 
1,5 
1,5 
N 
Bearings 
slide (bronze) 
slide (bronze) 

**Connections **

The connecting tags are marked as shown in Fig. 1 and are connected to the IC or drive unit as shown 
in the General Section on 4-phase unipolar stepping motors. 

**64 **

**applied **

**torque **
(mNm) 

"'"'' 1986 ~ 

40+--+-+-+-+--+--+-t---+--+--1~f--{~+-+-~ 

201--1--t--+-+----t7L~J7-+--+-+--+---+-+--+-+--4 

*vkd *

10+--+--tr.L+--+--+--+-t---+--+--11--+--+-+-+-~ 

/'1 

0 lLJ 

0 
2,5 
7,5 
**deviation ****(degrees) **

Fig. 2 Applied torque versus deviation. 


---

## Page 74

4-phase unipolar stepping motors 

Motor 9904 112 31004 with integrated circuit SAA 1027 

40 

torque 
(mNm) 

30 

20 

10 

0 

10 
12,5 

""'h.. 

30 
37,5 

l'hJ 

I"-! 

~Ull·in 

~ 

~ 

100 
125 

' l \ 

300 
375 

1000 
1250 

9904 112 31004 
9904 112 31104 

7Z82282 

3000 
steps/s 
3750 
rev/min 

Fig. 3 Torque versus stepping rate measured at room temperature. 

Motor 9904112 31104 with drive unit 9904131 03006 

40 

torque 
(mNm) 

30 

20 

10 

i....--~ 

0 

10 
12,5 

:::,:;j -

""""l 

30 
37,5 

. .., t-
... t--i 
-............. 
pull-in ~pull-out 
~ 

"""' 
~ 

~ 

100 
125 

LS: 

~ 

~ 

300 
375 
' .l 

1000 
1250 

7Z82281.1 

3000 
steps/s 
3750 
rev/min 

Fig. 4 Torque versus stepping rate, measured at room temperature. 

November 1983 
65 


---

## Page 75

**9904 ****112 ****31004 **
**9904 ****112 ****31104 **

1,0 ~--...,...-.,..-.,.......,......,.....,........,...,...---..---.--...,...--.-.,.........,....,...,.----,--,..-.,--..--.-7Z-.-82-.-2.,..,79 

output 1----+--+-+-1-+-++~--+--+---'l-rf-ll-+-+++t----+--+-+-1-+-++-H 
power 
(W) 
i--~>---t-1---+-+-+-+-++-~--+----+-r"if-fl-->f--+-i-+-++~-+~>----+---+--i-+-+-+-1 

0,751-----+--+-+--<--+--+-+-++-~-+--+--+--++-+-++-+-t----+--+-+---+--t-+ ..... 
*z *
pull-out_L 
*7 *

o,5 o >---+---+--+-+---.-.-++<1--z~.LJl'-+----+---+-.....++-+-+----+---+--+--+-t-............... 

~ 

*P *l7pull-in 
:\" 
0,2 5 f----+---+-+--+-+-J..-"¥HJll<l-'---+--+-+r-
\-++l-+-f-++-----11---+--+-+--+-++H 

l7l-" 

o~r--
_ ___. _ _._..J.-.J._._-'-'-.J...._ _ 
_.__.___~I..._.._._....._.__-"'---'---'-"--'-..._,_~ 
10 
12,5 
30 
37,5 
100 
125 
300 
375 
1000 
1250 
3000 
3750 
steps/s 
rev/min 

Fig. 5 Output power versus stepping rate measured at room temperature. 
(type 9904 112 31104) 

66 
••~h 19861 


---

## Page 76

ID31 E-series 
j 
- -

9904 112 31006 
9904 112 31106 

4-PHASE UNIPOLAR STEPPING MOTORS 

permanent magnet, special purpose, economy version 

QUICK REFERENCE DATA 

motor type 

performance 
obtained with 

Step angle 
Max. working torque 
Holding torque 
Max. pull-in rate 
Max. pull-out rate 

APPLICATION 

990411'.: 3~-
I 9904 112 31106 
integrated circuit 
drive unit 
----
_J')AA !g_2_7 _________ -+-- 9904 131 03006 

70 30' 
70 30' 
30mNm 
42mNm 
245 steps/s 

33 mNm 
46 mNm 
450 steps/s 
620 steps/s 

These motors are designed for applications where very high torque and/or high speed are required 
but where space is limited. Constructed on the same frame as the 9904 112 31 .. 1 and 9904 112 31.. 4 
motors, they deliver 40% more torque thanks to a higher magnetic flux density. Typical application 
areas are: paper-feed in compact printers, sewing machines, medical equipment, robotics, automobile 
carburettor control, etc. 

TECHNICAL DATA 

Outlines 

8,2±0,5 
-.. 
r25max- 1--3±0,5 
.-IJ.-1 
__,.. -2.s 

0 3 -0,008 
-0,002 
•-+ 
010_8.05 == 
*-+-1-*
t run out 

0,07 max 

DD 
1 
t 051 
18,3 max 
• 

Fig. 1. 

*( *
··~h 1986 
*61 *


---

## Page 77

**9904 ****112 ****31006 **
**9904 ****112 ****31106 **

68 

catalogue number 

Power consumption of motor only 
Maximum working torque 
Holding torque 
Torque derating 
Maximum pull-in rate 
Maximum pull-out rate 
Resistance per phase at 20 oc 
Inductance per phase 
Current per phase 
Thermal resistance, coil-ambient 
Permissible ambient temperature range 
Permissible storage temperature range 
Permissible motor temperature 
Insulation resistance at 500 V (CEE 10) 
Step angle 
Step angle tolerance, not cumulative 
Number of steps per revolution 
Direction of rotation 
Rotor inertia 
Mass 
Maximum radial force 
Maximum axial force 
Bearings 

9904 112 31006 
9904 112 31106 

3,8 
3,5 
w 
30 
33 
mNm 
42 
46 
mNm 
-0,4 
-0,4 
%/K 
245 
450 
steps/s 
620 
steps/s 
65 
**11 **
CT 
100 
16 
mH 
175 
400 
mA 
13 
13 
K/W 
-20 to+ 70 
-20to+70 
oc 
-40to+100 
-40to+100 
oc 
120 
120 
oc 
>2 
>2 
MCT 
7° 30' 
7° 30' 
±25' 
± 25' 
48 
48 
reversible 
reversible 

170 
170 
g 
5 
5 
N 
1,5 
1,5 
N 
slide (bronze) 
slide (bronze) 

11 
11 
1 
gcm
2 

--------------------·------1----~-----~---------- ----

**Connections **

The connecting tags are marked as shown in Fig. 1 and are connected to the IC or drive unit as shown 
in the General Section on 4-phase unipolar stepping motors. 

50 
**7292584 **

**applied **

**torque **
(mNm) 
40 

30 

20 

10 
*j_ *
o[ 

0 
2,5 
7,5 
**deviation (degrees) **

Fig. 2 Applied torque versus deviation. 

J""""'Y 19841 


---

## Page 78

4-phase unipolar stepping motors 

Motor 9904 112 31006 with integrated circuit SAA1027 

40 

torque 
(mNm) 

30 

20 

10 

0 

10 
12,5 

t--.. 

30 
37,5 

!'::'.-, 

l.l_pull-in 

-1 

100 
125 

-! 

~ 

~ 

300 
375 

1000 
1250 

3000 
3750 

Fig. 3 Torque versus stepping rate measured at room temperature. 

Motor 9904112 31106 with drive unit 9904121 03006 

40 

torque 
(mNm) 

30 

20 

10 

0 

E.,---

10 
12,5 

1::- --

30 
37,5 

--
t--
~ 
s 

100 
125 

~ 
pull-in 
~pull-out 

~ 1 1 
l 

.i. 1 

300 
·375 

Li 

l 

is: 

1000 
1250 

3000 
3750 

9904 112 31006 
9904 112 31106 

7292572 

steps/s 
rev/min 

7Z92573 

steps/s 
rev/min 

Fig. 4 Torque versus stepping rate, measured at room temperature. 

January 1984 
69 


---

## Page 79

**9904 ****112 ****31006 **
**9904 ****112 ****31106 **

1,5 

**output **
**power **

IW) 

1,25 

0,75 

0,5 

0,25 

0 

10 
12,5 

l __ _ 

30 
37,5 

!&" 

lh 

*_L *
lL 
2 

*Jl *
I 
*L L *
*_LL *
*ft-*

100 
125 

-\Pull-in 

~ 

300 
375 

_:-... 

**pull-out **

1000 
1250 

3000 
3750 

7Z92574 

**steps/s **
**rev/min **

Fig. 5 Output power versus stepping rate, measured at room temperature. 
(type 9904 112 31106) 

70 
"'"" 19861 


---

## Page 80

-ID31BE _ _  
J **9904 ****112 ****31206 **

**2-PHASE BIPOLAR STEPPING MOTOR **

permanent magnet, special purpose, economy version 

**QUICK REFERENCE ****DATA **

Performance obtained with electronic drive unit 

Step angle 

Max. working torque 

Holding torque 

Max. pu II-in rate 

Max. pu II-out rate 

**APPLICATION **

9904 131 03007 

7° 30' 
45mNm 

55mNm 

620 steps/s 

6000 steps/ s 

This motor is for applications requiring fast acceleration and positioning. The high energy magnet in 
combination with a bipolar constant current drive offers a maximum torque and speed. The advantage 
of this type over a unipolar constant current driven motor is a lower temperature rise at the same power 
output. 

**TECHNICAL ****DATA **

**Outlines **

8,2±0,5 
.... 
r25max-1+-3±0,5 

--11-1 
.... +-2,5 

f1J 3-0,008 
-0,002 
L_~ 
llJ1o_g,05 == 

~~01]-
0,07 max 

1 
**t **051 
18,3 max 
• 

-+--'--+-~----~ 

1-10,s-

-1,s 

Fig. 1. 

*( *
Mon,h1"6 
**71 **


---

## Page 81

**9904 ****112 ****31206 **

**72 **

catalcigue number 

Power consumption of motor only 
Maximum working torque 
Holding torque 
Torque derating 
Maximum pull-in rate 
Maximum pull-out rate 
Resistance per phase at 20 oc 
Inductance per phase 
Current per phase 
Thermal resistance, coil-ambient 
Permissible ambient temperature range 
Permissible storage temperature range 
Permissible motor temperature 
Insulation resistance at 500 V (CEE 10) 
Step angle 
Step angle tolerance, non-cumulative 
Number of steps per revolution 
Direction of rotation 
Rotor inertia 
Mass 
Maximum radial force 
Maximum axial force • 
Bearings 

**Connections **

9904 112 31206 

3,5 
45 
55 
-0,4 
620 
6000 
7 
18 
500 

13 
-20 to +70 
-40 to+ 100 

120 
>2 
70 30' 
± 25' 
48 
reversible 
11 
170 
5 
1,5 
slide (bronze) 

w 
mNm 
mNm 
%/K 
steps/s 
steps/s 
n 
mH 
mA 
K/W 
oc 
oc 
oc 
Mn 

gcm 2 
g 
N 
N 

The connecting tags are marked as shown in Fig. 1 and are connected to the electronic drive unit 
9904 112 03007 as shown in the General Section on 2-phase bipolar stepping motors. 

**applied **

**torque **
lmNm) 

• Axial play:,,;;; 0,7 mm. 

••~h 19861 

100 
**7Z92585 **

80 

60 

40 

20 

01/1 

0 
2,5 
7,5 
**deviation ****(degrees) **

Fig. 2 Applied torque versus deviation. 


---

## Page 82

**2-phase ****bipolar ****stepping ****motor **

**Motor ****9904 ****112 ****31206 ****with drive unit ****9904 ****131 ****03007 **

60 

**torque **
(mNm) 

50 

40 

30 

20 

10 

0 

10 
12,5 

- ---

30 
37,5 

--,.,, ......, 
:s;__, 
:'I 

~ 

pull-I~ 

100 
125 

L\. 

_'-I 

300 
375 

b.. 

::s: 

l 

El ~ii-out 

:s._,_ 

1000 
1250 

**9904 ****112 ****31206 **

**7292575 **

~ 

~ 

~ 

~ 

3000 
3750 

**steps/s **

**rev/min **

Fig. 3 Torque versus stepping rate, measured at room temperature. 

**output **
**power **

(WI 

1,5t--~~1---+--<--+-+-...,_,-+-+~~-+~-+--+--+--+-+-+-++-~~~IT~-+---+_,.-+-++-+< 

*t *
*l *
lL 

2,5 l----+----+---+-+-+-+-++-l----+---+---+-17~1'.:'.<'-+++++-----+--+--+-<-+-+-+-H 

*v *

*.,,,::::::::;-*
pull-In 
ot=:k±±tlitt!::::=t=t:!tltJTII~=t=t:tttm 

10 
30 
100 
300 
1000 
12,5 
37,5 
125 
375 
1250 

3000 
3750 
**steps/s **
**rev/min **

Fig. 4 Output power versus stepping rate measured at room temperature. 
I *( *
J""""Y 1984 
73 


---

## Page 83


---

## Page 84

ID32-series 
J 9904 112 32001 

9904 112 32101 
- -

4-PHASE UNIPOLAR STEPPING MOTORS 

permanent magnet version 

QUICK REFERENCE DATA 

motor type 
9904 112 32001 
9904 112 32101 

performance 
integrated circuit 
drive unit 
obtained with 
SAA1027 
9904 131 03006 

Step angle 
7°30' 
7030· 
Max. working torque 
6mNm 
7,5mNm 
Holding torque 
10mNm 
10mNm 
Max. pull-in rate 
350 steps/s 
550 steps/s 
Max. pull-out rate 
-
850 steps/s 

APPLICATION 

Motor 9904 112 32001 is adapted for drive with IC SAA 1027 and is intended for those applications 
where system simplicity and economy are required. 

Motor 9904 112 32101 is adapted for drive unit 9904 131 03006 and is intended for those applications 
where variable speed in the pull-out range with higher torque are required. 

Main application areas of both versions include chart recorders pen drive, butterfly drive in film pro-
jectors, paper feed in small printers, etc. 

TECHNICAL DATA 

Outlines 

0 
a,a_1,5 .... 

Fig. 1 The leads are double insulated (AWG24). 

-


---

## Page 85

9904 112 32001 
9904 112 32101 

catalogue number 
9904112 32001 
9904 112 32101 

Power consumption of motor only 
2 
2 
w 
Maximum working torque 
6 
7,5 
mNm 
Holding torque 
10 
10 
mNm 
Torque derating 
-0,4 
-0,4 
%/K 
Maximum pull-in rate 
350 
550 
steps/s 
Maximum pull-out rate 
850 
steps/s 
Resistance per phase at 20 oc 
120 
21 
.Q 
Inductance per phase 
160 
30 
mH 
Current per phase 
100 
220 
mA 
Thermal resistance, coil-ambient 
25 
25 
K/W 
Permissible ambient temperature range 
-20 to+ 70 
-20 to+ 70 
oc 
Permissible storage temperature range 
-40 to+ 100 
-40 to+ 100 
oc 
Permissible motor temperature 
120 
120 
oc 
Insulation resistance at 500 V (CEE 10) 
>2 
>2 
M.Q 
Step angle 
70 30' 
7°30' 
Step angle tolerance, not cumulative 
±40' 
± 40' 
Number of steps per revolution 
48 
48 
Direction of rotation 
reversible 
reversible 
Rotor inertia 
2,6 
2,6 
gcm 2 

Mass 
80 
80 
g 
Maximum radial froce 
2,5 
2,5 
N 
Maximum axial force 
0,75 
0,75 
N 
Bearings 
slide (bronze) 
slide (bronze) 

Connections 

The connecting leads are colour-coded (see Fig. 1) and are connected to the IC or drive unit as shown 
in the General Section on 4-phase unipolar stepping motors. 

76 
November 1983 

applied 
torque 
(mNm) 

16f--+--+--+--+--+--+--+-+-+~4~f--+--+--I-~ 

0 lL1 

0 
2,5 
7,5 
deviation {degrees) 

Fig. 2 Applied torque versus deviation. 


---

## Page 86

4-phase unipolar stepping motors 
9904 112 32001 
9904 112 32101 

Motor 9904 112 32001 with integrated circuit SAA 1027 

lO .-----,--,..--,--,..-.-rrn---.---,.-,....,-,-,,..,,.---,..--.--,--r-'rZr82,2,.,a3 

torque 1---------1---+---+--+ H 
t---------+---+-----+--+--+--1--+-1-t-------1--------+--+----+-+--1--+-H 
(mNm) f-----l-----+-+---+--+--+-+++---+-----+-+-+--+--+--H-+---+-+-----+--+---+-+++-1 
--r-
7 ,5 r----t----r--+--t--+-H-1-t----+------t-f-1-+---rt-++-----r--+--+--r--1-+-+-H 

-+---t---t--t--t--H---------j --------
--~--+-+-+++------- ----+-----+---+--+--t-+-+--+ 

5 
~ 
i-------------- -
- ----+---+-+-++++--"----'\----t----+--+-+-+---1-+-1-t----- ---+-+-- ---r--+--r-H-l 

t-------+-+_-_--1+--
__ -1--+-_:f--++-++-+:----~~~-~------.:~---+f------+~---++--:-+f--+f--+H+-~-=-------1-t----::_:::_:::_::::_::: 

2,5 1----+---+----+--+---+--t-+-+--+---+4-+-f-1-+--+-+-+-+----+---+--+--+--+--+-++-I 
l\ 

-'1 

[\ 

__)J 
01------+---+----+-+--+--1--+-~---+----+---+~--+---+~----+---+--+---+--~~ 

10 
30 
100 
300 
1000 
3000 
steps/ s 
12,5 
37,5 
125 
375 
1250 
3750 
rev/min 

Fig. 3 Torque versus stepping rate measured at room temperature. 

Motor 9904 112 32101 with drive unit 9904 131 03006 

7282284.1 
10 .-----,--,..--,--,..--,---,,n----r---r-r--ir--r-r-r-rT---,..---,--.,.--.-r-rTTl 

t----------1---+--+-+--+--t--t--t-t--------+--------t-f-1--+--+--+--+-+---+---+-----+---+-t---t--t-+-t 

torque 
(mNm) t---------J--t----t~..+--H-H-~""'~----+---t--+---+-+-+--H--t---t-----+-----J---t-+-++~1 
... r- -I 

7,5 ~ 

.,,,,.~---

~ ~ull-out 

1---------+--+----+->--+-+-++t----+--------+----~--+--_,___,__b,J+-+-t-------- ------j -- ---

1_\f'U II -in 
\ 
>------+--- -1-----+-+--+--+-++>--------+--+--+---<t---+--t--+-lf+------+--->---+---+-+-+-t-+--t 
2,5 1------+---+---+--4--+-+-+-++---t----+--+---<>--+--+-+-+-+------+ ----+-----+----+--+--t--+--H 

f-------+----+---+--+--+--H-++----t--------+-----t---+illll-+--1---t--lH---- - -j--- -+-
t----------t---+----+--+--+--t--+--1-+----+-------t--1-1--+1--1---+--+>+-------- ---r-·-+---t---+---t--t--H 
f--- -f--t ---+--+---+--I-+-+-+-- ·--------+--1----t--t--'lf-H--Hll-t-----t---- -+----+--+-+--1--+-H 

0 t-----+---+----+-+---'-''-'-"'-'---~---+----+--+---U.-1--+-~--~---~--+--+--'-''-'-"~ 

1 0 
30 
1 00 
300 
1000 
3000 
steps *Is *
12,5 
37,5 
125 
375 
1250 
3750 
rev/min 

Fig. 4 Torque versus stepping rate, measured at room temperature. 

November 1983 
77 


---

## Page 87

9904 112 32001 
9904 112 32101 

o,4 ~------~~----~~~~-----1z_s_22_so~~ 
O,B 

pu 11- in i----+---t--l--+---+ -+-+-++-----+--+--+----+--+-+-1-+----+----+--+--+-+--l-_._._, pu 11-out 
(W) 
(W) 

0 ,3 i----+--t--~--+-++++---t---+---+--+-+-t-++f----+---1---1---4-+-++-H 0,6 

0 ,2 t----+---t--t--+--+-t-+++----+-7-+--f--1--\-\j'"-Ft-H-+---+-+--+--;-+-++-H 0,4 

r----------+----f---+--+---1-+-1-++-pu_ll_-i~r'_Lj<+---+---1LLJ,,_,_\ __ H-1-ll-----+--+--+--+--+~'-+-< 

*-i!-*
~ ~ 
lL 
*L *
0' 1 l-----+---+--_.__,--+--+-+!'1 ______ 
_/1_..,.~-i--..___.--+-..__._.._.,_ __ 
-i----+---+--+-+--1--1-1-< 0 ,2 

1-------t-~1---t---+-+y-JA---1-+---;z:__--/--+------+----+--+-+-l-+++l-~---+----+-+-+--H--1-H 

JL 
lJ1 pul I -out 

--
_.j.-
0 t:::;;;;;..,.d::::::::::L_LJ-L.LLl.L __ 
L__J__J__J_.Ll..llJIL_ _ 
_J__L_LJ_L.LLLlo 
10 
30 
100 
300 
1000 
3000 
steps/s 
12,5 
37,5 
125 
375 
1250 
3750 
rev/min 

Fig. 5 Output power versus stepping rate measured at room temperature. 
(type 9904 112 32101) 

78 
M'~ 


---

## Page 88

-ID32BE _ _  
J 9904 **112 **32204 

**2-PHASE BIPOLAR STEPPING MOTOR **

permanent magnet version, special purpose, economy version 

QUICK REFERENCE DATA 

Performance obtained with electronic drive unit 

Step angle 

Maximum working torque 

Holding torque 

Maximum pull-in rate 

Maximum pull-out rate 

APPLICATION 

9904 131 03007 

7° 30' 

8,5 mNm 

11,5mNm 

800 steps/s 

2500 steps/s 

This motor is for applications where a minimum of space is available but a fast acceleration and high 
torque are required. 

TECHNICAL DATA 

Outlines 

0 
8,8_15 

·1-21,5 max-+- -2,2 

02-0,002 
-0,008 
t 

run out 
0,03 max 

-2,7±0,5 

Fig. 1. 

3,2±0,1 
- -

--

(March 1986 
79 


---

## Page 89

**9904 ****112 ****32204 **

catalogue number 

Power consumption of motor only 
Maximum working torque 
Holding torque 
Torque derating 
Maximum pull-in rate 
Maximum pull-out rate 
Resistance per phase at 20 oc 
Inductance per phase 
Current per phase 
Thermal resistance, coil-ambient 
Permissible ambient temperature range 
Permissible storage temperature range 
Permissible motor temperature 
Insulation resistance at 500 V (CEE 10) 
Step angle 
Step angle tolerance, non-cumulative 
Number of steps per revolution 
Direction of rotation 
Rotor inertia 
Mass 
Maximum radial force 
Maximum axial force 
Bearings 

Connections 

9904 112 32204 

2 
8,5 
11,5 
-0,4 
800 
2500 
7,7 
16 
360 
25 
-20 to +70 
-40 to+ 100 

120 
>2 
7° 30' 
±40' 
48 
reversible 
2,6 
70 
2,5 
0,75 
slide (bronze) 

w 
mNm 
mNm 
%/K 
steps/s 
steps/s 
n 
mH 
mA 
K/W 
oc 
oc 
oc 
Mn 

gcm 2 

g 
N 
N 

The connecting tags are marked as shown in Fig. 1 and are connected to the electronic drive unit 
9904 112 03007 as shown in the General Section on 2-phase bipolar stepping motors. 

**applied **

**torque **
(mNm) 

80 
J'""'" 19841 

16f--+-+---+-+-+-4~+-+--+--+-+---+~f--+--I 

~ 
12<--+-+--1--+--+-+--l~i--c ..... q::_.-+--+--+___Jl----I 
*v *

4 
/ 
~ 

2,5 
7,5 
**deviation ****(degrees) **

Fig. 2 Applied torque versus deviation. 


---

## Page 90

2-phase bipolar stepping motor 

Motor 9904 112 32204 with drive unit 9904 131 03007 

torque 
(mNm) 

10 

7,5 

~ 
... E.- -

!""' 

t----------

2,5 

10 

12,5 

30 
37,5 

t- t-1-1 
1' N 

+--
~ 

1"1-.. 
~ 
\ 
pull-i~ 

~ 

~ 

100 

125 

~ 

300 
375 

~ 

~ 

~ \ 3 

pull-out 

1000 

1250 

ll 

l 
3000 
3750 

9904 112 32204 

7Z90592 

steps/s 

rev/min 

Fig. 3 Torque versus stepping rate, measured at room temperature. 

1,2 

output 
power 

IWI 

1,0 

0,8 

0,6 

0,4 

0,2 

o 

10 

12,5 

30 
37,5 

100 

125 

z 

fI_ 
rz 

*lL *

~ 
LI 
LI 

pull-in 

:--,J 

~ 

300 
375 

h.. 

*T-*
*± *
*L *
lL 

1000 

1250 

pull-out 

~ 

3000 
3750 

7290593 

+-+--

steps/s 
rev/min 

Fig. 4 Output power versus stepping rate measured at room temperature. 


---

## Page 91


---

## Page 92

ID33 E-series 
J 9904 112 33004 

9904 112 33104 
- -

4-PHASE UNIPOLAR STEPPING MOTORS 

permanent magnet version, economy version 

QUICK REFERENCE DATA 

motor type 
9904 112 33004 
9904 112 33104 

performance 
integrated circuit 
drive unit 
obtained with 
SAA1027 
9904 131 03006 

Step angle 
7° 30' 
7° 30' 
Max. working torque 
90mNm 
90mNm 
Holding torque 
130 mNm 
130 mNm 
Max. pull-in rate 
100 steps/s 
275 steps/s 
Max. pull-out rate 
-
275 steps/s 

APPLICATION 

The I D33 has been designed as an economical version of the I D27. The motors of this series have no 
shielding can, they have one long sintered iron bearing. The coils are bifilar wound and connected to 
six soldering tags which protrude sideways from the motor body (permitting automated production). 
These motors are for applications where high torque but no high radial and/or axial force is required. 
Examples of application are: X-Y plotters, paper feed in printers, industrial control. 

TECHNICAL DATA 

Outlines 

Note 

Fig. 1. 

j

~~ 
**069---------illo-•-20----**
1.-- 056±0.1 
. 1---4.5±0.2 

' 
27 
_i 

Special versions having a spindle with a diameter of 3 mm and a length of 8,2 ± 0,5 mm for use with a 
gearbox may be available upon request. 

(March 1986 

-

83 


---

## Page 93

**9904 ****112 ****33004 **
**9904 ****112 ****33104 **

catalogue number 
9904 112 33004 
9904 112 33104 

Power consumption of motor only 
7 
6 
w 
Maximum working torque 
90 
90 
mNm 
Holding torque 
130 
130 
mNm 
Torque derating 
-0,4 
-0,4 
%/K 
Maximum pull-in rate 
100 
275 
steps/s 
Maximum pull-out rate 
275 
steps/s 
Resistance per phase at 20 °c 
38,5 
7,8 
n 
Inductance per phase 
160 
35 
mH 
Current per phase 
300 
615 
mA 
Thermal resistance, coi I-ambient 
7 
7 
K/W 
Permissible ambient temperature range 
-20 to+ 70 
-20 to+ 70 
oc 
Permissible storage temperature range 
-40 to+ 100 
-40 to+ 100 
oc 
Permissible motor temperature 
120 
120 
oc 
Insulation resistance at 500 V (CEE 10) 
>2 
>2 
Mn 
Step angle 
7° 30' 
7° 30' 
Step angle tolerance, not cumulative 
± 15' 
± 15' 
Number of steps per revolution 
48 
48 
Direction of rotation 
reversible 
reversible 
Rotor inertia 
80 
80 
gcm 2 

Mass 
480 
480 
g 
Maximum radial force 
10 
10 
N 
Maximum axial force 
5 
5 
N 
Bearings 
one sintered iron 
one sintered iron 
slide 
slide 
**Connections **

The connecting tags are marked as shown in Fig. **1 **and are connected to the IC or drive unit as shown 
in the General Section on 4-phase unipolar stepping motors. 

200 
**applied **
**torque **
**(mNm) **

160 

120 

80 

40 
*v *
o~ 

0 
2,5 
7,5 

**deviation (degrees) **

Fig. 2 Applied torque versus deviation. 


---

## Page 94

4-phase unipolar stepping motors 

Motor 9904 112 33004 with integrated circuit SAA 1027 

100 

torque 
(mNm) IS 

75 

50 

25 

0 

10 
12,5 

~ 

~ 

~ 

30 
37,5 

]'... 

II.pull-in 

' ~ 

I 
100 
125 

300 
375 

1000 
1250 

9904 112 33004 
9904 112 33104 

7Z82778 

3000 
steps/ s 
3750 
rev /min 

Fig. 3 Torque versus stepping rate measured at room temperature. 

Motor 9904 112 33104 with drive unit 9904131 03006 

200 

torque 
(mNm) 

150 

100 

50 

!'"""--

0 

10 
12,5 

~ 
ii!.= 

30 
37,5 

..;;;~ 

1~ ~ pull-in 

~ 

100 
125 

::S.:IS:pull·out 
y 
~ 

-! .i 

300 
375 

1000 
1250 

7282777.1 

3000 
steps/ s 
3750 
rev /min 

-

Fig. 4 Torque versus stepping rate, measured at room temperature. 

*( *.,,,., 1984 
85 


---

## Page 95

**9904 ****112 ****33004 **
**9904 ****112 ****33104 **l _____ _ 

2 

output 
power 
(W) 

1,5 

0,5 
7,JZ 

*.I, *
:w 
7 
~ 

0 
10 
12,5 

30 
37,5 

*YI *

I *Jl'J *
~ 

cF\p 

~ 
*V' *

pull-in 

100 
125 

ull-out 

300 
375 

1000 
1250 

**7Z82784 **

3000 
steps/s 
3750 
rev *I *min 

Fig. 5 Output power versus stepping rate measured at room temperature. 
(type990411233104) 

.. 
··"" , ... I 


---

## Page 96

**-ID33 **_ _  
j **9904 ****112 ****33105 **

**4-PHASE UNIPOLAR STEPPING MOTORS **

permanent magnet version, special purpose 

**QUICK REFERENCE DATA **

performance obtained with 

Step angle 
Max. working torque 
Holding torque 
Max. pull-in rate 
Max. pull-out rate 

**DESCRIPTION **

electronic drive unit 9904 131 03006 

*1° *30' 
110 mNm 
150 mNm 
275 steps/s 
275 steps/s 

This motor is identical to type 9904 112 33104, however a more powerful magnet is used, enabling a 
higher torque output. 

**TECHNICAL DATA **
**Outlines **

11l12_g 05 
· 
-
*1 *
s1 
rtC:.,1.1 
~~:l:j-fi-

Fig. 1. 

·-------069-----1-20-

--

87 


---

## Page 97

**9904 ****112 ****33105 **l __ _ 

catalogue number 

Power consumption of. motor only 
Maximum working torque 
Holding torque 
Torque derating 
Maximum pull-in rate 
Maximum pull-out rate 
Resistance per phase at 20 oc 
Inductance per phase 
Current per phase 
Thermal resistance, coil-ambient 
Permissible ambient temperature range 
Permissible storage temperature range 
Permissible motor temperature 

Insulation resistance at 500 V (CEE 10) 
Step angle 
Step angle tolerance, not cumulative 
Number of steps per revolution 
Direction of rotation 
Rotor inertia 
Mass 
Maximum radial force 
Maximum axial force 
Bearings 

9904 112 33105 

6,5 

110 
150 
-0,4 
275 
275 
7,8 
35 
615 
7 
-20to +70 
-40to + 100 
120 
>2 
70 30' 
± 15' 
48 
reversible 
80 
450 

10 
5 
one sintered iron 
slide 
------------------------------------'----· 

Connections 

w 
mNm 
mNm 
%/K 
steps/s 
steps/s 
n 

mH 
mA 
K/W 
oc 
oc 
oc 

Mn 

gcm2 

g 
N 
N 

The 'connecting tags are marked as shown in Fig. 1 and are connected to the electronic drive unit 
9904131 03006 as shown in the General Section on 4-phase unipolar stepping motors. 

**applied **

**torque **
H 
(mNm) 
~ 
1eof-+-+-+--+--+--+-+-+-+--!-:;;;~F-+-+-~ 
~ 
*7 *
120f---l-+-+--l--+--+__,.<-+-+---4-f---I-+-+-~ 

~ 
SOf---l-+-+--l-A--+-+-+-+---4-f---I-+-+-~ 
*.Y *

2,5 
7,5 
deviation (degrees) 

Fig. 2 Applied torque versus deviation. 

.. 
J~~"' ·-1 


---

## Page 98

**4-phase ****unipolar stepping motors **

**Motor ****9904 ****112 ****33105 ****with drive unit ****9904 ****131 ****03006 **

200 

**torque **
(mNm) 

150 

**i---:::...;.; *****Q ***- I-

100 

50 

0 

10 
12,5 

. .., . ..., L-,1 
~ 

30 
37,5 

~ 
pull-i~pull-out 

100 
125 

~ 

~ \ **1 **

300 
375 

1000 
1250 

**9904 ****112 ****33105 **

**7Z69872 ****2 **

3000 
steps/ s 
3750 
rev/min 

Fig. 3 Torque versus stepping rate, measured at room temperature. 

**output **
**power **
(W) 

1,5 

0,5 

i....-

0 

10 
12,5 

*A *
*1 *
~ 
**JL **
**./I **

30 
37,5 

~ 

*-£-*
L ..... l 
it~-\ 

Ill 
17 

100 
125 

~ 

pull-in 
pull-out 

300 
375 

1000 
1250 

**7Z69870.1 **

3000 
steps/ s 
3750 
rev/min 

Fig. **4 **Output power versus stepping rate measured at room temperature. 

(January 1984 
89 


---

## Page 99


---

## Page 100

**-ID34E **_ _  
J **9904 **11~ **34004 **

**9904 ****112 ****34104 **

**4-PHASE UNIPOLAR STEPPING MOTORS **

permanent magnet version, economy version 

**QUICK REFERENCE ****DATA **

motor type 
9904 112 34004 
9904 112 34104 

performance 
integrated circuit 
drive unit 
obtained with 
SAA1027 
9904 131 03006 

Step angle 
15° 
15° 
Max. working torque 
55mNm 
60mNm 
Holding torque 
75 mNm 
80mNm 
Max. pull-in rate 
100 steps/s 
190 steps/s 
Max. pull-out rate 
-
240 steps/s 

**APPLICATION **

The I 034 has been designed as an economical version of the I 028. The motors of this series have no 
shielding can, they have one long sintered iron bearing. The coils are bifilar wound and connected to 
six soldering tags which protrude sideways from the motor body (permitting automated production). 
These motors are for applications where high torque and large step angle but no high radial and/or axial 
force are required. 

Examples of applications are: chart drive in X-Y plotters, paper feed in plotters, industrial control. 

**TECHNICAL DATA **
**Outlines **

Note 

,------069----~,...._20.___.__..., 

Fig. **1. **

Special versions having a spindle with a diameter of 3 mm and a length of 8,2 ± 0,5 mm for use with 
a gearbox may be available upon request. 

*( *
Moreh 1986 

-

**91 **


---

## Page 101

9904 112 34004 
9904 112 34104 

catalogue number 
9904 112 34004 
9904 112 34104 

Power consumption of motor only 
7 
6 
w 
Maximum working torque 
55 
60 
mNm 
Holding torque 
75 
80 
mNm 
Torque derating 
-0,4 
-0,4 
%/K 
Maximum pull-in rate 
100 
190 
steps/s 
Maximum pull-out rate 
240 
steps/s 
Resistance per phase at 20 oc 
38,5 
7,8 
n 
Inductance per phase 
110 
26 
mH 
Current per phase 
300 
615 
mA 
Thermal resistance, coil-ambient 
7 
7 
K/W 
Permissible ambient temperature range 
-20 to+ 70 
-20 to+ 70 
oc 
Permissible storage temperature range 
-40 to+ 100 
-40 to+ 100 
oc 
Permissible motor temperature 
120 
120 
oc 
Insulation resistance at 500 V (GEE 10) 
>2 
>2 
Mn 
Step angle 
15° 
150 
Step angle tolerance, not cumulative 
± 30' 
± 30' 
Number of steps per revolution 
24 
24 
Direction of rotation 
reversible 
reversible 
Rotor inertia 
80 
80 
gcm 2 

Mass 
480 
480 
g 
Maximum radial force 
10 
10 
N 
Maximum axial force 
5 
5 
N 
Bearings 
one sintered 
one sintered 
iron slide 
iron slide 

Connections 
The connecting tags are marked as shown in Fig. 1 and are connected to the IC or driver unit as shown 
in the General Section on 4-phase unipolar stepping motors. 

,-,-,-,-,---,---,--,-,-,-·-,-,--,_c.c' 
'r-=8277 0 1 
~ 

100 
applied 

torque 
{ml\lm) 

80 

60 

40 

20 

deviation {degrees) 

Fig. 2 Applied torque versus deviation. 

92 
November 19831 


---

## Page 102

4-phase unipolar stepping motors 
9904 112 34004 
9904 112 34104 

Motor 9904 112 34004 with integrated circuit SAA 1027 

100 

torque 
(mNm) 

75 

50 

~ 

""" 

7282776 

~pull-in 

'll 

IS r-, 

25 

0 

10 
25 

30 
75 
\ 
100 
250 

300 
750 

1000 
2500 

-H 

3000 
steps *Is *
7500 
rev/min 

Fig. 3 Torque versus stepping rate measured at room temperature. 

Motor 9904 112 34104 with drive unit 9904 131 03006 

t----+----+----+--t--+--H-r+----+--+-+-----t--t--+-+-++-----+----t----++-t-+-H 
torque 
1-----+---+----+--+--+-H-H----+-----+-~--+--+-+-++---+-----t--- t---i t--H 
(mNm) 1-------+---t--+--+--+-1-+-l-+---+-----+-t---i-++-+--++----+---t---+-+--H-++-i 

_, _ _,.::::'"""'i:-;--...._--+---+--+--+-H---H-----+- --+-~--+--+--+-++ ------+------j--- -+---+--+--t-t-r1 

751-------+~"'-..,P...+-t--+-1-+-H---+----+-t---i-++-+--++---+---+---+-+-+---+-H-1 

._ ...._ I' I 
--+--+---+---+-+--r-r---- ----
-
t--t--1- t-1 
-- -~ --+----+-'-l~l~b.J'I--+-+-+----+--
-
---+-+-+--+-+--H 
~ 
-·--·- -+----t---+-+---t--+--MH_,._--+--+---+---+---+-1-+-+-+----t-----+------t----+--+---t--t--H 
50 1-------+---t--+-+--+-H-~Hlo-j~--T-~p~ulTl-__ in--t-t---i-++-+--++---+--+---+-+-H-++-i 

--- -
+------+----+----+---+---+--t--t--+-~_,,,Y 
...... 
,----t-------+----+----+--+--+--+-r+--~--+----+-+-+-+-+-H-1 

- ---- -+---+--+-+--1----t-+-t-1---i--:I,.___i_,++---+---+---+---+-1-+-++-----+-- -+--+- -t---t-1 

------==-:==:=:~::::i;==__,_\'\--\::l\:-=':.=':::::-r+·+-----_--____,+---i----------1-+t--l--+t---+----+t--+-+-H 

251-------+---+----+--+--+-H-H------1.1++---\-+---'--'--+--+-+-++---+---+----+---+--+--+--+-H 
....lpull-out 
---+--t--t-++++----++\ *\V *
-
----+---+---+--+-+--4-1-1-+------+-~----t---+-+-++-+-+-----+----+----l-t--t--H -
r-----+--+--+--+--+--t+-t+---1\----+-+-+-+-++++----+---t---+--t--+-t-1-+; 
0 t--------+---+----+--+--+--+-~--~lt---~-+--+-~~-+-----t-----+-----+----+-+-~~ 

10 
25 

30 
75 

100 
250 

300 
750 

1000 
2500 

3000 
steps *Is *
7500 
rev/min 

Fig. 4 Torque versus stepping rate, measured at room temperature. 

(November 1983 
93 


---

## Page 103

**9904 ****112 ****34004 **
**9904 ****112 ****34104 **

output r-----r--r--r---1-+-Tt-tt----,..r--r--+--+-t-t--i-Hr----r--r---r---1-+--r-t-t1 

power 
*ZL *~ 
(W) 
_l_ 
JL 
1 
1,5 t----+--T---t--t-+-++-+,y-----+--+-+--+-+-+-+-+--1-+---+---+--+--+-+-+-+-+-1 

*17 *,_ 

pull-out 

*LY *
0,5t---~v..~~...,....--l--+-+-+-+++--~--+---lt--l-+~l-+++------+--+-+-+-+-+++-I 

*.fi *

0 '----+--'--"---'---'--'--'-.._._ __ 
,_.__.____.___.__._._..__._. __ 
_.__.__...._.__._~~ 
10 
25 

30 
75 

100 
250 

300 
750 

1000 
2500 

3000 
steps *Is *
7500 
rev *I *min 

Fig. 5 Output power versus stepping rate measured at room temperature, 
(type 9904 112 34101) 

94 
M•reh 19861 


---

## Page 104

ID35 E-series 
9904 112 35014 
9904 112 35114 

4-PHASE UNIPOLAR STEPPING MOTORS 

permanent magnet, economy version 

QUICK REFERENCE DATA 

motor type 

performance 
obtained with 

Step angle 

Max. working torque 

Holding torque 

Max. pull-in rate 

Max. pull-out rate 

TECHNICAL DATA 

Outlines 

-33,5max-

max 
I -
12 
... 
16 
-
±0,5 

9904 112 35014 

integrated circuit 
SAA1027 

7° 30' 

57 mNm 

85 mNm 

130 st/s 

9904 112 35114 

drive unit 
9904 131 03006 

7° 30' 

65 mNm 

85 mNm 

300 st/s 

350 st/s 

1--30,9-

6,2 

~-----~ 

1 1 
76,5 66 --(f)---

rr_~--'<--fH-,<-

_11_ 

4,4±0,2 
7Z8S232 

Fig. 1. 

(March 1986 
95 


---

## Page 105

**9904 ****112 ****35014 **
**9904 ****112 ****35114 **

catalogue number 

Power consumption of motor only 
Maximum working torque 
Holding torque 
Torque derati ng 
Maximum pull-in rate 
Maximum pull-out rate 
Resistance per phase at 20 oc 
Inductance per phase 
Current per phase 
Thermal resistance, coil-ambient 
Permissible ambient temp. range 
Permissible storage temp. range 
Permissible motor temperature 

Insulation resistance at 500 V (CEE10) 
Step angle 
Step angle tolerance, not cumulative 
Number of steps per revolution 
Direction of rotation 
Rotor inertia 
Mass 
Maximum radial force 
Maximum axial force 
Bearings 

9904112 35014 

5,3 
57 
85 
-0,4 

130 

47 
400 
240 
10 
-20to + 70 
-40 to+ 100 

120 
>2 
70 30' 
± 20' 
48 
reversible 

10 
1,5 
sintered bronze slide 

9904 112 35114 

5,3 
65 
85 
-0.4 
300 
350 
7,7 
65 
575 
10 
-20 to+ 70 
-40 to+ 100 

120 
>2 
*1° *30' 
± 20' 
48 
reversible 
45 
300 
10 
1,5 
sintered bronze slide 

w 
mNm 
mNm 
%/K 
steps/s 
steps/s 
n 
mH 
mA 
K/W 
oc 
oc 
oc 

Mn 

gcm2 
g 
N 
N 
_J
~go 

-~~~~~~--~~-
-~~~~-~~~--<-~~~~~~~~~~~~ 

**Connections **

The connecting tags are marked as shown in Fig. 1 and are connected to the IC or driver unit as shown 
in the General Section on 4-phase unipolar stepping motors. 

**applied **

**torque **
(mNm) 

96 
November 19831 

VI 
40--t-~];7-7'1----+---+--+--+--+--+--+---+---1---+------l---' 

20 
171 
*if-*

2,5 
7,5 
**deviation ****(degrees) **

Fig. 2 Applied torque versus deviation. 


---

## Page 106

**4-phase ****unipolar ****stepping ****motors **

**Motor ****9904112 ****35014 with integrated circuit SAA1027 **

100 

torque 
(mNm) 

75 

50 

25 

I--

0 

10 
12,5 

~ 

~ 

~ 

30 
37,5 

pull-in 

I'S 

IS: 

100 
125 

~ 

300 
375 

1000 
1250 

**9904 ****112 ****35014 **
**9904 ****112 ****35114 **

7ZB2780 

3000 
steps Is 
3750 
rev/min 

Fig. 3 Torque versus stepping rate, measured at room temperature. 

**Motor 9904 112 ****35114 ****with drive unit ****9904 ****131 03006. **

100 

torque 
(mNm) 

75 

50 

25 

~--

~--

0 

10 
12,5 

~ 

30 
37,5 

~ 
**!=::.f.... **

l"bJ b.. 

~pull-in 

:'S:~ 
\ 

ti._ 

-~pull-out 
~ ::w 

~ 
\ **:I **

~ 
100 
125 
300 
375 

1000 
1250 

7 Z82779.1 

3000 
steps/s 
3750 
rev/min 

Fig. 4 Torque versus stepping rate, measured at room temperature. 

(November 1983 
**97 **


---

## Page 107

**9904 ****112 ****35014 **
**9904 ****112 ****35114 **l __ _ 

output ~--1--+--~f-+++++---t----t--l--+-+-+++~---t--t--+-t--t-++-H 

power 
(W) 

1,5 ~--1--+--~f-+++++---t----t--+-+-+-+++~---t--t--+-t--t-++t-l 

***v *****l\ **

*1 *
*1-_ *
***V ***
'II 
pull-out 

0,5 1---+--t-+-+~:H-t-t+i--t-_i_\-+-tt-++-t+++---+--+-++++t-H 

*I *
pu11-;~ 

0 I--"'" 

10 
30 
12,5 
37,5 

100 
125 

300 
375 

1000 
1250 

3000 
steps/s 
3750 
rev/min 

Fig. 5 Output power versus stepping rate, measured at room temperature. 
(type 9904 112 35114) 

**98 **
March 19861 


---

## Page 108

ID35 E-series 
J 9904 112 35016 

9904 112 35116 
---

4-PHASE UNIPOLAR STEPPING MOTORS 

permanent magnet, special purpose, economy version 

QUICK REFERENCE DATA 

motor type 

performance 
obtained with 

9904 112 35016 
9904 112 35116 

integrated circuit 
drive unit 
SAA 1027 
9904 131 03006 
---- t--------------------+--- ------------
Step angle 

Max. working torque 

Holding torque 

1 
7° 30' 
70 30' 
I 
78 mNm 
80 mNm 

lj 
100 mNm 
100 mNm 

Max. pull-in rate 
130 st/s 
300 st/s 

Max. pull-out rat~-- ________ _l __________ --------------~---3_5_o_s_tl_s ___ _ 

DESCRIPTION 
These motors are similar to types 9904112 35014 and 9904 112 35114, however, with a more powerful 
magnet. 

TECHNICAL DATA 
Outlines 

-33,Smax-

-+ l+-3,Bmax 
... 
3 

" " 
1 
-'---'-'--=:::llL--1' 2'ifii3· 4'--
20 56,3 
;;;;. 
mrT 

16 I 
_.+OS+-
- . 

12 
max 

Fig. 1. 

1-30,s--

6,2 
.-------,., 

4,4±0,2 
7Z85232.1 

(May 1986 
99 


---

## Page 109

**9904 ****112 ****35016 **
**9904 ****112 ****35116 **

**100 **

catalogue number 

Power consumption of motor only 
Maximum working torque 
Holding torque 
Torque derating 
Maximum pull-in rate 
Maximum pull-out rate 
Resistance per phase at 20 oc 
Inductance per phase 
Current per phase 
Thermal resistance, coil-ambient 
Permissible ambient temp. range 
Permissible storage temp. range 
Permissible motor temperature 
Insulation resistance at 500 V (GEE 10) 
Step angle 
Step angle tolerance, not cumulative 
Number of steps per revolution 
Direction of rotation 
Rotor inertia 
Mass 
Maximum radial force 
Maximum axial force 
Bearings 

9904 112 35016 

5,3 
78 
100 
-0,4 
130 

47 
400 
240 
**11 **
-20 to+ 70 
-40to+100 

120 
>2 
7o 30' 
± 20' 
48 
reversible 
45 
300 

10 
1,5 
sintered bronze slide 

9904112 35116 

5,3 
w 
80 
mNm 
100 
mNm 
-0,4 
%/K 
300 
steps/s 
350 
steps/s 
7,7 
[1 
65 
mH 
575 
mA 
11 
K/W 
--20 to +70 
oc 
-40to+100 
oc 
120 
oc 
>2 
MQ. 
7° 30' 
± 20' 
48 
reversible 
45 
gcm 2 
300 
g 
10 
N 
1,5 
N 
sintered bronze slide 
------·- ·-··-------------'---------·------- -----~----------

Connections 

The connecting tags are marked as shown in Fig. **1 **and are connected to the IC or driver unit as shown in 
the General Section on 4-phase unipolar stepping motors. 

**applied **
**torque **
**{mNm) **

M'Y 19861 

200 

160 

120 

80 

40 

**7Z92582 **

f--t--t---+-+--+---1---1---1--1--+--+--t--- ·--t--1 

r-c--+--ct--t-·-+--+--+--+--jr-+--+--+--+---+--~ 
**-+-f-H **

o~ 

0 
2,5 
7,5 

**dev'iation ****( ****degrees) **

Fig. 2 Applied torque versus deviation. 


---

## Page 110

4-phase unipolar stepping motors 

Motor 9904 112 35016 with integrated circuit SAA 1027 

torque 
(mNrn) 

9904 112 35016 
9904 112 35116 

75t--~==t----+---l--t-++-t++~~-+~-+--+--+-+--+-++-~~-+-~+--+-+-f-+~ 

,___--i_,t:::,,.~.--""1----1-+-+-++++-~~+----l~+--e-+-+-+--++~---+-~+-+-+--->-+-•-U 

~ 

t------l-4-~-~-~~-~+-<---~~~-1--+-+-1-W~--'---'--l.-->.-.)_j_J...LI 

501---~~t----t----1---1Ll.--+-+-+-++~---+--+--+--+--+---+-++----+--+--+--+-......_..._.__, 

f-----1 --1----+--+-+J\,.l..,_..-++---+---+--+--+--+-+-+-H---+----+--+-+--H 
t-----t--+--+-+-+-+-\H+----t---+-+-+-+-+-+-++---+--+-e-.+-1--1 
t----f-.---t----l--t-+--+-+ ...... -~·-+---+--+--+-+-1-1--++----
+--+--~-~+-! 
t------t-----+--+-+--+--f-+-M-----+--+--+-+-•--+-+++-----1---t-+--f-->-+-W--l 

10 

12,5 

30 
37,5 

pull-in 

~ \ \ 
100 

125 

300 
375 

1000 
1250 

3000 
3750 

steps/s 
rev/min 

fig. 3 Torque versus stepping rate, measured at room temperature, 

Motor 9904112 35116 with drive unit 9904131 03006 

100 

torque 
(mNm) 

75 

50 

25 

0 

10 
12,5 

--- -- --

30 
37,5 

:--:.... 
', !'--... 

~ 
\ ~ 

100 

125 

pull-in 
pull-out 
\ 

~ 

~ ! 

\ 
300 
375 

1000 
1250 

3000 
3750 

7292566 

·~ 

H 

steps/s 

rev/min 

fig. 4 Torque versus stepping rate, measured at room temperature. 

(February 1984 
101 


---

## Page 111

**9904 ****112 ****35016 **
**9904 ****112 ****35116 **

**output **
**power **
(W) 

1,5 

0,5 

0 

10 
12,5 

I~ 
g 
-:: 

30 
37,5 

IJ. 

-I 
*7 *I! 
~ 
I 
*l *
~ 
\ 
*r7 *t 
IM 
} 

**pull-in **

100 
125 

~ i 
300 
375 

**pull-out **

1000 
1250 

3000 
3750 

**7292567 **

**steps/s **
**rev/min **

Fig. 5 Output power versus stepping rate, measured at room temperature. 
(type 9904 112 35116) 

**102 **
March 19861 


---

## Page 112

**ID35-BE **
J 
- -

**9904 ****112 ****35214 **

**2-PHASE BIPOLAR STEPPING MOTORS **

permanent magnet, economy version 

**QUICK REFERENCE ****DATA **

performance obtained with electronic drive unit 9904 131 03007 

Step angle 

Max. working torque 

Holding torque 

Max. pull-in rate 

Max. pull-out rate 

**APPLICATION **

7° 30' 

63 mNm 

90mNm 

400 st/s 

1300 st/s 

This motor is a bipolar version of type 9904 112 35014 with windings adapted for optimum performance 
when driven by unit 9904 131 03007, based on /Cs PBL3717. 

**TECHNICAL ****DATA **

**Outlines **

.--33,Smax-

• 1 
20 56,3 

~"·T 

Fig. 1. 

6,2 
1----30,9 --

1 

JI_ 

4,4±0,2 
7Z85998 

(March 1986 
**103 **


---

## Page 113

**9904 ****112 ****35214 **

catalogue number 

Power consumption of motor only 
Maximum working torque 
Holding torque 
Torque derating 
Maximum pull-in rate 
Maximum pull-out rate 
Resistance per phase at 20 oc 
Inductance per phase 
Current per phase 
Thermal resistance, coi I-ambient 
Permissible ambient temp. range 
Permissible storage temp. range 
Permissible motor temperature 
Insulation resistance at 500 V (CEE10) 
Step angle 
Step angle tolerance, not cumulative 
Number of steps per revolution 
Direction of rotation 
Rotor inertia 
Mass 
Maximum radial force 
Maximum axial force 
Bearings 

**Connections **

9904 112 35214 

5 
63 
90 
-0,4 
400 

1300 
8,5 

130 
500 

11 
-20 to +70 
-40 to+ 100 
120 
>2 
7° 30' 
± 25' 
48 
reversible 
45 
300 

10 
1,5 
sintered bronze slide 

The connecting tags are marked as shown in Fig. 1 and are connected to the electronic drive unit 
9904 131 03007 as shown in the General Section or 2-phase bipolar stepping motors. 

**applied **

**torque **
(mNm) 

104 
fob""V 19841 

1601--+-+--+--+--+--l·~+-+--l--+-+-+~l--+I--

1201--+--+--+--+--+--l~+-+--+--+-+-+~l--+I--
~ 

40 
V1 
*v *
olZ 

0 
2,5 
7,5 
**deviation ****(degrees) **

Fig. 2 Applied voltage versus deviation. 

w 
mNm 
mNm 
%/K 
steps/s 
steps/s 
n 
mH 
mA 
K/W 
oc 
oc 
oc 

Mn 

gcm 2 

g 
N 
N 


---

## Page 114

2-phase bipolar stepping motors 

Motor 9904 112 35214 with drive unit 9904 131 03007 

80 

torque 
(mNm) 

60 

40 

20 

0 

10 
12,5 

30 
37,5 

r-t-i 

+-' 

*1' *

100 
125 

b-. " [SJ 

]\,. 
~ 

1 

~ 
1 

1 
l 

300 
375 

l j_ 

~ 

[ 

~ 1 
l 

1000 
1250 

_l 

l 

3000 
3750 

9904 112 35214 

7Z92569 1 

steps/s 
rev/min 

-

Fig. 3 Torque versus stepping rate, measured at room temperature. 

output 
power 
(W) 

6 

4 

0 

10 
12,5 

30 
37,5 

c;;1 

*-± *
0-

100 
125 

~ 

[ 

*-r *

~ull·in 

300 
375 

~ 

1000 
1250 

pull-out 

3000 
3750 

7Z92568 1 

steps/s 
rev/min 

Fig. 4 Output power versus stepping rate, measured at room temperature. 

August 1984 
105 


---

## Page 115


---

## Page 116

**-ID35-BE **_ _  
J **9904 ****112 ****35216 **

**2-PHASE BIPOLAR STEPPING MOTORS **

permanent magnet, special purpose, economy version 

**QUICK REFERENCE DATA **

performance obtained with electronic drive unit 9904 131 03007 

Step angle 

Max. working torque 

Holding torque 

Max. pull-in rate 

Max. pull-out rate 

**APPLICATION **

70 30' 

95mNm 

125 mNm 

570 st/s 

1100 st/s 

This motor is for applications requiring high torque, fast acceleration and high output power in a 
minimum volume. 

**TECHNICAL DATA **

**Outlines **

0 
0 
12-o,oa 4-o,ooa-
**t **

-33,Smax-

-. 1 ... 3,Bmax 
... 
3 

1-30,9-

-~--------

1 
20 56,3 
max max 
tJ 

I --
12 -
max 
16 
... 

6,2 

±0,5 
4,4±0,2 
**7Z85998 **

Fig. 1. 

March 1986 
**107 **


---

## Page 117

**9904 ****112 ****35216 **

catalogue number 

Power consumption of motor only 
Maximum working torque 
Holding torque 
Torque derating 
Maximum pull-in rate 
Maximum pull-out rate 
Resistance per phase at 20 oc 
Inductance per phase 
Current per phase 
Thermal resistance, coil-ambient 
Permissible ambient temp. range 
Permissible storage temp. range 
Permissible motor temperature 
Insulation resistance at 500 V (CEE10) 
Step angle 
Step angle tolerance, not cumulative 
Number of steps per revolution 
Direction of rotation 
Rotor inertia 
Mass 
Maximum radial force 
Maximum axial force 
Searings 

9904 112 35216 

5 
95 
125 

-0,4 
570 
1100 
8,5 
130 
500 

11 
-20 to+ 70 
-40to+100 
120 
>2 
7° 30' 
± 20' 
48 
reversible 
45 
300 

10 
1,5 
sintered bronze slide 

w 
mNm 
mNm 
%/K 
steps/s 
steps/s 
n 
mH 
mA 
K/W 
oc 
oc 
oc 
MD 

gcm 2 

g 
N 
N 

-------------------~--------------'-----------------

Connections 

The connecting tags are marked as shown in Fig. 1 and are connected to the electronic drive unit 
9904 131 03007 as shown in the General Section on 2-phase bipolar stepping motors. 

**applied **

**torque **
(mNm) 

108 
February 1984 

160f--+---+--+---+-+-l-l---l-"-+-+--+--+----+-----i 

l---j---j---j---j-----j-----j----f--+-t--+---+-t~-9'.1---1=--j 

12 o f--+-+--+-+--+--+--+---+----+-.-il---1-=--iv______j_'---1---l 
*y *

40 
/I 
o~ 

*v *
---+--+-----+-+--+-----+ 
80f--t---t---+--+-+7"'1-+-+---t--l--+-+--!f-+----i 

)7kd 

0 
2,5 
1,5 
**deviation ****(degrees) **

Fig. 2 Applied torque versus deviation. 


---

## Page 118

**2-phase ****bipolar ****stepping ****motors **
**9904 ****112 ****35216 **

**Motor 9904 112 35216 with drive unit ****9904131 ****03007 **

**torque **
(mNm) 

1501----1---+--t--t-+++++---+-~-+--+-+-+-j-+-i+---+---I--+-+--!-+~ 

1----1---+--t--t-+-t-t++--·-+--+--+-+·-+-t-+-++----+--+-+-+-f-+++-1 

---
-
--.I::..!::_ 
--
100t--~~r--~"'""-=+=-~~:--j;;-j;;t:fl'~,~_-..:::rt---l--t--t--t--t-l-t-r+----t--t--+-+-t-t-t+i 

1----1--+----+--+--+-H-++--~....____. ___ -'F,,.,.o-+-+++++-----+---+-l---1-+--H-H 

~ 
1'-b.. 

J------1-~-i---r--+--r-t-rt-r-p-ul_l-_i~-t'...---r--r-r~JS-'l<:ctiC-----t--r---t---t-+-t--rti 
5o t-t------1---+-·----l-+t---··~=~=::~~:=====:~=~:~~~~:=~:~~~=~p=u=ll-=-o-u_t;~~~;~:~:~~::~ 

12,5 

100 
300 
37,5 
125 
375 

~ 

1000 
1250 

3000 
3750 

**steps/s **

**rev/min **

Fig. 3 Torque versus stepping rate, measured at room temperature. 

**output **
**power **

IWI 

7,5 t-----+--r-+--+-+-+-+-r+-----+--+--+-+-+---Hl71-l-kj+---+--+--+-<l-4-++H 

*v *
17 
**JZ **
**pull-out **

*L *
2,5 r---r--+-t--t-t-+++-r---,ILl"--+-r-t--+-+-t-+t---r----t---+--i-t-+-iH-i 

~pull-in 
*v *
ll 

O'--~~~r--_._._~~!::::i~P-1....1...u_~-'---'--'-J:~X.l...l-L....LI.JLL--~.l.-..J.-.l-.....1.~..J...J...J 

10 
30 
12,5 
37,5 

100 
125 

300 
375 

1000 
1250 

3000 
3750 

**steps/s **
**rev/min **

Fig. 4 Output power versus stepping rate, measured at room temperature. 

..,._ __ 

**August ****1984 **
**109 **


---

## Page 119


---

## Page 120

**ID36 **E-series 
J 
- -

**9904 ****112 ****36014 **
**9904 ****112 ****36114 **

**4-PHASE UNIPOLAR STEPPING MOTORS **

permanent magnet, economy versions 

**QUICK REFERENCE ****DATA **

motor type 

performance 
obtained with 

Step angle 

Max. working torque 

Holding torque 

Max. pull-in rate 

Max. pull-out rate 

**TECHNICAL ****DATA **

**Outlines **

-33,5max-1 
--,-1,5 

9904 112 36014 

integrated circuit 
SAA1027 

15° 

32 mNm 

60mNm 

110 st/s 
-

9904 112 36114 

drive unit 
9904 131 03006 

15° 

37 mNm 

60mNm 

200 st/s 

350 st/s 

1-30,9-

6,2 
_ 
_.. j-1•5 
-.. r-3,Bmax 

-
.-3 

~-----~A 

.....-a--20 
03.-----+--.I 1 
·-1'2!l]"4'--
20 56,3 
,, " mrT 

I -
12 -
max 
16 
-- ±0,5 --
4,4± 0,2 
7Z85232.1 

Fig. 1. 

March1986 
**111 **


---

## Page 121

catalogue number 

Power consumption of motor or>ly 
Maximum working torque 
Holding torque 
Torque derating 
Maximum pull-in rate 
Maximum pull-out rate 
Resistance per phase at 20 oc 
Inductance per phase 
Current per phase 
Thermal resistance, coil-ambient 
Permissible ambient temp. range 
Permissible storage temp. range 
Permissible motor temperature 
Insulation resistance at 500 V (CEE10) 
Step angle 
Step angle tolerance, not cumulative 
Number of steps per revolution 
Direction of rotation 
Rotor inertia 
Mass 
Maximum radial force 
Maximum axial force 
Bearings 

Connections 

9904 112 36014 

5,3 
32 
60 
-0,4 

110 

47 

170 
240 
10 
-20to + 70 
-40 to+ 100 
120 
>2 
150 
± 30' 
24 
reversible 
45 
300 
10 
1,5 

9904112 36114 

5,3 
37 
60 
-0,4 
200 
350 
7,7 
27 
575 
10 
-20 to+ 70 
-40to+100 

120 
>2 

15° 
± 30' 
48 
reversible 
45 
300 
10 
1,5 
sintered bronze slide 
sintered bronze slide 

w 
mNm 
mNm 
%/K 
steps/s 
steps/s 
n 

mH 
mA 
K/W 
oc 
oc 
oc 

Mn 

gcm2 
g 
N 
N 

The connecting tags are marked as shown in Fig. 1 and are connected to the IC or driver unit as shown 
in the General Section on 4-phase unipolar stepping motors. 

100 
**7282772 ****1 **

**applied **

**torque **
(mNm) 

80 

60 

40 

20 

0 le'. 

0 
10 
15 
**deviation ****(degrees ****l **

Fig. 2 Applied torque versus deviation. 

**112 **
November1983 


---

## Page 122

**4-phase ****unipolar ****stepping ****motors **

**Motor 9904 112 36014 with integrated circuit SAA1027 **

40 

torque 
(mNm) 

30 

20 

10 

0 

10 
25 

**:----.J **

~ 

~ 

30 
75 

~ 

!'.. 

~pull-in 

~ 
I 

100 
250 \ 

300 
750 

1000 
2500 

**9904 ****112 ****36014 **

**9904 ****112 ****36114 **

**7282774 **

3000 
steps/s 
7500 
rev/min 

Fig. 3 Torque versus stepping rate, measured at room temperature. 

**Motor ****9904112 ****36114 ****with drive unit ****9904131 ****03006 **

-·~~~ 
torque 1------+-+.......-""i..-..,F-..._f-+-
,~>-----+--+--+-+--+-+->-++---+--+--+-+-+-+-+-+-< 
(mNm) l----+-+-~~~~'i--:J-~'~l----+-+--+-+---+--+-H-l----+-+--+--+-++-1-H 
I' 

~k ~ 
30t--~-+--t--+-+-+-~1ttt-~_,.~.---t~-t-t--+-+-++t-t~~t---t--t-t---t-1H+1 

**t\_ **
~ 
::S: 
::S:pull-out 

201--~-+-~-+--+--+-f-+-~>--~:1,__Pu~ll--i-n~[---+--+--+-H-<-+---<----+---+--+-+-+-++< 

~ -\ 

10 

~ 

0 
I 
10 
30 
100 
300 
1000 
3000 
steps/s 
25 
75 
250 
750 
2500 
7500 
rev/min 

Fig. **4 **Torque versus stepping rate, measured at room temperature. 

November 1983 
113 


---

## Page 123

**9904 ****112 ****36014 **
**9904 ****112 ****36114 **l __ _ 

**114 **

2 

output 
**power **
(W) 

1,5 

0,5 

**i--**
0 

10 
25 

~ 
*w *
*v *
z 
*,# *
***..tflllF ***

30 
75 

*L' *
z 
*f *
*rt *
*l'. *
~~ 

ll 
pull-inI 

1 

100 
250 

I 

300 
750 

pull-out 

1000 
2500 

**7282781 **

3000 
steps/s 
7500 
rev/min 

Fig. 5 Output power versus stepping rate, measured at room temperature. 
(type 9904 112 36114) 

M•coh 19861 


---

## Page 124

DEVELOPMENT DATA 

This data sheet contains advance information and 

specifications are subject to change without notice. 
HR15 
9904 115 15101 

4-PHASE UNIPOLAR HYBRID STEPPING MOTOR 

QUICK REFERENCE DATA 

Performance obtained with unipolar drive unit 9904 131 03006 

Step angle 

Maximum working torque 

Holding torque 

Maximum pull-in rate 

Maximum pull-out rate 

APPLICATION 

• floppy disc head positioning 
• paper feed in mini printers and electronic typewriters 
• positioning in X-Y recorders 
• instrumentation: e.g. dosing pumps 
• automotive actuators, e.g. in carburettors 

DESCRIPTION 

1,8 degrees 

45 mNm 

55 mNm 
675 Hz 
750 Hz 

This hybrid stepping motor is equipped with unipolar ring coils and soft iron stator and rotor. A steel 
magnet is used in the rotor. 
Precision ball bearings are used, limiting the spindle wobble to max. 15 *µm. *

*( *
M•coh 1986 
115 


---

## Page 125

9904 115 15101 

TECHNICAL DATA 

Outlines 

022h8 
.el38,1+g,4 

,,,___0+4-,9-92 ___ 
g,-00-4-H >----+---~---1 

116 

A 

2,s--J l-
2 ± 0,1-.l .._16± , ___ 

Connecting leads 

1 
1', 2' 
2 
3 
'3', 4' 
4 

=yellow 
=red 
=grey 
=white/yellow 
=white/red 
=white/grey 

Fig. 1. 

43,85 
±0,05 

I 

13 

7Z95551 


---

## Page 126

**<t: **
**1-**
**<t: **
**Cl **
**1-**
**2 ****w **
**2 **
**0.. **
**0 **
**..J **
**w **> 
**w **
**Cl **

**4-phase unipolar hybrid stepping motor **
**9904 ****115 ****15101 **

Catalogue number 
9904 115 15101 
----------------------+---------- -~----------

Power supply (Vb) 
Power consumption of motor only 
Maximum working torque (10 Hz) 
Torque derating 
Holding torque 
Maximum pull-in rate (note 1) 
Maximum pull-out rate (note **1) **
Resistance per phase (at 20 *DC) *
Inductance per phase ( 1000 Hz) 
Current per phase 
Thermal resistance, coil-ambient 
Permissible ambient temperature range 
Permissible storage temperature range 
Permissible motor temperature 

Insulation 
Insulation resistance at 500 V d.c. 
Step angle 
Step angle tolerance (non cumulative) 
Number of steps per revolution 
Direction of rotation 
Rotor inertia 
Bearings 
Mass 
Maximum radial force 
Maximum axial force, continuously (note 2) 

Connections of the motor, see Fig. 2. 
The leads are double insulated, AWG24. 

DRIVE 

UNIT 

+5V 

c 

M 

ov 

5 
ov 

Ma2 

**10 ****Mal **

MOTOR COILS 

12 
3,6 
45 
0,4 
55 
675 
750 
75 
22 
160 
10 
-20 to+ 70 
-40 to+ 100 
130 
CEE 10, class 111 
:;;, 2 
1,8 
±5 
200 
reversible 
21 
ball 
200 
25 
10 

,------- ;::;:i 

I 

4 

L _____ _J 
**7293561.1 **

Fig. 2 Unipolar drive circuit 9904 131 03006, Vb~ 12 V. 

**Notes **

**1. **Measured using unipolar constant current drive unit 9904 131 03006. 
2. For pressing a pulley or pinion to the spindle. Spindle end must be supported. 

v 
w 
mNm 
%/K 
mNm 
Hz 
Hz 
[2 

mH 
mA 
K/W 
oc 
oc 
oc 

Mn 
degrees 
% 

gcm2 

g 
N 
N 

January 1986 
**117 **


---

## Page 127

**9904 ****115 ****15101 **

Motor 9904 11515101 with drive unit 9904131 03006 

100 

**torque **
(mNm) 

75 

50 

25 

0 

10 
30 

9 

t-.... 

100 

30 

"--:s: **pull ****·out **

~ 

300 

90 

1000 

300 

3000 

900 

**7Z94319 **

**steps/s **
**rev/min **

Fig. 3 Typical *curve *if the pull-out torque versus stepping rate measured at room temperature in the 
circuit of Fig. 2. 

**output **
**power **
(W) 

0,75 

0,5 

0,25 

~ 
0 

10 

i.-....-

30 

*i;;7 *
*-:z!-*

100 

30 

_,d 

300 

90 

~ 

1000 

300 

3000 

900 

**7Z94318 **

**steps/s **

**rev/min **

Fig. 4 Output power versus stepping rate, measured at room temperature. 

**118 **
January 1986 


---

## Page 128

**DEVELOPMENT ****DATA **

**This data sheet contains advance ****information ****and **

**specifications ****are ****subject ****to ****change ****without ****notice. **
**HR15 **
**9904 ****115 ****15201 **

**2-PHASE BIPOLAR HYBRID STEPPING ****MOTOR **

**QUICK REFERENCE ****DATA **

**Performance obtained with bipolar constant current drive unit ****9904 ****131 ****03007 **

Step angle 

Maximum working torque 

Holding torque 

Maximum pull-in rate 

Maximum pull-out rate 

**APPLICATION **

• floppy disc head positioning 
• winchester drive head positioning 
• paper feed in mini printers and electronic typewriters 
• electronic card readers 
• head positioning in X-Y recorders 
• instrumentation, e.g. dosing pumps 

• electronic domestic appliances, e.g. sewing machines 
• automotive actuator, e.g. in carburettors 

**DESCRIPTION **

1,8 degrees 

45 mNm 

60 mNm 

1000 Hz 

1500 Hz 

This hybrid stepping motor is equipped with bipolar ring coils and soft iron stator and rotor. A steel 
magnet is used in the rotor. 
Precision ball bearings are used, limiting the spindle wobble to max. 15 *µm. *

*( *
M•<oh 1986 
119 


---

## Page 129

**9904 ****115 ****15201 **l __ _ 

**TECHNICAL DATA **

Outlines 

Ill 4,992 - 8.004 

Connecting leads 

1 =blue 
1' =black 
2 =red 
2' =grey 

2,5-11-
2±0,1~ -10±1-

**120 **
January 1986 

Fig. 1. 

43,85 
±0,05 

l
-22max-

-
-3+0,02 
I 
**+0,1Q **

**7Z96332.2 **

13 
max 

-. 
10 
_j 


---

## Page 130

**2-phase bipolar hybrid stepping ****motor **
**9904 ****115 ****15201 **

Catalogue number 

Power supply (VMM) 
Power consumption of motor only 
Maximum working torque ( 10 Hz) 
Torque derating 
Holding torque 
Maximum pull-in rate (note 1) 
Maximum pull-out rate (note 1) 
Resistance per phase (at 20 OC) 
Inductance per phase ( 1000 Hz) 
Current ..,er phase 
Thermal resistance, coil-ambient 
Permissible ambient temperature range 
Permissible storage temperature range 
Permissible motor temperature 
Insulation 
Insulation resistance at 500 V d.c. 
Step angle 
Step angle tolerance (non-cumulative) 
Number of steps per revolution 
Direction of rotation 
Rotor inertia 
Bearings 
Mass 
Maximum radial force 
Maximum axial trace, continuously (note 2) 

Connections of the motor, see Fig. 2. 
The leads are double-insulated, AWG24. 

DRIVE 

UNIT 

1 

2 c 

3 M 

+5V 

OV 

5 
ov 

**6 ****+VMM **

Mal 
7 
*B *Mb1 

Ma2 

9904 115 15201 

40 
2,4 
50 
0, **1 **
60 

1000 
1500 
37 
21 

180 
10 
-20 to+ 60 
-40 to+ 100 

130 
CEE 10, class 111 
?2 

1,8 
±5 
200 
reversible 
21 
ball 
200 
25 
10 

MOTOR COILS 

**7 ****285945 ****.1 **

Fig. 2 Bipolar constant current drive circuit 9904 131 03007, VMM = 40 V. 

**Notes **

1. Measured using bipolar constant current drive unit 9904 131 03007. 
2. For pressing a pulley or pinion to the spindle. Spindle end must be supported. 

v 
w 
mNm 
%/K -
mNm 
Hz 
Hz 

.11 
mH 
mA 
K/W 
oc 
oc 
oc 

M.11 
degrees 
% 

gcm 2 

g 
N 
N 

(March 1986 
**121 **


---

## Page 131

**9904 ****115 ****15201 **l __ _ 

Motor 9904 115 15201 with drive unit 9904131 03007 

100 

**pull-out **

**torque **
(mNml 

75 

50 

25 

0 

10 

3 

30 
100 

30 

rs: 

300 

90 

~ 

bl 

!:'-,,, 

1000 

300 

3000 

900 

**7Z97273 **

**steps/s **
**rev/min **

Fig. 3 Typical curve of the pull-out torque versus stepping rate measured at room temperature in the 
circuit of Fig. 2. 

**output **
**power **

(WI 

1,5 

0,5 

0 

10 

3 

30 

9 

7 

100 

30 

*'I *
11' 
*v *
*v *
[71 
*7 *

300 

90 

*i *
*L *
*I-*

1000 

300 

3000 

900 

**7Z97274 **

**steps/s **
**rev/min **

Fig. 4 Output power versus stepping rate, measured at room temperature. 

~~~1-22~~~-J-a_n_u_a-ry~1-98-6-.~ 


---

## Page 132

DEVELOPMENT DATA 

This data sheet contains advance information and 
specifications are subject to change without notice. 
HR15 
9904 115 15401 

2-PHASE BIPOLAR HYBRID STEPPING MOTOR 

QUICK REFERENCE DATA 

Performance obtained with bipolar constant current drive unit 9904 131 03007 

Step angle 

Maximum working torque 

Holding torque 

Maximum pull-in rate 

Maximum pull-out rate 

APPLICATION 

• floppy disc head positioning 
• winchester drive head positioning 
• paper feed in mini printers and electronic typewriters 
• electronic card readers 
• head positioning in X-Y recorders 
• instrumentation, e.g. dosing pumps 
• electronic domestic appliances 

DESCRIPTION 

1,8 degrees 

45 mNm 

60 mNm 

1000 Hz 

1500 Hz 

This hybrid stepping motor is equipped with bipolar ring coils and soft iron stator and rotor. A steel 
magnet is used in the rotor. 
Precision ball bearings are used, limiting the spindle wobble to max. 15 *µm. *

(April 1986 
123 


---

## Page 133

**9904 ****115 ****15401 **

**TECHNICAL ****DATA **

**Outlines **

f/l22h8 

A 

25~1 l-
2+0;~1-16+1-
-
' 
-

Leads, AWG26. 

1 =blue 
1' =black 
2 =red 
2' =grey 

**124 **
April 19861 

Fig. 1. 

43,85 
± 0,05 

I 

Dimensions in mm 

**7Z95332 **.2 


---

## Page 134

<! 
f-
<l: 
Cl 
f-
2 
LIJ 
:iE 
0... 
0 
LIJ 
_J > 
LIJ 
Cl 

2-phase bipolar hybrid stepping motor 
9904 115 15401 

Catalogue number 

Power supply (VMMl 
Power consumption of motor only 
Maximum working torque ( 10 Hz) 
Holding torque 
Maximum pull in rate (note 1) 
Maximum pull-out rate (note 1) 
Resistance per phase (at 20 OC) 
Inductance per phase (1000 Hz) 
Current per phase 
Thermal resistance, coil-ambient 
Permissible ambient temperature range 
Permissible storage temperature range 
Permissible motor temperature 
Insulation 
I nsu lat ion resistance at 500 V d .c. 
Step angle 
Step angle tolerance (non-cumulative) 
Number of steps per revolution 
Direction of rotation 
Rotor inertia 
Bearings 
Mass 
Maximum radial force 
Maximum axial force, continuously (note 2) 

Connections of the motor, see Fig. 2. 
The leads are double-insulated, AWG24. 

2 c 

M 

+5V 

ov 

ov 
DRIVE 
5 

+VMM 
UNIT 

Ma1 

Mb1 

Ma2 

MOTOR COILS 
r;--- --, 

Mb2 
101--~~~-+~~~~ 
___ J 

9904 115 15401 

24 
2,45 
50 
60 

1000 
1500 
18 
9,5 
260 
10 
-20 to+ 60 
-40 to+ 100 
130 
CEE10, class Ill 
;?>2 

1,8 
±5 
200 
reversible 
21 
ball 
200 
25 

10 

7Z85945 .1 

Fig. 2 Bipolar constant current drive circuit 9904 131 03007, Vmm ~ 24 V. 

Notes 

1. Measured using bipolar constant current drive unit 9904 131 03007. 
2. For pressing a pulley or pinion to the spindle. Spindle end must be supported. 

(April 1986 

v 
w 
mNm 
mNm 
Hz 
Hz 
*,Q *
mH 
mA 
K/W 
oc 
oc 
oc 

M.Q 
degrees 
% 

gem' 

g 
N 
N 

125 


---

## Page 135

**9904 ****115 ****15401 **

Motor 9904 115 15401 with drive unit 9904 131 03007 

100 

**pull-out **

**torque **
(mNm) 

75 

50 

25 

0 

10 
30 
100 

30 

,......., 

300 

90 

"' 

["-.._ 

~ 
I l 

1000 

300 

-1 1 

3000 

900 

*1Z94625 *

**steps/s **
**rev/min **

Fig. 3 Typical curve of the pull-out torque versus stepping rate measured at room temperature in the 
circuit of Fig. 2. 

**output **
**power **
(W) 

1,5 

0,5 

0 

10 

3 

--+-

30 

9 

H-1 

IT 
Ill 
*L *

CZ 
~ 
./ 

100 

30 

300 

90 

../J 

~ 

1000 

300 

_l 

1 

3000 

900 

*1Z94626 *

**steps/s **
**rev/min **

Fig. 4 Output power versus stepping rate, measured at room temperature. 

~--1-26 
________ 
A_p_r_il-19_8_6-~ 


---

## Page 136

**HR23 **
**9904 ****115 ****23 ****... **

**4-PHASE UNIPOLAR HYBRID STEPPING MOTOR **

**QUICK REFERENCE DATA **

Performance obtained with unipolar constant current drive 

Step angle 

Maximum working torque 

Holding torque 

Maximum pull-in rate 

unipolar 

9904 131 03006 

1,8 

340 

450 

300 

bipolar 

03007 

1,8 

320 

450 

600 

degrees 

mNm 

mNm 

steps/s 

Maximum pull-out rate (with damped rotor) 
400(4000) 850( 7000)steps/s 

**APPLICATION **

These motors are for applications which require high resolution, such as: 

• paper feed and positioning in electronic data processing equipment, X-Y recorders and facsimile 

• Winchester drive head positioning 

• medical equipment, e.g. infusion pumps. 

**DESCRIPTION **

The four sintered iron stator cups and the four soft iron rotor discs have 50 teeth. The bifilar wound 
ring coils are designed for a supply of 5 V and 1 A per phase. Connecting leads are soldered to the coils 
and relieved from strain. 

Precision ball bearings are used, permitting a maximum wobble of the spindle of 20 *µm. *

There are versions with single spindle (see Fig. 1) and with double spindle (see Fig. 2). 

(May 1986 
127 


---

## Page 137

**9904 ****115 ****23 ****... **

-

**TECHNICAL ****DATA **

Outlines 
*a. *versions with 2 x 3 leads 

52,5max 

J,, 

yell~~~ 
k~:~ow 
grey-ff\ *I *f':grey 

3 3' 4' 4 1 1' 2' 
2 

Fig. 1. 

*b. *versions with 2 x 4 leads. 

yellow~ ~yellow 
blue 
blue 
red 
. 
red 
grey 
grey 

3 3' 4' 4 1 1' 2' 2 

Fig. 2. 

**128 **
April 19861 

R4 
(4x) 

047+02-
~

.__D 57,2 max-

!r=±0,2~4~) I 

R4 
(4x) 

·-·m--·-· 
. +. 
.·•· 
·•·. 

6,5 
max 
. . 
. 
"-$: 

t 

**7Z85377.1 **

-047+02-
~

.__D57,2max-

I 
5±0.2~4~) 
I 
m 

"• 
: 
' 

.·• 
·. 
. 
. 
--$: 

6,5 
max 

t 

**7Z8599Z.1 **


---

## Page 138

4-phase unipolar hybrid stepping motor 
**9904 ****115 **23 ... 

catalogue number 
9904 115 23 ... followed by: 

spindle 
~i::IJ--~~~~~ --:~~ble 
leads 
2 x 3 
2 x 4 
2 x 3 
------------ -·--·· -------1----
--- ----'-------~ 

112 

double 
2x4 

Drive 
unipolar 
bipolar 

Drive unit 

Power supply 

Rv 

Power consumption of motor only 

Maximum working torque 

Torque derating 

Holding torque 

Maximum pull-in rate 

Maximum pull-out rate 

Resistance per phase (at 20 OC) 

Inductance per phase 

Current per phase 

Thermal resistance, coil - ambient 

Permissible ambient temperature range 

Permissible storage temperature range 

Permissible motor temperature 

Insulation 

Insulation resistance at 500 *V *d.c. 

Step angle 

Step angle tolerance (non-cumulative) 

Number of steps per resolution 

Direction of rotation 

Rotor inertia 

Bearings 

Mass 

Maximum radial force 

Maximum axial force 

continuously 
once, for pressing a pulley or pinion 
without support of spindle 

9904 131 03006* 
9904 131 03007** 

12 
40 

3,9 
-

8 
4 

340 
320 

0,4 
0,2 

450 

300 

I 

600 

400(4000) 
850(7000) 

4 

5 

1000 
I 

500 

-20to + 50 

-40 to+ 100 

130 

GEE, class Ill 

>2 

1,8 
±5 

200 

reversible 

145 

ball 

600 

50 

20 

100 

*v *
n 
w 

mNrn 

%/K 

mNrn 
Hz 
Hz 
n 

mH 

mA 

K/W 
oc 
oc 
oc 

MS1 

degree 

% 

gcm 2 

g 

N 

N 

N 

Unipolar drive is permissible for all versions. The drive circuit must be modified for 1 A (sample 
type number 8204 045 20055). 
Bipolar drive is only possible for versions 9904 115 23102 and 9904 115 23112 which have 
eight leads. The coils have to be connected in series, see Fig. 9. 

*(May *1986 
**129 **


---

## Page 139

**9904 ****115 ****23 ****... **

**130 **

**Motor ****9904115 **23 ... **with ****drive ****unit 9904131 03006 ****in ****unipolar operation **

400 

**pull-out **

**torque **
**(mNm) **

300 

200 

100 

**f--**

!----

[----

r---· 

0 

10 

~ 

30 

~ 

~ 
:s.: 

100 

30 

·--\--· 

. 

~ 

300 

90 

l'. 

\ 

1'i 

**with damped rotor **
', 

1000 

300 

..... 

'-i \. 

3000 

900 

Fig. 3 Torque versus stepping rate, measured at room temperature. 

**output **
**power **

(WI 

***7Z94705 ***

**steps/s **
**rev/min **

7,St--~~+-~1--+-+-t-t-H-J--~~-J--~+--t--t-+-t-t-t+~~-+~-t--+-+-t-++-H 

Fig. 4 Output power versus stepping rate, measured at room temperature. 

May 19861 


---

## Page 140

4-phase unipolar hybrid stepping motor 
9904 115 23 ... 

Motor 9904115 23 ... with drive unit 9904131 03007 in bipolar operation 

pull-out 

torque 
(mNm) 

300>--~-+~-+--+--+-+-+-+-++-~--<~-+--0.l'SJ-+--+-<-H-+-~~+---+--+-+-+-+-+-+-< 

output 
power 

IW) 

DJ 

\with damped rotor 
\ 

0'--~.__..._..__._...1-1...1...J...L.~--'---'--'--'-.l-.l-l..u...,_~-'--'--'-~~~ 

10 

3 

30 
100 

30 

300 

90 

1000 

300 

3000 
steps/s 
900 
rev/min 

Fig. 5 Torque versus stepping rate, measured at room temperature. 

10 

3 

30 
100 

30 

pull-out 

300 

90 

1000 

300 

with damped rotor 

3000 

900 

steps/s 

rev/min 

Fig. 6 Output power versus stepping rate, measured at room temperature. 

*( *"'' 1986 

131 


---

## Page 141

9904 115 23 ... 

132 

Motors with 6 leads and electronic drive unit 9904 131 03006 in unipolar operation 

Fig. 7. 

c 

M 

+5V 

MOTOR COILS 
,-----------

] 4 
3' 4' 

1'2' 

L._ _________ __J 

*1Z97531 *

• Motors with 8 leads and electronic drive 9904 131 03006 in unipolar operation 

Fig. 8. 

DRIVE 

UNIT 

c 

M 

+5V 

10 Mal 

MOTOR COILS 
,----------......., 

I 
4'' 

3' 

L_ _________ _J 

*7297532 *

• Motors with 8 leads and electronic drive unit 9904 131 03007 in bipolar operation 

Fig. 9. 

DRIVE 
5 

UNIT 

c 

M 

+5V 

ov 
ov 

Ma2 

lO 
Mb2 

M_, 19861 

MOTOR COILS 
~---------0 

L _________ ___i 

*7297533 *


---

## Page 142

ASSOCIATED ELECTRONICS 


---

## Page 143


---

## Page 144

**SAA1027 **

**INTEGRATED CIRCUIT **

for driving 4-phase unipolar stepping motors 

**APPLICATION **

The SAA 1027 transforms an input pulse sequence into a suitable form for driving the following motors: 

-
9904 112 06001 (ID 06-series) 
9904 112 32001 (ID 32-series) 
-- 9904 112 27001 (ID 27-series) 
9904 112 33004 (ID 33-series) 
- 9904 112 28001 (ID 28-series) 
9904 112 34004 (ID 34-series) 
-
9904 112 31001 (ID 31-series) 
9904 112 35014 (ID 35-series) 
-
9904 112 31004 (ID 31-series) 
9904 112 35016 (ID 35-series) 
-
9904 112 31006 (ID 31-series) 
9904 112 36014 (ID 36-series) 

For detailed information on the SAA 1027 see Data Handbook "Linear LSI, Supplement to IC11 N" 

**DESCRIPTION **

The circuit comprises three input stages, a logic stage and four output stages. 
The inputs are: 
• C - a count input that receives the order for the rotor to step 
• M - a mode input that determines the direction of rotation by setting the output pulse sequence 
• R -- a reset input that can be used to set the logic counter to "zero" before the trigger pulses are 

applied. 

All three inputs are compatible with high noise immunity logic to ensure proper operation, even in noisy 
environments. 

The four output stages can each supply 350 mA. Integrated diodes protect the outputs against transient 
spikes caused by switching the motor coils. 

**MECHANICAL DATA **

The package outline is 16-lead dual in-line; plastic (SOT-38A). 

(March 1986 
**135 **


---

## Page 145

**SAA1027 **

-

SOLDERING 

**1. **By hand 

Apply the soldering iron below the seating plane (or not more than 2 mm above it) 
If its temperature is below 300 oc it must not be in contact for more than 10 seconds; if between 
300 oc and 400 oc, for not more than 5 seconds. 

2. By dip or wave 

The maximum permissible temperature of the solder is 260 °C; solder at this temperature must not be 
be in contact with the joint for more than 5 seconds. The total contact time of successive solder 
waves must not exceed 5 seconds. 
The device may be mounted up to the seating plane, but the temperature of the plastic body must 
not exceed the specified storage maximum. If the printed-circuit board has been pre-heated, forced 
cooling may be necessary immediately after soldering to keep the temperature within the permissible 

limit. 

3. Repairing soldered joints 

The same precautions and limits apply as in (1) above. 

CONNECTIONS 

motor 

9904 112 06001 
9904 112 27001 
9904 112 28001 
9904 112 31001 
9904 112 31004 
9904 112 31006 
9904 112 32001 
9904 112 33004 
9904 112 34004 
9904 112 35014 
9904 112 35016 
9904 112 36014 

15 c 

3 M 

100 
n 

13 
STEPPING MOTOR 

RX 
VCC2 
l-----, 

1 
,.1 
Mal ~---L!___ryy--n__!__:_~ 

SAA1027 

Ma2 '-"s~l'--'2'-.rvv-~ ,2_·' --" 

Ma 3 ~9----11-o'--JYyy,~3_;_' I ~ 

Ma 4 ,_,_11'-'l._,4.__,-YY'"---"4_1_' _
1 
l ____ J 

12 

Fig. 1. 

180 n, o,67 w 
150 n, 1, 15 w 
150 n, 1, 15 w 
180 n, o,67 w 
180 n, o,67 w 
180 n, o,67 w 
*210 *n, o,33 w 
150 n, o,67 w 
150 n, o,67 w 
1so n, o,67 w 
180 n, o,67 w 
180 n, o,67 w 

**7287071.1 **

I system ( 12 V) 

500mA 
600mA 
600mA 
400mA 
400mA 
400mA 
300mA 
600mA 
600mA 
600mA 
600mA 
600 mA 

136 
March 19861 


---

## Page 146

Integrated circuit for driving 4-phase unipolar stepping motors 
SAA1027 

ELECTRICAL DATA 

Input data 

Direction of rotation (pin 3, mode input M) 
max. 
18 v 

VI H· HIGH (counter-clockwise) 
min. 
7,5 v 

VIL• LOW (clockwise) 
max. 
4,5 v 

l1H at V1H 
typ. 
1 µA 

-l1LatV1L 
typ. 
30 µA 

Stepping (pin 15, count input C) 
max. 
18 v 

VIH· HIGH 
min. 
7,5 v 

VIL• LOW 
max. 
4,5 v 

l1H at V1H 
typ. 
1 µA 

-l1LatV1L 
typ. 
30 µA 

Triggering occurs when C goes from LOW to HIGH. 

Set control (pin 2, reset input R) 
max. 
18 v 

VIH• HIGH 
min. 
7,5 v 

VIL· LOW 
max. 
4,5 v 

l1H at V1H 
typ. 
1 µA 

-l1LatV1L 
typ. 
30 µA 

Note: When C is HIGH and R is LOW the outputs are: 01 =LOW, 0 2 =HIGH, 03 =LOW, 04 =HIGH. 

Remarks 

Four integrated diodes dissipate the energy stored in the motor coils when the outputs Qare being 
switched. 

• The common line of these clamping diodes (pin 13) must therefore have the shortest possible 

connection to the common line of the motor windings. Due to higher dissipation the temperature 
rise of the IC increases with the stepping rate of the motor. This reduces the maximum permissible 
ambient temperature in which the IC can operate. To counteract this, external diodes, such as BAX 12, 
across the motor windings are recommended (see Fig. 3). 

• If the R input is not used it should be connected to the supply. 

• When both the IC and the motor are connected to the same supply, a simple RC network (see Figs 
2 and 3) must be used in the logic supply line to prevent the logic sequence from being disturbed by 
transient spikes caused by the motor coils being switched. The Rs value varies per motor type. The 
capacitor should be connected as close as possible to pin 14. 

*( *
Mo~h 1984 
137 


---

## Page 147

**138 **

SAA1027 J 

100 
Rs 
n 

13 
RX 
Vcc2 
15 c 
Ma1 

3 M 
Ma2 
SAA 1027 

Ma3 

2 R 
Ma4 11 

VEE1 
VEE2 
5 
12 

Fig. 2. 

Maximum permissible ambient operating temperatures (in °C) 

motor 
without external diodes* 

9904 112 06001 
65 
9904 112 27001 
55 
9904 112 28001 
65 
9904112 31001 
70 
9904 112 31004 
70 
9904 112 31006 
70 
9904 112 32001 
80 
9904 112 33004 
55 
9904 112 34004 
65 
990411235014 
65 
9904 112 35016 
65 
9904 112 36014 
70 

Minimum permissible ambient operating temperature: -'20 °c. 

Max. storage temperature: + 125 oc 
Min. storage temperature: -40 °c. 

* 13 is connected to + 12 V. 

M'~h 19861 

STEPP I NG MOTOR 
r-----, 

1 
1·1 

L ____ J 

**7Z73267.2 **

**+12V **
**(lsystem) **

with external diodes 

80 

70 
70 
90 
90 
90 
90 
70 
70 
70 
70 
90 


---

## Page 148

ELECTRONIC DRIVE UNIT 

4-phase unipolar 

DESCRIPTION 

The unit has been designed as a 4-phase motor drive that needs a clock or microprocessor pulse to 
determining the stepping rate. N74LS74N and N74LS86N provide the logic translator function. 

The supply voltage is 5 V; the drive voltage for the motor coils can be chosen in such a way that 1 
maximum output of the stepping motor is obtained. 

The unit is fitted with connection tags that allow the alternative of direct soldered connections instead 
of the connector with which it is supplied. 

TECHNICAL DATA 

Mass 
30g 

Ambient temperature range 

operating 
0 to + 70 oc 
storage 
-40 to + 70 oc 

Power supply 

vb 

lb max (at 5 V) 

5V ±5% 

45mA 

Direction of rotation (Vml 

Vm = '1' (CW) 
Vb;;;. Vm >2,0 V 

Vm = ·o· (CCW) 
o v ..;;vm <0,8 v 

Im max (Vm = '1') 
-Im max (Vm = 'O') 
-Im limiting value 

0,2mA 

0,8 mA 

30mA 

Vm limiting value 
7 V 

The inputs are: 

Switching pulses (V cl 

Ve= '1' 

Ve= 'O' 

le max (Ve= '1') 
-le max (Ve= 'O') 
-le limiting value 

Pulse frequency 

Min. pulse width 

Ve limiting value 

Output 

vb;;;. Ve> 2,0 v 
av ..;;vc <0,8 v 

0,2mA 

0,8mA 

30mA 

25 kHz 

100 ns 
7V 

Permissible voltage, at each output 

Permissible current, per output 

Saturation voltage 

100V 

600mA 
<1,3V 

• C - a count input that receives the order for the rotor to step 
• M - a mode input that determines the direction of rotation by setting the output pulse sequence 

*( *
"""' 1986 
139 


---

## Page 149

**Main ****dimensions **

_______ 68,6±0,5 ______ _.. 

(27e) 

>-++-1-1-+-+-<1>1--u 1-l<ll-+-+-1--+--<1.i-1u 2-kl>-+:r+lr+-+='+-+-1-+-+--< 

L.f.!.. 

D1 
D2 
DJ( 
D4j 
t 
76,2 
'-+-C~--1-l~~"--h.l.b--rT+-="'-'-1-'--'~"-hld:-T--1--+-+-+-'-'---'-'----' 2 ,54 
±0,5 
1 Al 
lITR2 
1 RJ 
1 ~R4 
t !1el 
!30el ~ 
J I 
J[ 
J t 
JI 

~ 
TR1 ~ 
}2 ~}JHP-+-1R~kll~H--+-+--+-.,--l-+-l---l 

A-B 

I 
10 
ll:I!=Ff 
1 
t 
1~ 
IT~ 11 
ITI 
t 
3,a+o.1 
~ l rr 
rm 11 
rr rr 
3,6 
t 
U'U-W-i:\::':l:::'t=!'=!:=~t=t=t:':i':tt::'j:':t:'::tl-+-+-ii-~j:::f----.t ± o, 1 
(4xl 

10 a a 
*1 *
e 
5 
4 
a 
2 
1 
lro 1ru1111i; 1111 *lI *

i._ 11,4._i 
35,6±0,1 
. 
I 
±0,2 
(9x3,96) 
**7285981. **

Fig. 1 Board thickness: 1,6 mm; Cu thickness: 35 *µm; *tracks covered with solderresist, class 1. 

140 
Moreh 1986 I 


---

## Page 150

s: I 
~ 
("") 
::r 

~ 
*'° *
00 
"' 

~ 
**:e: **

**CIRCUIT ****DIAGRAM **

(parts list next page) 
Ma4 
Ma3 
D 

6 
. :::.,. 
"f "f ctF · 

+ 

R4 

M~ 

D4 
---
---
+ 
~ 
PR 

Q 15 

+ 
! 

121 D 
PR 

Q 

Ul 

slCK 
Q 
, ,I 

Ul 

CK 
Q 

CLR 
**1 **

+ 

CLR 
~ 

T~ '11' 
+ 
c 

Fig. 2 For connecting diagrams see General section, Stepping motors. 

**t **

Ma2 
Mal 

'10 

**7285984.1 **

**m **
~ 
.... **a **
"' 
c:;· 

~ 

~· 

**t: **
"' 
*.. **;::;: *

-!'" 
**"C **
**::r **
O> 
~ 
**t: **
=· 
**"C **
**0 **
~ 

**co **
**co **
**0 **
+:>. 
....... ***w ***
....... 

**0 *****w ***
**0 **
**0 **
**(j) **


---

## Page 151

**9904 ****131 ****03006 **

**Parts ****list ****to ****Fig. 2 **

component 
description 
value 

R1 ·- R5 
metal film resistor, SFR25 
1 kn 

C1 
capacitor 
1nF,100V 

C2 
electrolytic capacitor 
100 µF, 10 V 

C3 
capacitor 

I 

100 nF 

TR1 -TR4 
transistor 
BOX44 

01 -04 
diode 
BAW62 
05-08 
diode 
BAX12 

Zl 
voltage regulator diode 
BZX87-C75 

Z2 
voltage regulator diode 
BZX79-C5V6 

Ul 
integrated circuit 
N74LS74N 

U2 
integrated circuit 
N74LS86N 

**CONNECTING DIAGRAM **

+5V 

-

DRIVE 

UNIT 
6 

**142 **
March 1986 

Cv 

+ 

MOTOR COILS 
,-------~ 

I 

4 

I 
L _____ _J 

Fig. 3. 

tolerance 

5% 

-20/+50% 

± 10% 

**7Z85944.1 **


---

## Page 152

990.4 131 03007 

ELECTRONIC DRIVE UNIT 

2-phase bipolar 

DESCRIPTION 

This unit has been designed as a straightforward 2-phase bipolar motor drive that only needs a clock or 
microprocessor pulse to determine the stepping rate. N74LS74N and N74LS86N ICs provide the logic 
translator function. 

Output stages and current sensing control is incorporated in two PBL3717B* ICs. Output current for 
each phase can be set by R3 and RB. Maximum output current for each phase is 600 mA at 45 V and 
55 °c ambient temperature. Both ICs have heatsinks for extra security. 

The unit is fitted with connection tags that allow the alternative of direct soldered connections instead 
of the connector with which it is supplied. 

TECHNICAL DATA 

Mass 
50g. 
Switching pulses (V cl 

Ambient temperature range 
Ve= '1' 
vb:;;.. Ve> 2,0 v 

operating 
Oto 70 oc 
Ve= ·o· 
ov o;;;;vc<0,8 V 

storage 
-40 to 70 oc 
le max (Ve= '1 ') 
0,2mA 

·-le max (Ve= '0') 
0,8mA 

Power supply 
-le limiting value 
30mA 

vb 
5 v ±5% 
Pulse frequency 
25 kHz 

lb max (at 5 V) 
75mA 
Min. pulse width 
100 ns 

V c limiting value 
7V 
Direction of rotation 

Vm = '1' (CW) 
vb:;;..vm>2,0V 
Output 

V m = 'O' (CCW) 
OV o;;;;vm <0,8 v 
Vmm• limiting value 
45 v 

Im max (Vm = '1') 
0,2mA 
Vmm• recommended value 10to40V 
-Im max (Vm = 'O') 
0,8mA 
I max (Tamb = 70 oc) 
2x 500 mA 
-Im limiting value 
30mA 
I max (T amb = 55 °C) 
2 x 600 mA 

Vm limiting value 
7V 
Vsat (total at 1m=500mA) 4 V 

The inputs are; 
• C - a coun't input that receives the order for the rotor to step 
• M - a mode input that determines the direction of rotation by setting the output pulse sequence 
• R - a reset input that can be used to set the logic counter to "zero" before the trigger pulses are 

applied. 

*Types of RIFA, Sweden. 

(March 1986 
143 


---

## Page 153

**9904 ****131 ****03007 **

-

**Main ****dimensions **

94 
±0,5 
(37e) 

~------68,6±0,5 _______ , 

(27el 

R9[Df 

1 Be 7'-l-l-+-+-+-+-++-1-1-+·+-+ 
Fl 

10 
9 
8 
7 
6 
5 
4 
3 
2 
1 
~ lTU lJlJ lJ lJlJ 1J1 

i.-11,4__J 
35,6±0,1 
I 
±0,2 
(9x3,96l 
**7285982. ****1 **

Fig. 1 Board thickness: 1,6 mm; Cu thickness: 35 *µm; *tracks cover with solderesist, class **1. **

144 
"""h 19861 


---

## Page 154

s: ., 

C'l 
*:::T *

**co **
**00 **
**Cl **

~ 

**CIRCUIT DIAGRAM **

(parts list next page). 

M 

**c ****0 **
'-~ *>'} *

R1~ 

11 

10,~-

10 

U1 

11, CK 

CLR 

+ 

I 

Mal 
Mb1 

·1 r 

Umm 
v> 

Ucc 6 
7 
11 
Uc 

GND 12 

2 

cs 
I L.~R10 

+ 

U1 

CLR 

**7285983 **

Fig. 2 For connection diagrams see Fig. 3. 

Ma2 
Mb2 

7 
8 

15 

F 
Umm 

Ucc 6 

Uc 11 

12 
GND 
2 
T 

R5 

6 
**+Umm **

+5V 

OV 

ov 

**m **
**<ii" **
~ **a **
**::i **
Ci' 
**a. **
~ 
:;;:-

11) 
**c: **
**::i **
.. ~ 
.. 

**r-.> **
-0 
***=r ***
"' 
~ 
**O'" **
**ii" **

0 

**Ei" **

**co **
**co **
**0 **
**.j:>. **
_., 
**w **
_., 

**0 ****w **
**0 **
**0 **
**-...J **


---

## Page 155

-

**146 **

**CIRCUIT ****DIAGRAM **

**Parts ****list ****to ****Fig. 2. **

components 

U1 

U2 

U3,U4 

R1, R2, R7 

R3,R8 

R4, R9 

R5, R10 

R6, R11 

C1,C2,C3,C7,C8 

C4,C9 

C5 

C6 

--
description 

integrated circuit N74LS74N 

integrated circuit N74LS86N 

integrated circuit PBL3717B 

metal film resistor 

preset potentiometer 

metal film resistor 

metal film resistor 

metal film resistor 

ceramic capacitor 

polyester capacitor 

electrolytic capacitor 

electrolytic capacitor 

--

**CONNECTING ****DIAGRAM **

""'" 19861 

DRIVE 

UNIT 

2 c 

M 

+5V 

ov 
4 
5 
ov 

6 +VMM 

7 Ma1 

Mb1 

Ma2 

value 
tolerance 

1kSl1/8 W 
5% 

100.Q, 1/8 w 
5% 

82 n, 11a w 
5% 

1,2 *.Q, *1/4W 
5% 

56 k.Q, 1/8 w 
5% 

820 pF 

15 nF 
47µF,25V 

10µF, 63 V 

MOTOR COILS 

I 
___ J 

**7Z85945.1 **


---

## Page 156

9904 131 03008 

ELECTRONIC DRIVE UNIT 

4-phase bipolar 

DESCRIPTION 

This unit has been designed as a straightforward 2-phase bipolar constant current drive that only needs 
a clock or microprocessor pulse to determine the stepping rate. N74LS74N and N74LS86N ICs 
provide the logic translator function. 

Output stages and current sensing control is incorporated in four PBL3717B* ICs. Output current for 
each phase can be set individually by R2, R7, R12 and R17. Maximum output current for each phase 
is 600 mA at 45 V and 55 oc ambient temperature. The four I Cs have heatsinks for extra security. 

The unit is fitted with connection tags that allow the alternative of direct soldered connections instead 
of the connector with which it is supplied. 

TECHNICAL DATA 

Mass 
50 g 

Ambient temperature range 

operating 
O to 70 oc 
storage 
-40 to 70 oc 

Power supply 

vb 

lb max (at 5 V) 

Direction of rotation 

Vm = '1' (CW) 

Vm = 'O' (CCW) 

Im max IVm = '1') 

-Im max !Vm = '0') 
-Im limiting value 

V m limiting value 

The inputs are: 

5V ± 5% 

130mA 

vb;;;,vm>2,0V 
ov..;vm<0,8 v 

0,2mA 

0,8mA 

30mA 

7V 

Switching pulses (Vcl 

Ve= '1' 

Ve= 'O' 

le max (V c = '1') 
-le max (V c = 'O') 
-le limiting value 

Pulse frequency 

Min. pulse width 

Ve limiting value 

Output 

vb;;;,vc>2,0 v 

O V ..;vc<0,8 V 

0,2mA 

0,8mA 

30mA 

25 kHz 

100 ns 
7V 

VMM· limiting value 
45 V 

VMM· recommended value 10 to 40 V 

I max !Tamb = 70 °C) 
4 x 500 mA 

lmax (Tamb = 55 OC) 
4x 600mA 

Vsat (total at Im= 500 mA) 4 V 

• C - a count input that receives the order for the rotor to step. 
• M - a mode input that determines the direction of rotation by setting the output pulse sequence 

* Type of RI FA, Sweden. 

(March 1986 
147 


---

## Page 157

**9904 ****131 ****03008 **

Main dimensions 

--------~--- 99,1±0,5 ------------
1 
(3!!e) 

L.L_J__L__L_LJ_L-L-AL-'-l-""--'---'-'--'-L-.l-_J_ALU2'.JA-'-'-'--'-"--"'~'U31_,..~0-'-][...._,_,_--'--" 

Ul 
l1lf R22 
11 lf 
R21 

"t:nr rr 
R1 2 n rr 
rrR11 
+ 

137,2 
±0,5 
(54e) 

*T? *

U6 
[ 

u 
U7 
[ 

II 
II 
TT 
11 
rm 
11 
11 
II 

15 
14 
13 12 
11 
10 
9 
8 
7 
6 
5 
4 
3 
2 
1 
1µ"1JlJ1JlJ1JlJ1rUlJ1JlTU1Jlµ 

1-16,75__.i 
55,4±0,1 
i 
± 0,1 
(14x3,96) 

j 

l 

**7296517 **

3,6 
±0,1 

(4x) 

Fig. 1 Board thickness: 1,6 mm; Cu thickness: 35 *µm; *tracks covered with solderesist, class 1. 
~~~~~~~~~~--

148 
Jm,.<y , ... I 


---

## Page 158

'--., 
::s c: ., 
-< -

~ 

~ 
*'° *

**CIRCUIT DIAGRAM **

(parts list next page). 

**Ma4 **
**Mb4 **

141 
115 

1 
115 

~Vee 
VMMtf'
4 

11 
7 

l.!2JvR 
U4 
10 g 
C2 

GND 12 

E 
~ 
_ca 
.-

R1 

RHYI 

'--

C1~ R31 I I IR4 

+SV 

01 15 

M 3 
02 14 

Ma3 

0 
12 

+-2-J Vee 

Mb3 

91a 

15 

Ll.!j VR 

11 : 
cs 
VMM~'
4 

us 
10 
rlF c 

GND 12 

T 2 
E 
10 
r--

161 
R10l I =j:c5 

RB 
R~ 

'----< 

C4* Ran gR9 

.._ 

Ju2 

Ma2 

10 

t-.!!.J Vee 

Mb2 

0 

11 

15 

MM 

t..!..!.jvR 

11 : 
ca 

V ~

,4 

U6 
10 

~F 
c 

12 
GND 
T 2 
E 
10 
r--

161 
R1sl I *CS 

R11 

IR~ 

CTIJR14 

'--

031.! 
Ul 
l.113~~~~~~~~~~~~r-~r-T-- I 

C 4 
CK 
~~~~"f<"~~~~~~~~r-~r-r-1 

+5V 

R02 ~R22 

**7295518 **.' 

Ma1 

j-!4 Vee 

t..!..!.jvR 

,_..J4 F c 

10 
I 

R16 

Mb1 

Q 

9 

15 

**VMM 13,4 **

R1~ 

c1o=j: Rj1IR19 

'--

+SV 

--0 

*.m *

Fig. 2 For connection diagram see Fig_ 3. 

**m **
(;' 
~ a 
**::s **;:;· 

~ 
**;c· **

CD 
**c **
**::s **
;:+' 
.... 
**-c **

**::I" **

~ 
***er ***
**-g· **

§i" 

**co **
**co **
**0 **
~ 
..... 
***w ***
..... 
**0 *****w ***
**0 **
**0 **
**CXl **


---

## Page 159

**9904 ****131 ****03008 **

**CIRCUIT DIAGRAM **

Parts list to Fig. 2. 

components 

U1 

U2 

U3 

U4, U5, U6, U7 

Rl, R6, Rll, R16 
R21, R22 

R3,R8, R13,R18 

R4, R9, R14, R19 

R5, RlO, R15, R20 

R2, R7, R12, R17 
Cl, C3, C4, ca, C7, 
C9,C10,C12,C16 

C2, C5, CB, C11 

C13 

C14 
C15 

**CONNECTION DIAGRAM **

**150 **
January 1986 

description 

integrated circuit 

integrated circuit 

integrated circuit 

integrated circuit 

) metal film resistor. 

metal film resistor 

metal film resistor 

metal film resistor 

preset potentiometer 

) ceramic capacitor 

polyester capacitor 

polyester capacitor 

electrolytic capacitor 

electrolytic capacitor 

2 R 

M 
c 
4 

+5V 

ov 
5 
6 
ov 

4-PHASE 7 + VMM 

value 

1 krl;0,125W 

82rl;0,125W 

1,2 fl; 0,25 w 

56 krl; 0, 125 w 
10on 

820 pF 

15 nF 

100 nF 

47 µF; 25 V 
10µF;63V 

MOTOR COILS 

BIPOLAR 
Mal 
DRIVE 
8 
1 l' 
UNIT 
9 f"Mc.::b_.;_1 __ -+'-----' 

1-----1 

I 

Ma2 
10 f"'-0~---+'-"r"r<·~.., I 
11 f"M"'-'b-"2----1'.:..2' ___ 
_, 
I 
I 
12 Ma3 

13 Mb3 

14 Ma4 

15 Mb4 

Fig. 3. 

'3' 
I 
I 
4' 
I 
L _____ J 

**7Z85952 **

type 

N74LS194AN 

N74LS04N 

N74LS10N 

PBL3717B 

2322 181 13102 

2322 181 13829 

2322 182 13128 

2322 181 13563 

2322 410 03351 

2222 630 09821 

2222 366 51153 

2222 366 21104 

2222 030 26479 

2222 030 28109 


---

## Page 160

**____ **
**Jl ****______ **
**INDEX **

**INDEX OF CATALOGUE NUMBERS **

catalogue no. 
page 
catalogue no. 
page 

9904 112 06001 
33 
9904 **115 **15101 
115 
06101 
33 
15201 
119 
27001 
37 
15401 
123 
27101 
37 
23101 
127 
27201 
41 
23102 
127 

28001 
45 
23111 
127 
28101 
45 
23112 
127 
28201 
49 
29201 
52 
9904 131 03006 
139 
30201 
55 
03007 
143 

31001 
59 
03008 
147 
31004 
63 
SAA1027 
135 
31006 
67 
31101 
59 
31104 
63 

31106 
67 
31206 
71 
32001 
75 
32101 
75 
32204 
79 

33004 
83 
33104 
83 
33105 
87 
34004 
91 
34104 
91 

35014 
95 
35016 
99 
35114 

I 

95 
35116 
99 
35214 
103 

35216 

I 

107 
36014 
111 

36114 L-~-


---

## Page 161


---

## Page 162

Argentina: PHILIPS ARGENTINA S.A., Div. Elcoma. Vedia 3892. 1430 BUENOS AIRES. Tel . 541-7141fl242fl343/7444/7545. 
Australia: PHILIPS INDUSTRIES HOLDINGS LTD., Elcoma D1v1s1on. 67 Mars Road . LANE COVE. 2066. N.S. W .. Tel. 427 08 88. 
Austria: OSTERREICHISCHE PHILIPS BAUELEMENTE INDUSTRIE G.m.b.H .. Tnester Str. 64. A-1101 WIEN. Tel. 629111-0. 
Belgium: N.V. PHILIPS & MBLE ASSOCIATED. 9 rue du Pavilion. B-1030 BRUXELLES. Tel. I02J 242 7400. 
Brazil: IBRAPE, Caixa Postal 7383. Av. Brigadeiro Faria Lima. 1735 SAO PAULO. SP. Tel. /011 ) 211-2600. 
Canada: PHILIPS ELECTRONICS LTD .. 60t Milner Ave .. SCARBOROUGH. Ontario. MtB 1M8. Tel. 292-516 1. 
Chile: PHILIPS CHI LENA SA, Av. Santa Maria 0760, SANTIAGO. Tel. 39-4001 . 
Colombia: IND. PHILIPS DE COLOMBIA S.A., *clo *IPRELENSO LTD .. Cra. 21 . No. 56- 17. BOGOTA. D.E .. Tel. 2497624. 
Denmark: MINIWATI AIS. Strandlodsvej 2, P.O. Box 1919. DK 2300 COPENHAGEN S. Tel. (01 ) 54 1133. 
Finland: OY PHILIPS AB, Elcoma Division, Kaivokatu 8. SF-00100 HELSINKI 10. Tel. 1 7271 . 
France: RTC-COMPELEC, 130 Avenue Ledru Rollin, F-75540 PARIS 11 . Tel. 43388000. 
Germany (Fed. Republic): VALVO, UB Bauelemente der Phillps G.m.b.H .. Valvo Haus. Burchardstrasse 19. D-2 HAMBURG 1 Tel. (040) 3296-0. 
Greece: PHILIPS HELLENIQUE S.A., Elcoma Division. 54, Syngru Av .. ATHENS 11742. Tel. 9215311 /319. 
Hong Kong: PHILIPS HONG KONG LTD., Elcoma Div .. 15/F Ph1l1ps Ind. Bldg .. 24-28 Kung Yip St. KWAI CHUNG. Tel. (0)-2451 21 . 
India: PEICO ELECTRONICS & ELECTRICALS LTD .. Elcoma Dept. Band Box Building. 

254-D Dr. Annie Besant Rd., BOMBAY - 400 025. Tel. 493031 1/4930590. 
Indonesia: P.T. PHIUPS-RALIN ELECTRONICS. Elcoma Div .. Set1abud1 JI Building. 6th Fl.. Jalan H.R. Rasuna Said (P.O. Box 223/KBY). Kuningan. 

JAKARTA-Selatan. Tel. 512572 
Ireland: PHILIPS ELECTRICAL(IRELAND) LTD. , Newstead. Clonskeagh. DUBLIN 14. Tel. 693355. 
Italy: Britelec S.R.L, Viale Fulvio Testi 327, 1-20162 MILANO. Tel. 02-6445. 
Japan: NIHON MICRO MOTOR. Mikamo Bldg .. 2-3 chome Sakae-cho. Tach1kawa-c1ty. TOKYO. Japan 190. Tel. 0425-27.7722. 
Korea (Republic of): PHILIPS ELECTRONICS (KOREA) LTD .. Elcoma Div .. Ph1l1ps House. 260-199 ltaewon-dong. Yongsan-ku, SEOUL, Tel. 794-5011. 
Malaysia: PHILIPS MALAYSIA SON. BEAHAD. No. 4 Perstaran Barat. Petallng Jaya. P.0 .8. 2163. KUALA LUMPUR. Selangor. Tel. 77 4411 . 
Mexico: ELECTRONICA, S.A de C.V., Carr. Mexico-Toluca km. 62.5. TOLUCA. Eda. de Mexico 50140. Tel. Toluca 91(721) 613-00. 
Netherlands: PHILIPS NEDERLAND. Marktgroep Elonco, Postbus 90050. 5600 PB EINDHOVEN. Tel. (040) 793333. 
New Zealand: PHILIPS NEW ZEALAND LTD .. Elcoma Division. 110 Mt. Eden Road. C.P.0 . Box 1041 . AUCKLAND. Tel. 605-914. 
Norway: NORSK *NS *PHI UPS. Electronica Dept., Sandstuveien 70. O~~ ') 6. Tel. 68020o". 
Peru: CADESA, Av. Jiron Nazca 704, Apartado No. 5612, LIMA IL Peru *Te**l. *319253. 
Philippines: PHILIPS INDUSTRIAL DEV. INC .. 2246 Pasong Tamo. P.O. Box 911 , Makall Comm. Centre. MAKA Tl-RIZAL 3116. Tel. 86-89-51to59. 
Portugal: PHILIPS PORTUGUESA SAR.L., Av. Eng. Duarte Pacheco 6. 1009 LISBOA Codex. Tel. 6831 21 . 
Singapore: PHILIPS PROJECT DEV. (Singapore) PTE LTD. , Elcoma Div .. Lorong 1. Toa Payoh. SINGAPORE 1231, Tel . 2538811 . 
South Africa: EDAC (PTY.) LTD .. 3rd Floor Rainer House. Upper Railway Rd. & Ove St .. New Doornfontein. JOHANNESBURG 2001 , Tel. 614-2362/9. 
Spain: MINIWATI SA. Balmes 22. BARCELONA 7, Tel. 301 6312. 
Sweden: PHILIPS KOMPONENTER A.B., Lidingiivagen 50. S-11584 STOCKHOLM 27. Tel. 08/7821000. 
Switzerland: PHILIPS A.G., Elcoma Dept.. Allmendstrasse 140-142. CH-8027 ZURICH. Tel. 01-48822 11. 
Taiwan: PHILIPS TAIWAN LTD., 150 Tun Hua North Road. P.O. Box 22978 TAIPEI. Taiwan. Tel. 7120500 
Thailand: PHILIPS ELECTRICAL CO. OF THAILAND LTD .. 283Silom Road. P.O. Box 961 . BANGKOK. Tel. 233-6330-9. 
Turkey: TURK PHILI PS TICARET A.S .. Elcoma Department. Inonu Cad .. No. 78-80. PK.504. 80074 ISTANBUL. Tel. 435910. 
United Kingdom: lmpex Electrical Ltd., Market Road, Richmond, SURREY TW9 4ND. Tel. 01-876104 7. 
United States: North American Philips Controls Corp. , Cheshire Industrial Park. Cheshire. Conn. 06410, Tel. (203) 272-0301 . 
Uruguay: LUZILECTRON SA, Avda Uruguay 1287, P.O. Box 907. MONTEVIDEO. Tel. 914321 . 
Venezuela: IND. VENEZOLANAS PHILIPS SA, c/o MAGNETICA SA. Calle 6. Ed. Las Tres Jotas. App. Post. 78117. CARACAS. Tel. (02)239393 1. 

For all other countries apply to: Philips Electronic Components and Matenals D1v1s1on. International Business Relations, P.O. Box 218. 
5600 MD EINDHOVEN, The Netherlands, Telex 35000 phtcnl 

M52 
©Phillps Export B.V. 1986 

This 1nformat1on 1s furnished for guidance. and with no guarantees as to .ts accuracy or completeness; its publication conveys no licence under any 
patent or other nght. nor does the publisher assume hability for any consequence of ts use. specifications and ava1fab1!1ty of goods mentioned 1n 1t are 
sub1ect to change without notice; 1t 1s not to be reproduced 1n any way. 1n whole or n part Without the wntten consent of the publisher. 

Printed 1n The Netherlands 
9398 140 90011 


---

