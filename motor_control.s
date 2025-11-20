#include <xc.inc>
psect motor_code,class=CODE,reloc=2

; ============================================
; Multi-Motor Control Module for L298N Driver
; Unipolar Stepper Motor: 9904 112 35014 (6 terminals, 4-phase unipolar)
; Using L298N to drive individual coils (not as H-bridges)
; CLAW MOTOR - PORT D bits 0-3 (RD0=Coil1, RD1=Coil2, RD2=Coil3, RD3=Coil4)
; BASE MOTOR - PORT D bits 4-7 (RD4=Coil1, RD5=Coil2, RD6=Coil3, RD7=Coil4)
; SHOULDER MOTOR - PORT E bits 0-3 (RE0=Coil1, RE1=Coil2, RE2=Coil3, RE3=Coil4)
; ELBOW MOTOR - PORT E bits 4-7 (RE4=Coil1, RE5=Coil2, RE6=Coil3, RE7=Coil4)
; WRIST PITCH - PORT H bits 0-3 (RH0=Coil1, RH1=Coil2, RH2=Coil3, RH3=Coil4)
; WRIST ROLL - PORT H bits 4-7 (RH4=Coil1, RH5=Coil2, RH6=Coil3, RH7=Coil4)
; ENA/ENB: Connected to +5V (always enabled)
; ============================================

; Configuration constants - step counts for each degree of freedom
; Motor has 7.5° step angle = 48 steps per full rotation (360°)
BASE_STEPS	EQU	0x60	; 96 steps = 2 full rotations (base has 360° freedom)
CLAW_STEPS	EQU	0x60	; 96 steps = 2 full rotations
SHOULDER_STEPS	EQU	0x60	; 96 steps = 2 full rotations
ELBOW_STEPS	EQU	0x60	; 96 steps = 2 full rotations
WRIST_STEPS	EQU	0x60	; 96 steps = 2 full rotations
BIDIR_TEST_STEPS	EQU	0x120	; 288 steps = 3 full rotations (legacy)

; Export functions for use in other modules
global	Motor_Init, Motor_BidirectionalTest, Motor_StepForward, Motor_StepBackward, Motor_StepsForward, Motor_StepsBackward, Motor_StepDelay
global	Motor_StepDelaySlow, Motor_SequentialDemo, Motor_Pause
global	Claw_StepForward, Claw_StepBackward, Base_StepForward, Base_StepBackward
global	Base_StepsForward, Base_StepsBackward, Claw_StepsForward, Claw_StepsBackward
global	Shoulder_StepForward, Shoulder_StepBackward, Shoulder_StepsForward, Shoulder_StepsBackward
global	Elbow_StepForward, Elbow_StepBackward, Elbow_StepsForward, Elbow_StepsBackward
global	Wrist_StepForward, Wrist_StepBackward, Wrist_StepsForward, Wrist_StepsBackward

; Motor step sequence constants (unipolar wave drive - one coil at a time)
; According to Philips documentation: Wave drive sequence is 1→3→2→4
; Pin connections: RE0=Coil1, RE1=Coil2, RE2=Coil3, RE3=Coil4
STEP1	EQU	0x01	; Coil 1 ON, others OFF (RE0=1, RE1=0, RE2=0, RE3=0)
STEP2	EQU	0x04	; Coil 3 ON, others OFF (RE0=0, RE1=0, RE2=1, RE3=0)
STEP3	EQU	0x02	; Coil 2 ON, others OFF (RE0=0, RE1=1, RE2=0, RE3=0)
STEP4	EQU	0x08	; Coil 4 ON, others OFF (RE0=0, RE1=0, RE2=0, RE3=1)

; Full-step drive constants (two coils at once - higher torque, ~30% more)
; Base motor uses full-step for better torque
; According to Philips documentation: Full-step sequence for 4-phase unipolar
; Step 1: Coil 1 + Coil 4, Step 2: Coil 1 + Coil 3, Step 3: Coil 2 + Coil 3, Step 4: Coil 2 + Coil 4
FULLSTEP1	EQU	0x09	; Coil 1 + Coil 4 ON (RE0=1, RE1=0, RE2=0, RE3=1)
FULLSTEP2	EQU	0x05	; Coil 1 + Coil 3 ON (RE0=1, RE1=0, RE2=1, RE3=0)
FULLSTEP3	EQU	0x06	; Coil 2 + Coil 3 ON (RE0=0, RE1=1, RE2=1, RE3=0)
FULLSTEP4	EQU	0x0A	; Coil 2 + Coil 4 ON (RE0=0, RE1=1, RE2=0, RE3=1)

; Memory allocation for motor control
clawStepIndex	EQU	0x0A	; Claw motor current step index (0-3)
baseStepIndex	EQU	0x0B	; Base motor current step index (0-3)
elbow1StepIndex	EQU	0x12	; Elbow motor current step index (0-3) - PORT E bits 4-7 (upper nibble)
elbow2StepIndex	EQU	0x13	; Shoulder motor current step index (0-3) - PORT E bits 0-3 (lower nibble)
wrist1StepIndex	EQU	0x14	; Wrist pitch motor current step index (0-3) - PORT H bits 0-3 (lower nibble)
wrist2StepIndex	EQU	0x15	; Wrist roll motor current step index (0-3) - PORT H bits 4-7 (upper nibble)
stepCount	EQU	0x0C	; Counter for number of steps to execute
stepDelayH	EQU	0x0D	; Delay counter high byte for step timing
stepDelayL	EQU	0x0E	; Delay counter low byte for step timing
pauseDelayH	EQU	0x0F	; Pause delay counter high byte
pauseDelayL	EQU	0x10	; Pause delay counter low byte
pauseOuter	EQU	0x11	; Outer loop counter for pause
tempPattern	EQU	0x16	; Temporary scratch register for pattern manipulation
tempPattern2	EQU	0x17	; Additional scratch register
tempPattern3	EQU	0x18	; Additional scratch register
portDClawPattern	EQU	0x19	; Cached pattern for Claw (PORT D bits 0-3)
portDBasePattern	EQU	0x1A	; Cached pattern for Base (PORT D bits 4-7)
portEElbow2Pattern	EQU	0x1B	; Cached pattern for Elbow 2 (PORT E bits 0-3)
portEElbow1Pattern	EQU	0x1C	; Cached pattern for Elbow 1 (PORT E bits 4-7)
portHWrist1Pattern	EQU	0x1D	; Cached pattern for Wrist 1 (PORT H bits 0-3)
portHWrist2Pattern	EQU	0x1E	; Cached pattern for Wrist 2 (PORT H bits 4-7)

; ============================================
; Helper routines: Write cached patterns to ports
; Ensures both nibble partners update simultaneously
; ============================================
WritePortD:
	movf	portDBasePattern, W, A
	iorwf	portDClawPattern, W, A
	movwf	LATD, A
	return

WritePortE:
	movf	portEElbow1Pattern, W, A
	iorwf	portEElbow2Pattern, W, A
	movwf	LATE, A
	return

WritePortH:
	movf	portHWrist2Pattern, W, A
	iorwf	portHWrist1Pattern, W, A
	movwf	LATH, A
	return

; ============================================
; Motor_Init: Initialize all motors
; Sets all motors to step 0 (first position)
; ============================================
Motor_Init:
	; Initialize all step indices to 0
	movlw	0x00
	movwf	clawStepIndex, A	; Claw starts at step 0
	movwf	baseStepIndex, A	; Base starts at step 0
	movwf	elbow1StepIndex, A	; Elbow starts at step 0
	movwf	elbow2StepIndex, A	; Shoulder starts at step 0
	movwf	wrist1StepIndex, A	; Wrist pitch starts at step 0
	movwf	wrist2StepIndex, A	; Wrist roll starts at step 0
	
	; Initialize PORT D cache: Claw (low nibble) and Base (high nibble)
	; Both use wave drive (one coil at a time)
	movlw	STEP1
	movwf	portDClawPattern, A
	movlw	STEP1	; Base uses wave drive (one coil at a time)
	movwf	tempPattern, A
	swapf	tempPattern, W, A
	movwf	portDBasePattern, A
	call	WritePortD
	
	; Initialize PORT E cache: Elbow 2 (low) and Elbow 1 (high)
	movlw	STEP1
	movwf	portEElbow2Pattern, A
	movlw	STEP1
	movwf	tempPattern, A
	swapf	tempPattern, W, A
	movwf	portEElbow1Pattern, A
	call	WritePortE
	
	; Initialize PORT H cache: Wrist 1 (low) and Wrist 2 (high)
	movlw	STEP1
	movwf	portHWrist1Pattern, A
	movlw	STEP1
	movwf	tempPattern, A
	swapf	tempPattern, W, A
	movwf	portHWrist2Pattern, A
	call	WritePortH
	
	return

; ============================================
; Motor_StepForward: Execute one step forward (legacy - calls Both_StepForward)
; Advances both motors to next step in sequence (0->1->2->3->0)
; Kept for backward compatibility with exported function
; ============================================
Motor_StepForward:
	call	Both_StepForward
	return

; ============================================
; Motor_StepBackward: Execute one step backward (legacy - calls Both_StepBackward)
; Moves both motors to previous step in sequence (0->3->2->1->0)
; Kept for backward compatibility with exported function
; ============================================
Motor_StepBackward:
	call	Both_StepBackward
	return

; ============================================
; GetStepValue: Returns step pattern for given index (wave drive - one coil)
; Input: W = step index (0-3)
; Output: W = step pattern value
; ============================================
GetStepValue:
	; Save W to temporary register for comparison
	; Use pauseDelayL instead of stepDelayL to avoid conflicts with delay functions
	movwf	pauseDelayL, A	; Temporarily use pauseDelayL to save W
	; Compare with 0
	movf	pauseDelayL, W, A
	xorlw	0x00		; XOR with 0, sets Z if W==0
	bz	return_step1
	; Compare with 1
	movf	pauseDelayL, W, A
	xorlw	0x01		; XOR with 1, sets Z if W==1
	bz	return_step2
	; Compare with 2
	movf	pauseDelayL, W, A
	xorlw	0x02		; XOR with 2, sets Z if W==2
	bz	return_step3
	; If we get here, W must be 3
	movlw	STEP4
	return
return_step1:
	movlw	STEP1
	return
return_step2:
	movlw	STEP2
	return
return_step3:
	movlw	STEP3
	return

; ============================================
; GetFullStepValue: Returns full-step pattern for given index (two coils - higher torque)
; Input: W = step index (0-3)
; Output: W = full-step pattern value
; ============================================
GetFullStepValue:
	; Save W to temporary register for comparison
	movwf	pauseDelayL, A	; Temporarily use pauseDelayL to save W
	; Compare with 0
	movf	pauseDelayL, W, A
	xorlw	0x00		; XOR with 0, sets Z if W==0
	bz	return_fullstep1
	; Compare with 1
	movf	pauseDelayL, W, A
	xorlw	0x01		; XOR with 1, sets Z if W==1
	bz	return_fullstep2
	; Compare with 2
	movf	pauseDelayL, W, A
	xorlw	0x02		; XOR with 2, sets Z if W==2
	bz	return_fullstep3
	; If we get here, W must be 3
	movlw	FULLSTEP4
	return
return_fullstep1:
	movlw	FULLSTEP1
	return
return_fullstep2:
	movlw	FULLSTEP2
	return
return_fullstep3:
	movlw	FULLSTEP3
	return

; ============================================
; Claw_StepForward: Execute one step forward on claw motor (PORT D bits 0-3)
; Advances to next step in sequence (0->1->2->3->0)
; Preserves Base motor state (bits 4-7) via cached write to PORT D
; ============================================
Claw_StepForward:
	movf	clawStepIndex, W, A	; Load current step index
	addlw	0x01		; Increment step index
	andlw	0x03		; Wrap around (0-3)
	movwf	clawStepIndex, A	; Save new step index
	
	; Get step pattern for current index
	movf	clawStepIndex, W, A
	call	GetStepValue	; Get step pattern (bits 0-3)
	movwf	portDClawPattern, A
	call	WritePortD
	return

; ============================================
; Claw_StepBackward: Execute one step backward on claw motor (PORT D bits 0-3)
; Moves to previous step in sequence (0->3->2->1->0)
; Preserves Base motor state (bits 4-7) via cached write to PORT D
; ============================================
Claw_StepBackward:
	movf	clawStepIndex, W, A	; Load current step index
	addlw	0x03		; Decrement by adding 3 (wraps correctly)
	andlw	0x03		; Wrap around (0-3)
	movwf	clawStepIndex, A	; Save new step index
	
	; Get step pattern for current index
	movf	clawStepIndex, W, A
	call	GetStepValue	; Get step pattern (bits 0-3)
	movwf	portDClawPattern, A
	call	WritePortD
	return

; ============================================
; Base_StepForward: Execute one step forward on base motor (PORT D bits 4-7)
; Uses WAVE DRIVE mode (one coil at a time)
; Advances to next step in sequence (0->1->2->3->0)
; Preserves Claw motor state (bits 0-3) via cached write to PORT D
; ============================================
Base_StepForward:
	movf	baseStepIndex, W, A	; Load current step index
	addlw	0x01		; Increment step index
	andlw	0x03		; Wrap around (0-3)
	movwf	baseStepIndex, A	; Save new step index
	
	; Get full step pattern for current index (two coils at a time) for higher torque
	movf	baseStepIndex, W, A
	call	GetFullStepValue	; Get full step pattern (bits 0-3)
	movwf	tempPattern, A
	swapf	tempPattern, W, A	; Shift into upper nibble
	movwf	portDBasePattern, A
	call	WritePortD
	return

; ============================================
; Base_StepBackward: Execute one step backward on base motor (PORT D bits 4-7)
; Uses WAVE DRIVE mode (one coil at a time)
; Moves to previous step in sequence (0->3->2->1->0)
; Preserves Claw motor state (bits 0-3) via cached write to PORT D
; ============================================
Base_StepBackward:
	movf	baseStepIndex, W, A	; Load current step index
	addlw	0x03		; Decrement by adding 3 (wraps correctly)
	andlw	0x03		; Wrap around (0-3)
	movwf	baseStepIndex, A	; Save new step index
	
	; Get full step pattern for current index (two coils at a time) for higher torque
	movf	baseStepIndex, W, A
	call	GetFullStepValue	; Get full step pattern (bits 0-3)
	movwf	tempPattern, A
	swapf	tempPattern, W, A	; Shift into upper nibble
	movwf	portDBasePattern, A
	call	WritePortD
	return

; ============================================
; Shoulder_StepForward: Step Shoulder motor forward
; Uses cached patterns to update PORTE
; Note: elbow2StepIndex = Shoulder (PORT E bits 0-3)
; ============================================
Shoulder_StepForward:
	; Shoulder forward (lower nibble, PORT E bits 0-3)
	movf	elbow2StepIndex, W, A
	addlw	0x01
	andlw	0x03
	movwf	elbow2StepIndex, A
	movf	elbow2StepIndex, W, A
	call	GetStepValue
	movwf	portEElbow2Pattern, A
	
	call	WritePortE
	return

; ============================================
; Shoulder_StepBackward: Step Shoulder motor backward
; Uses cached patterns to update PORTE
; Note: elbow2StepIndex = Shoulder (PORT E bits 0-3)
; ============================================
Shoulder_StepBackward:
	; Shoulder backward (lower nibble, PORT E bits 0-3)
	movf	elbow2StepIndex, W, A
	addlw	0x03
	andlw	0x03
	movwf	elbow2StepIndex, A
	movf	elbow2StepIndex, W, A
	call	GetStepValue
	movwf	portEElbow2Pattern, A
	
	call	WritePortE
	return

; ============================================
; Elbow_StepForward: Step Elbow motor forward
; Uses cached patterns to update PORTE
; Note: elbow1StepIndex = Elbow (PORT E bits 4-7)
; ============================================
Elbow_StepForward:
	; Elbow forward (upper nibble, PORT E bits 4-7)
	movf	elbow1StepIndex, W, A
	addlw	0x01
	andlw	0x03
	movwf	elbow1StepIndex, A
	movf	elbow1StepIndex, W, A
	call	GetStepValue
	movwf	tempPattern, A
	swapf	tempPattern, W, A
	movwf	portEElbow1Pattern, A
	
	call	WritePortE
	return

; ============================================
; Elbow_StepBackward: Step Elbow motor backward
; Uses cached patterns to update PORTE
; Note: elbow1StepIndex = Elbow (PORT E bits 4-7)
; ============================================
Elbow_StepBackward:
	; Elbow backward (upper nibble, PORT E bits 4-7)
	movf	elbow1StepIndex, W, A
	addlw	0x03
	andlw	0x03
	movwf	elbow1StepIndex, A
	movf	elbow1StepIndex, W, A
	call	GetStepValue
	movwf	tempPattern, A
	swapf	tempPattern, W, A
	movwf	portEElbow1Pattern, A
	
	call	WritePortE
	return

; ============================================
; Wrist_StepForward: Step Wrist pitch and roll motors forward simultaneously
; Uses cached patterns to update PORTH simultaneously
; Note: wrist1StepIndex = Wrist pitch (PORT H bits 0-3), wrist2StepIndex = Wrist roll (PORT H bits 4-7)
; ============================================
Wrist_StepForward:
	; Wrist pitch forward (lower nibble, PORT H bits 0-3)
	movf	wrist1StepIndex, W, A
	addlw	0x01
	andlw	0x03
	movwf	wrist1StepIndex, A
	movf	wrist1StepIndex, W, A
	call	GetStepValue
	movwf	portHWrist1Pattern, A
	
	; Wrist roll forward (upper nibble, PORT H bits 4-7)
	movf	wrist2StepIndex, W, A
	addlw	0x01
	andlw	0x03
	movwf	wrist2StepIndex, A
	movf	wrist2StepIndex, W, A
	call	GetStepValue
	movwf	tempPattern, A
	swapf	tempPattern, W, A
	movwf	portHWrist2Pattern, A
	
	call	WritePortH
	return

; ============================================
; Wrist_StepBackward: Step Wrist pitch and roll motors backward simultaneously
; Uses cached patterns to update PORTH simultaneously
; Note: wrist1StepIndex = Wrist pitch (PORT H bits 0-3), wrist2StepIndex = Wrist roll (PORT H bits 4-7)
; ============================================
Wrist_StepBackward:
	; Wrist pitch backward (lower nibble, PORT H bits 0-3)
	movf	wrist1StepIndex, W, A
	addlw	0x03
	andlw	0x03
	movwf	wrist1StepIndex, A
	movf	wrist1StepIndex, W, A
	call	GetStepValue
	movwf	portHWrist1Pattern, A
	
	; Wrist roll backward (upper nibble, PORT H bits 4-7)
	movf	wrist2StepIndex, W, A
	addlw	0x03
	andlw	0x03
	movwf	wrist2StepIndex, A
	movf	wrist2StepIndex, W, A
	call	GetStepValue
	movwf	tempPattern, A
	swapf	tempPattern, W, A
	movwf	portHWrist2Pattern, A
	
	call	WritePortH
	return

; ============================================
; Both_StepForward: Step both motors forward simultaneously (interleaved)
; Steps claw motor, then base motor (no delay between)
; ============================================
Both_StepForward:
	call	Claw_StepForward	; Step claw motor first
	call	Base_StepForward	; Step base motor second
	return

; ============================================
; Both_StepBackward: Step both motors backward simultaneously (interleaved)
; Steps claw motor backward, then base motor backward (no delay between)
; ============================================
Both_StepBackward:
	call	Claw_StepBackward	; Step claw motor backward first
	call	Base_StepBackward	; Step base motor backward second
	return

; ============================================
; Motor_StepDelay: Delay between steps (~0.01 second = 100 steps/sec)
; Config: 16MHz crystal with PLL x4 enabled = 64MHz system clock
; Instruction cycle = 4 clocks, so instruction rate = 64MHz / 4 = 16 MIPS
; For ~0.01 second delay, need ~160,000 instruction cycles
; Using triple nested loop with simple 8-bit counters for reliability
; Each inner loop iteration: ~2 cycles (decf + bnz when taken)
; Need: 160,000 / 2 ≈ 80,000 iterations
; Calculation: 200 × 200 × 2 ≈ 80,000 iterations ≈ 160,000 cycles ≈ 0.01 seconds
; ============================================
Motor_StepDelay:
	; Outer loop: 200 iterations
	movlw	0xC8		; 200 decimal
	movwf	pauseOuter, A
	
delay_outer:
	; Middle loop: 200 iterations  
	movlw	0xC8		; 200 decimal
	movwf	pauseDelayH, A
	
delay_middle:
	; Inner loop: 2 iterations
	; This gives: 200 × 200 × 2 ≈ 80,000 iterations ≈ 160,000 cycles ≈ 0.01 seconds
	movlw	0x02		; 2 decimal
	movwf	stepDelayL, A
	
delay_loop:
	decf	stepDelayL, F, A
	bnz	delay_loop	; Continue inner loop if not zero
	
	; Middle loop iteration
	decf	pauseDelayH, F, A
	bnz	delay_middle	; Continue middle loop if not zero
	
	; Outer loop iteration
	decf	pauseOuter, F, A
	bnz	delay_outer	; Continue outer loop if not zero
	return

; ============================================
; Motor_StepDelaySlow: Slower delay for base motor (~0.03 second = 33 steps/sec)
; 3x slower than normal delay to help motor settle and reduce oscillation
; ============================================
Motor_StepDelaySlow:
	; Call normal delay 3 times for 3x slower speed
	call	Motor_StepDelay
	call	Motor_StepDelay
	call	Motor_StepDelay
	return

; ============================================
; Motor_StepDelayBase: Specific delay for Base motor (150 steps/min = 2.5 steps/sec)
; Delay = 1/2.5 = 0.4 seconds
; Normal delay is ~0.01s. Need ~40x normal delay.
; ============================================
Motor_StepDelayBase:
	movlw	0x28		; 40 decimal
	movwf	tempPattern3, A	; Use temp register as counter
base_delay_loop:
	call	Motor_StepDelay
	decf	tempPattern3, F, A
	bnz	base_delay_loop
	return

; ============================================
; Motor_StepsForward: Execute multiple steps forward on both motors
; Input: W = number of steps to execute
; Both motors step in synchronized interleaved fashion
; ============================================
Motor_StepsForward:
	movwf	stepCount, A	; Save step count
	
forward_loop:
	call	Both_StepForward	; Step both motors (interleaved)
	call	Motor_StepDelay		; Delay after both motors step
	decf	stepCount, F, A
	bnz	forward_loop	; Continue if not zero
	return

; ============================================
; Motor_StepsBackward: Execute multiple steps backward on both motors
; Input: W = number of steps to execute
; Both motors step in synchronized interleaved fashion
; ============================================
Motor_StepsBackward:
	movwf	stepCount, A	; Save step count
	
backward_loop:
	call	Both_StepBackward	; Step both motors backward (interleaved)
	call	Motor_StepDelay		; Delay after both motors step
	decf	stepCount, F, A
	bnz	backward_loop	; Continue if not zero
	return

; ============================================
; Base_StepsForward: Execute multiple steps forward on Base motor
; Input: W = number of steps to execute
; ============================================
Base_StepsForward:
	movwf	stepCount, A	; Save step count
	
base_forward_loop:
	call	Base_StepForward	; Step Base motor forward (full step)
	call	Motor_StepDelayBase	; Slow delay (150 steps/min)
	decf	stepCount, F, A
	bnz	base_forward_loop	; Continue if not zero
	return

; ============================================
; Base_StepsBackward: Execute multiple steps backward on Base motor
; Input: W = number of steps to execute
; ============================================
Base_StepsBackward:
	movwf	stepCount, A	; Save step count
	
base_backward_loop:
	call	Base_StepBackward	; Step Base motor backward (full step)
	call	Motor_StepDelayBase	; Slow delay (150 steps/min)
	decf	stepCount, F, A
	bnz	base_backward_loop	; Continue if not zero
	return

; ============================================
; Claw_StepsForward: Execute multiple steps forward on Claw motor
; Input: W = number of steps to execute
; ============================================
Claw_StepsForward:
	movwf	stepCount, A	; Save step count
	
claw_forward_loop:
	call	Claw_StepForward	; Step Claw motor forward
	call	Motor_StepDelay		; Delay after step
	decf	stepCount, F, A
	bnz	claw_forward_loop	; Continue if not zero
	return

; ============================================
; Claw_StepsBackward: Execute multiple steps backward on Claw motor
; Input: W = number of steps to execute
; ============================================
Claw_StepsBackward:
	movwf	stepCount, A	; Save step count
	
claw_backward_loop:
	call	Claw_StepBackward	; Step Claw motor backward
	call	Motor_StepDelay		; Delay after step
	decf	stepCount, F, A
	bnz	claw_backward_loop	; Continue if not zero
	return

; ============================================
; Shoulder_StepsForward: Execute multiple steps forward on Shoulder motor
; Input: W = number of steps to execute
; ============================================
Shoulder_StepsForward:
	movwf	stepCount, A	; Save step count
	
shoulder_forward_loop:
	call	Shoulder_StepForward	; Step Shoulder motor forward
	call	Motor_StepDelay		; Delay after step
	decf	stepCount, F, A
	bnz	shoulder_forward_loop	; Continue if not zero
	return

; ============================================
; Shoulder_StepsBackward: Execute multiple steps backward on Shoulder motor
; Input: W = number of steps to execute
; ============================================
Shoulder_StepsBackward:
	movwf	stepCount, A	; Save step count
	
shoulder_backward_loop:
	call	Shoulder_StepBackward	; Step Shoulder motor backward
	call	Motor_StepDelay		; Delay after step
	decf	stepCount, F, A
	bnz	shoulder_backward_loop	; Continue if not zero
	return

; ============================================
; Elbow_StepsForward: Execute multiple steps forward on Elbow motor
; Input: W = number of steps to execute
; ============================================
Elbow_StepsForward:
	movwf	stepCount, A	; Save step count
	
elbow_forward_loop:
	call	Elbow_StepForward	; Step Elbow motor forward
	call	Motor_StepDelay		; Delay after step
	decf	stepCount, F, A
	bnz	elbow_forward_loop	; Continue if not zero
	return

; ============================================
; Elbow_StepsBackward: Execute multiple steps backward on Elbow motor
; Input: W = number of steps to execute
; ============================================
Elbow_StepsBackward:
	movwf	stepCount, A	; Save step count
	
elbow_backward_loop:
	call	Elbow_StepBackward	; Step Elbow motor backward
	call	Motor_StepDelay		; Delay after step
	decf	stepCount, F, A
	bnz	elbow_backward_loop	; Continue if not zero
	return

; ============================================
; Wrist_StepsForward: Execute multiple steps forward on Wrist pitch and roll motors
; Input: W = number of steps to execute
; ============================================
Wrist_StepsForward:
	movwf	stepCount, A	; Save step count
	
wrist_forward_loop:
	call	Wrist_StepForward	; Step Wrist pitch and roll motors forward
	call	Motor_StepDelay		; Delay after step
	decf	stepCount, F, A
	bnz	wrist_forward_loop	; Continue if not zero
	return

; ============================================
; Wrist_StepsBackward: Execute multiple steps backward on Wrist pitch and roll motors
; Input: W = number of steps to execute
; ============================================
Wrist_StepsBackward:
	movwf	stepCount, A	; Save step count
	
wrist_backward_loop:
	call	Wrist_StepBackward	; Step Wrist pitch and roll motors backward
	call	Motor_StepDelay		; Delay after step
	decf	stepCount, F, A
	bnz	wrist_backward_loop	; Continue if not zero
	return

; ============================================
; Motor_Pause: Long pause between direction changes
; Provides visible pause for bidirectional test
; ============================================
Motor_Pause:
	movlw	0x05		; Outer loop counter
	movwf	pauseOuter, A
	
pause_outer:
	movlw	high(0xFFFF)	; High byte of delay
	movwf	pauseDelayH, A
	movlw	low(0xFFFF)	; Low byte of delay
	movwf	pauseDelayL, A
	
pause_inner:
	decf	pauseDelayL, F, A
	subwfb	pauseDelayH, F, A
	bc	pause_inner	; Continue inner loop
	
	decf	pauseOuter, F, A
	bnz	pause_outer	; Continue outer loop
	return

; ============================================
; Motor_BidirectionalTest: Test both motors with bidirectional rotation
; Rotates both Claw and Base motors forward, pauses, rotates back
; Step count controlled by BIDIR_TEST_STEPS constant
; Repeats continuously
; ============================================
Motor_BidirectionalTest:
	; Rotate forward (both motors in sync)
	movlw	BIDIR_TEST_STEPS	; Load step count from constant
	call	Motor_StepsForward
	
	; Pause between direction changes
	call	Motor_Pause
	
	; Rotate backward (return to start)
	movlw	BIDIR_TEST_STEPS	; Load step count from constant
	call	Motor_StepsBackward
	
	; Pause before next cycle
	call	Motor_Pause
	
	return

; ============================================
; Motor_SequentialDemo: Sequential demo of motor groups
; Cycles through Base, Claw, Shoulder, Elbow, and Wrist pitch+roll (together)
; Each motor group uses its configurable step count constant
; Repeats continuously
; ============================================
Motor_SequentialDemo:
	; Base: Forward
	movlw	BASE_STEPS	; Load Base step count
	call	Base_StepsForward
	call	Motor_Pause	; Pause between direction changes
	
	; Base: Backward
	movlw	BASE_STEPS	; Load Base step count
	call	Base_StepsBackward
	call	Motor_Pause	; Pause before next DOF
	
	; Claw: Forward
	movlw	CLAW_STEPS	; Load Claw step count
	call	Claw_StepsForward
	call	Motor_Pause	; Pause between direction changes
	
	; Claw: Backward
	movlw	CLAW_STEPS	; Load Claw step count
	call	Claw_StepsBackward
	call	Motor_Pause	; Pause before next DOF
	
	; Shoulder: Forward
	movlw	SHOULDER_STEPS	; Load Shoulder step count
	call	Shoulder_StepsForward
	call	Motor_Pause	; Pause between direction changes
	
	; Shoulder: Backward
	movlw	SHOULDER_STEPS	; Load Shoulder step count
	call	Shoulder_StepsBackward
	call	Motor_Pause	; Pause before next DOF

	; Elbow: Forward
	movlw	ELBOW_STEPS	; Load Elbow step count
	call	Elbow_StepsForward
	call	Motor_Pause	; Pause between direction changes
	
	; Elbow: Backward
	movlw	ELBOW_STEPS	; Load Elbow step count
	call	Elbow_StepsBackward
	call	Motor_Pause	; Pause before next DOF
	
	; Wrist: Forward
	movlw	WRIST_STEPS	; Load Wrist step count
	call	Wrist_StepsForward
	call	Motor_Pause	; Pause between direction changes
	
	; Wrist: Backward
	movlw	WRIST_STEPS	; Load Wrist step count
	call	Wrist_StepsBackward
	call	Motor_Pause	; Pause before next cycle
	
	return

	end
