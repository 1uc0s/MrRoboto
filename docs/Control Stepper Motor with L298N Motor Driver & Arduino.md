# Control Stepper Motor with L298N Motor Driver & Arduino
## Page 1

ARDUINO

Control Stepper Motor with L298N

Motor Driver & Arduino

If you are planning on assembling your new robot, you will eventually want to learn how to

control stepper motors. The easiest and inexpensive way to control stepper motors is to use

the L298N motor driver. It can control both the speed and the spinning direction of any small

to medium sized bipolar stepper motor such as the NEMA 17.

If you wish to control multiple stepper motors, it is recommended that you use a self-

contained dedicated stepper motor driver such as the A4988. If you want to know more about

it, check this tutorial out.

Control Stepper Motor with A4988 Driver Module & Arduino

If you’re diving into the world of robotics, 3D printing, or building your own CNC

machine, chances are you’ll soon come across stepper motors like...

Controlling a Stepper Motor With an H-Bridge

Th L298N
d l h
t
H B id
E
h H b id
d i
f th
l
t
ti
il

⚙

11/12/25, 3:01 PM
Control Stepper Motor with L298N Motor Driver & Arduino

https://lastminuteengineers.com/stepper-motor-l298n-arduino-tutorial/
1/7


---

## Page 2

The L298N module has two H-Bridges. Each H-bridge drives one of the electromagnetic coils

of a stepper motor.

By energizing these electromagnetic coils in a specific sequence, the shaft of the stepper can

be moved forward or backward precisely in small steps.

However, the speed of the motor is determined by how frequently these coils are energized.

The following animation shows how H-bridges drive a stepper motor.

ARDUINO

Control Stepper Motor with L298N

Motor Driver & Arduino

If you are planning on assembling your new robot, you will eventually want to learn how to

control stepper motors. The easiest and inexpensive way to control stepper motors is to use

the L298N motor driver. It can control both the speed and the spinning direction of any small

to medium sized bipolar stepper motor such as the NEMA 17.

If you wish to control multiple stepper motors, it is recommended that you use a self-

contained dedicated stepper motor driver such as the A4988. If you want to know more about

it, check this tutorial out.

Control Stepper Motor with A4988 Driver Module & Arduino

If you’re diving into the world of robotics, 3D printing, or building your own CNC

machine, chances are you’ll soon come across stepper motors like...

Controlling a Stepper Motor With an H-Bridge

Th L298N
d l h
t
H B id
E
h H b id
d i
f th
l
t
ti
il

⚙

11/12/25, 3:01 PM
Control Stepper Motor with L298N Motor Driver & Arduino

https://lastminuteengineers.com/stepper-motor-l298n-arduino-tutorial/
2/7


---

## Page 3

L298N Motor Driver Chip

At the center of the module is a big, black chip with a chunky heat sink – the L298N, from ST

Semiconductor.

Inside the L298N chip, you’ll find two standard H-bridges capable of driving a pair of DC

motors or a single stepper motor.

The L298N motor driver has a supply range of 5V to 35V and is capable of supplying 2A

continuous current per coil, so it works very well with most of our stepper motors.

Technical Specifications

The L298N module has two H-Bridges. Each H-bridge drives one of the electromagnetic coils

of a stepper motor.

By energizing these electromagnetic coils in a specific sequence, the shaft of the stepper can

be moved forward or backward precisely in small steps.

However, the speed of the motor is determined by how frequently these coils are energized.

The following animation shows how H-bridges drive a stepper motor.

ARDUINO

Control Stepper Motor with L298N

Motor Driver & Arduino

If you are planning on assembling your new robot, you will eventually want to learn how to

control stepper motors. The easiest and inexpensive way to control stepper motors is to use

the L298N motor driver. It can control both the speed and the spinning direction of any small

to medium sized bipolar stepper motor such as the NEMA 17.

If you wish to control multiple stepper motors, it is recommended that you use a self-

contained dedicated stepper motor driver such as the A4988. If you want to know more about

it, check this tutorial out.

Control Stepper Motor with A4988 Driver Module & Arduino

If you’re diving into the world of robotics, 3D printing, or building your own CNC

machine, chances are you’ll soon come across stepper motors like...

Controlling a Stepper Motor With an H-Bridge

Th L298N
d l h
t
H B id
E
h H b id
d i
f th
l
t
ti
il

⚙

11/12/25, 3:01 PM
Control Stepper Motor with L298N Motor Driver & Arduino

https://lastminuteengineers.com/stepper-motor-l298n-arduino-tutorial/
3/7


---

## Page 4

Here are the specifications:

Motor output voltage
5V – 35V

Motor output voltage (Recommended)
7V – 12V

Logic input voltage
5V – 7V

Continuous current per channel
2A

Max Power Dissipation
25W

For more details, please refer below datasheet.

L298N Motor Driver Module Pinout

The L298N module has a total of 11 pins that connect it to the outside world. The pins are as

follows:

Let’s get acquainted with all the pins one by one.

Power Pins

The L298N motor driver module is powered through 3-pin 3.5mm-pitch screw terminal.

L298N Motor Driver Chip

At the center of the module is a big, black chip with a chunky heat sink – the L298N, from ST

Semiconductor.

Inside the L298N chip, you’ll find two standard H-bridges capable of driving a pair of DC

motors or a single stepper motor.

The L298N motor driver has a supply range of 5V to 35V and is capable of supplying 2A

continuous current per coil, so it works very well with most of our stepper motors.

Technical Specifications

The L298N module has two H-Bridges. Each H-bridge drives one of the electromagnetic coils

of a stepper motor.

By energizing these electromagnetic coils in a specific sequence, the shaft of the stepper can

be moved forward or backward precisely in small steps.

However, the speed of the motor is determined by how frequently these coils are energized.

The following animation shows how H-bridges drive a stepper motor.

ARDUINO

Control Stepper Motor with L298N

Motor Driver & Arduino

If you are planning on assembling your new robot, you will eventually want to learn how to

control stepper motors. The easiest and inexpensive way to control stepper motors is to use

the L298N motor driver. It can control both the speed and the spinning direction of any small

to medium sized bipolar stepper motor such as the NEMA 17.

If you wish to control multiple stepper motors, it is recommended that you use a self-

contained dedicated stepper motor driver such as the A4988. If you want to know more about

it, check this tutorial out.

Control Stepper Motor with A4988 Driver Module & Arduino

If you’re diving into the world of robotics, 3D printing, or building your own CNC

machine, chances are you’ll soon come across stepper motors like...

Controlling a Stepper Motor With an H-Bridge

Th L298N
d l h
t
H B id
E
h H b id
d i
f th
l
t
ti
il

L298N Datasheet

⚙

11/12/25, 3:01 PM
Control Stepper Motor with L298N Motor Driver & Arduino

https://lastminuteengineers.com/stepper-motor-l298n-arduino-tutorial/
4/7


---

## Page 5

The L298N motor driver actually has two input power pins – VS and VSS.

 pin gives power to the internal H-Bridges of the IC to drive the motor. You can connect

an input voltage anywhere between 5 to 12V to this pin.

 is used to drive the logic circuitry inside the L298N IC which can be 5 to 7V.

 is the common ground pin.

Here are the specifications:

Motor output voltage
5V – 35V

Motor output voltage (Recommended)
7V – 12V

Logic input voltage
5V – 7V

Continuous current per channel
2A

Max Power Dissipation
25W

For more details, please refer below datasheet.

L298N Motor Driver Module Pinout

The L298N module has a total of 11 pins that connect it to the outside world. The pins are as

follows:

Let’s get acquainted with all the pins one by one.

Power Pins

The L298N motor driver module is powered through 3-pin 3.5mm-pitch screw terminal.

L298N Motor Driver Chip

At the center of the module is a big, black chip with a chunky heat sink – the L298N, from ST

Semiconductor.

Inside the L298N chip, you’ll find two standard H-bridges capable of driving a pair of DC

motors or a single stepper motor.

The L298N motor driver has a supply range of 5V to 35V and is capable of supplying 2A

continuous current per coil, so it works very well with most of our stepper motors.

Technical Specifications

The L298N module has two H-Bridges. Each H-bridge drives one of the electromagnetic coils

of a stepper motor.

By energizing these electromagnetic coils in a specific sequence, the shaft of the stepper can

be moved forward or backward precisely in small steps.

However, the speed of the motor is determined by how frequently these coils are energized.

The following animation shows how H-bridges drive a stepper motor.

ARDUINO

Control Stepper Motor with L298N

Motor Driver & Arduino

If you are planning on assembling your new robot, you will eventually want to learn how to

control stepper motors. The easiest and inexpensive way to control stepper motors is to use

the L298N motor driver. It can control both the speed and the spinning direction of any small

to medium sized bipolar stepper motor such as the NEMA 17.

If you wish to control multiple stepper motors, it is recommended that you use a self-

contained dedicated stepper motor driver such as the A4988. If you want to know more about

it, check this tutorial out.

Control Stepper Motor with A4988 Driver Module & Arduino

If you’re diving into the world of robotics, 3D printing, or building your own CNC

machine, chances are you’ll soon come across stepper motors like...

Controlling a Stepper Motor With an H-Bridge

Th L298N
d l h
t
H B id
E
h H b id
d i
f th
l
t
ti
il

L298N Datasheet

VS

VSS

GND

⚙

11/12/25, 3:01 PM
Control Stepper Motor with L298N Motor Driver & Arduino

https://lastminuteengineers.com/stepper-motor-l298n-arduino-tutorial/
5/7


---

## Page 6

Output Pins

The L298N motor driver’s output channels 
, 
, 
 and 
 are broken

out to the edge of the module with two 3.5mm-pitch screw terminals. You can connect any

12-24V stepper motor to these terminals.

Each channel of the module can deliver up to 2A to the stepper motor. However the amount of

current supplied to the motor depends on the power supply of the system.

Control Pins

Using the four control pins 
, 
, 
 and 
, you can control both the speed and

the spinning direction of the stepper motor. These pins actually control the switches of the H-

Bridge circuit inside the L298N chip.

The L298N motor driver actually has two input power pins – VS and VSS.

 pin gives power to the internal H-Bridges of the IC to drive the motor. You can connect

an input voltage anywhere between 5 to 12V to this pin.

 is used to drive the logic circuitry inside the L298N IC which can be 5 to 7V.

 is the common ground pin.

Here are the specifications:

Motor output voltage
5V – 35V

Motor output voltage (Recommended)
7V – 12V

Logic input voltage
5V – 7V

Continuous current per channel
2A

Max Power Dissipation
25W

For more details, please refer below datasheet.

L298N Motor Driver Module Pinout

The L298N module has a total of 11 pins that connect it to the outside world. The pins are as

follows:

Let’s get acquainted with all the pins one by one.

Power Pins

The L298N motor driver module is powered through 3-pin 3.5mm-pitch screw terminal.

L298N Motor Driver Chip

At the center of the module is a big, black chip with a chunky heat sink – the L298N, from ST

Semiconductor.

Inside the L298N chip, you’ll find two standard H-bridges capable of driving a pair of DC

motors or a single stepper motor.

The L298N motor driver has a supply range of 5V to 35V and is capable of supplying 2A

continuous current per coil, so it works very well with most of our stepper motors.

Technical Specifications

The L298N module has two H-Bridges. Each H-bridge drives one of the electromagnetic coils

of a stepper motor.

By energizing these electromagnetic coils in a specific sequence, the shaft of the stepper can

be moved forward or backward precisely in small steps.

However, the speed of the motor is determined by how frequently these coils are energized.

The following animation shows how H-bridges drive a stepper motor.

ARDUINO

Control Stepper Motor with L298N

Motor Driver & Arduino

If you are planning on assembling your new robot, you will eventually want to learn how to

control stepper motors. The easiest and inexpensive way to control stepper motors is to use

the L298N motor driver. It can control both the speed and the spinning direction of any small

to medium sized bipolar stepper motor such as the NEMA 17.

If you wish to control multiple stepper motors, it is recommended that you use a self-

contained dedicated stepper motor driver such as the A4988. If you want to know more about

it, check this tutorial out.

Control Stepper Motor with A4988 Driver Module & Arduino

If you’re diving into the world of robotics, 3D printing, or building your own CNC

machine, chances are you’ll soon come across stepper motors like...

Controlling a Stepper Motor With an H-Bridge

Th L298N
d l h
t
H B id
E
h H b id
d i
f th
l
t
ti
il

L298N Datasheet

VS

VSS

GND

OUT1
OUT2
OUT3
OUT4

IN1
IN2
IN3
IN4

⚙

11/12/25, 3:01 PM
Control Stepper Motor with L298N Motor Driver & Arduino

https://lastminuteengineers.com/stepper-motor-l298n-arduino-tutorial/
6/7


---

## Page 7

The way you pulse these pins affects the behavior of the motor.

1. The sequence of pulses determines the spinning direction of the motor.

2. The frequency of the pulses determines the speed of the motor.

3. The number of pulses determines how far the motor will turn.

Enable Pins

The enable pins 
 and 
 are used to enable or disable the motor independently of

the input signals.

Pulling these pins HIGH will enable the motor, while pulling it LOW will disable the motor.

Output Pins

The L298N motor driver’s output channels 
, 
, 
 and 
 are broken

out to the edge of the module with two 3.5mm-pitch screw terminals. You can connect any

12-24V stepper motor to these terminals.

Each channel of the module can deliver up to 2A to the stepper motor. However the amount of

current supplied to the motor depends on the power supply of the system.

Control Pins

Using the four control pins 
, 
, 
 and 
, you can control both the speed and

the spinning direction of the stepper motor. These pins actually control the switches of the H-

Bridge circuit inside the L298N chip.

The L298N motor driver actually has two input power pins – VS and VSS.

 pin gives power to the internal H-Bridges of the IC to drive the motor. You can connect

an input voltage anywhere between 5 to 12V to this pin.

 is used to drive the logic circuitry inside the L298N IC which can be 5 to 7V.

 is the common ground pin.

Here are the specifications:

Motor output voltage
5V – 35V

Motor output voltage (Recommended)
7V – 12V

Logic input voltage
5V – 7V

Continuous current per channel
2A

Max Power Dissipation
25W

For more details, please refer below datasheet.

L298N Motor Driver Module Pinout

The L298N module has a total of 11 pins that connect it to the outside world. The pins are as

follows:

Let’s get acquainted with all the pins one by one.

Power Pins

The L298N motor driver module is powered through 3-pin 3.5mm-pitch screw terminal.

L298N Motor Driver Chip

At the center of the module is a big, black chip with a chunky heat sink – the L298N, from ST

Semiconductor.

Inside the L298N chip, you’ll find two standard H-bridges capable of driving a pair of DC

motors or a single stepper motor.

The L298N motor driver has a supply range of 5V to 35V and is capable of supplying 2A

continuous current per coil, so it works very well with most of our stepper motors.

Technical Specifications

The L298N module has two H-Bridges. Each H-bridge drives one of the electromagnetic coils

of a stepper motor.

By energizing these electromagnetic coils in a specific sequence, the shaft of the stepper can

be moved forward or backward precisely in small steps.

However, the speed of the motor is determined by how frequently these coils are energized.

The following animation shows how H-bridges drive a stepper motor.

ARDUINO

Control Stepper Motor with L298N

Motor Driver & Arduino

If you are planning on assembling your new robot, you will eventually want to learn how to

control stepper motors. The easiest and inexpensive way to control stepper motors is to use

the L298N motor driver. It can control both the speed and the spinning direction of any small

to medium sized bipolar stepper motor such as the NEMA 17.

If you wish to control multiple stepper motors, it is recommended that you use a self-

contained dedicated stepper motor driver such as the A4988. If you want to know more about

it, check this tutorial out.

Control Stepper Motor with A4988 Driver Module & Arduino

If you’re diving into the world of robotics, 3D printing, or building your own CNC

machine, chances are you’ll soon come across stepper motors like...

Controlling a Stepper Motor With an H-Bridge

Th L298N
d l h
t
H B id
E
h H b id
d i
f th
l
t
ti
il

L298N Datasheet

VS

VSS

GND

OUT1
OUT2
OUT3
OUT4

IN1
IN2
IN3
IN4

ENA
ENB

⚙

11/12/25, 3:01 PM
Control Stepper Motor with L298N Motor Driver & Arduino

https://lastminuteengineers.com/stepper-motor-l298n-arduino-tutorial/
7/7


---

