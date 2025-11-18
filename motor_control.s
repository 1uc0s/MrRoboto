#include <xc.inc>
psect motor_code,class=CODE,reloc=2

; ============================================
; Multi-Motor Control Module for L298N Driver
; Unipolar Stepper Motor: 9904 112 35014 (6 terminals, 4-phase unipolar)
; Using L298N to drive individual coils (not as H-bridges)
; BASE MOTOR - PORT E bits 0-3 (RE0=Coil1, RE1=Coil2, RE2=Coil3, RE3=Coil4)
; CLAW MOTOR - PORT E bits 4-7 (RE4=Coil1, RE5=Coil2, RE6=Coil3, RE7=Coil4)
; ELBOW 1 - PORT H bits 4-7 (RH4=Coil1, RH5=Coil2, RH6=Coil3, RH7=Coil4)
; ELBOW 2 - PORT H bits 0-3 (RH0=Coil1, RH1=Coil2, RH2=Coil3, RH3=Coil4) - moves opposite
; WRIST 1 - PORT J bits 0-3 (RJ0=Coil1, RJ1=Coil2, RJ2=Coil3, RJ3=Coil4)
; WRIST 2 - PORT J bits 4-7 (RJ4=Coil1, RJ5=Coil2, RJ6=Coil3, RJ7=Coil4) - moves opposite
; ENA/ENB: Connected to +5V (always enabled)
; ============================================

; Configuration constants - step counts for each degree of freedom
BASE_STEPS	EQU	0x30	; 48 steps = 1 full rotation
CLAW_STEPS	EQU	0x30	; 48 steps = 1 full rotation
ELBOW_STEPS	EQU	0x30	; 48 steps = 1 full rotation
WRIST_STEPS	EQU	0x30	; 48 steps = 1 full rotation
BIDIR_TEST_STEPS	EQU	0x120	; 288 steps = 3 full rotations (legacy)

; Export functions for use in other modules
global	Motor_Init, Motor_BidirectionalTest, Motor_StepForward, Motor_StepBackward, Motor_StepsForward, Motor_StepsBackward, Motor_StepDelay
global	Motor_SequentialDemo, Motor_Pause
global	Claw_StepForward, Claw_StepBackward, Base_StepForward, Base_StepBackward
global	Base_StepsForward, Base_StepsBackward, Claw_StepsForward, Claw_StepsBackward
global	Elbow_StepForward, Elbow_StepBackward, Elbow_StepsForward, Elbow_StepsBackward
global	Wrist_StepForward, Wrist_StepBackward, Wrist_StepsForward, Wrist_StepsBackward

; Motor step sequence constants (unipolar wave drive - one coil at a time)
; According to Philips documentation: Wave drive sequence is 1→3→2→4
; Pin connections: RE0=Coil1, RE1=Coil2, RE2=Coil3, RE3=Coil4
STEP1	EQU	0x01	; Coil 1 ON, others OFF (RE0=1, RE1=0, RE2=0, RE3=0)
STEP2	EQU	0x04	; Coil 3 ON, others OFF (RE0=0, RE1=0, RE2=1, RE3=0)
STEP3	EQU	0x02	; Coil 2 ON, others OFF (RE0=0, RE1=1, RE2=0, RE3=0)
STEP4	EQU	0x08	; Coil 4 ON, others OFF (RE0=0, RE1=0, RE2=0, RE3=1)

; Memory allocation for motor control
clawStepIndex	EQU	0x0A	; Claw motor current step index (0-3)
baseStepIndex	EQU	0x0B	; Base motor current step index (0-3)
elbow1StepIndex	EQU	0x12	; Elbow 1 motor current step index (0-3)
elbow2StepIndex	EQU	0x13	; Elbow 2 motor current step index (0-3)
wrist1StepIndex	EQU	0x14	; Wrist 1 motor current step index (0-3)
wrist2StepIndex	EQU	0x15	; Wrist 2 motor current step index (0-3)
stepCount	EQU	0x0C	; Counter for number of steps to execute
stepDelayH	EQU	0x0D	; Delay counter high byte for step timing
stepDelayL	EQU	0x0E	; Delay counter low byte for step timing
pauseDelayH	EQU	0x0F	; Pause delay counter high byte
pauseDelayL	EQU	0x10	; Pause delay counter low byte
pauseOuter	EQU	0x11	; Outer loop counter for pause
tempPortE	EQU	0x16	; Temporary storage for PORT E manipulation
tempPortH	EQU	0x17	; Temporary storage for PORT H manipulation
tempPortJ	EQU	0x18	; Temporary storage for PORT J manipulation

; ============================================
; Motor_Init: Initialize all motors
; Sets all motors to step 0 (first position)
; ============================================
Motor_Init:
	; Initialize all step indices to 0
	movlw	0x00
	movwf	clawStepIndex, A	; Claw starts at step 0
	movwf	baseStepIndex, A	; Base starts at step 0
	movwf	elbow1StepIndex, A	; Elbow 1 starts at step 0
	movwf	elbow2StepIndex, A	; Elbow 2 starts at step 0
	movwf	wrist1StepIndex, A	; Wrist 1 starts at step 0
	movwf	wrist2StepIndex, A	; Wrist 2 starts at step 0
	
	; Initialize PORT E: Base (bits 0-3) and Claw (bits 4-7)
	movlw	STEP1
	movwf	tempPortE, A	; Base step pattern in bits 0-3
	swapf	tempPortE, W, A	; Shift to bits 4-7 for Claw
	iorwf	tempPortE, W, A	; Combine both
	movwf	PORTE, A	; Set both Base and Claw initial step position
	
	; Initialize PORT H: Elbow 1 (bits 4-7) and Elbow 2 (bits 0-3)
	movlw	STEP1
	movwf	tempPortH, A	; Elbow 2 step pattern in bits 0-3
	swapf	tempPortH, W, A	; Shift to bits 4-7 for Elbow 1
	iorwf	tempPortH, W, A	; Combine both
	movwf	PORTH, A	; Set both Elbow motors initial step position
	
	; Initialize PORT J: Wrist 1 (bits 0-3) and Wrist 2 (bits 4-7)
	movlw	STEP1
	movwf	tempPortJ, A	; Wrist 1 step pattern in bits 0-3
	swapf	tempPortJ, W, A	; Shift to bits 4-7 for Wrist 2
	iorwf	tempPortJ, W, A	; Combine both
	movwf	PORTJ, A	; Set both Wrist motors initial step position
	
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
; GetStepValue: Returns step pattern for given index
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
; Claw_StepForward: Execute one step forward on claw motor (PORT E bits 4-7)
; Advances to next step in sequence (0->1->2->3->0)
; Preserves Base motor state (bits 0-3)
; ============================================
Claw_StepForward:
	movf	clawStepIndex, W, A	; Load current step index
	addlw	0x01		; Increment step index
	andlw	0x03		; Wrap around (0-3)
	movwf	clawStepIndex, A	; Save new step index
	
	; Get step pattern for current index
	movf	clawStepIndex, W, A
	call	GetStepValue	; Get step pattern (bits 0-3)
	
	; Shift pattern to bits 4-7 for Claw
	swapf	WREG, W, A	; Shift left by 4 bits
	movwf	tempPortE, A	; Save shifted pattern
	
	; Read current PORT E and preserve Base (bits 0-3)
	movf	PORTE, W, A	; Read current PORT E
	andlw	0x0F		; Keep only Base bits (0-3)
	iorwf	tempPortE, W, A	; Combine with Claw pattern
	movwf	PORTE, A	; Write back to PORT E
	return

; ============================================
; Claw_StepBackward: Execute one step backward on claw motor (PORT E bits 4-7)
; Moves to previous step in sequence (0->3->2->1->0)
; Preserves Base motor state (bits 0-3)
; ============================================
Claw_StepBackward:
	movf	clawStepIndex, W, A	; Load current step index
	addlw	0x03		; Decrement by adding 3 (wraps correctly)
	andlw	0x03		; Wrap around (0-3)
	movwf	clawStepIndex, A	; Save new step index
	
	; Get step pattern for current index
	movf	clawStepIndex, W, A
	call	GetStepValue	; Get step pattern (bits 0-3)
	
	; Shift pattern to bits 4-7 for Claw
	swapf	WREG, W, A	; Shift left by 4 bits
	movwf	tempPortE, A	; Save shifted pattern
	
	; Read current PORT E and preserve Base (bits 0-3)
	movf	PORTE, W, A	; Read current PORT E
	andlw	0x0F		; Keep only Base bits (0-3)
	iorwf	tempPortE, W, A	; Combine with Claw pattern
	movwf	PORTE, A	; Write back to PORT E
	return

; ============================================
; Base_StepForward: Execute one step forward on base motor (PORT E bits 0-3)
; Advances to next step in sequence (0->1->2->3->0)
; Preserves Claw motor state (bits 4-7)
; ============================================
Base_StepForward:
	movf	baseStepIndex, W, A	; Load current step index
	addlw	0x01		; Increment step index
	andlw	0x03		; Wrap around (0-3)
	movwf	baseStepIndex, A	; Save new step index
	
	; Get step pattern for current index
	movf	baseStepIndex, W, A
	call	GetStepValue	; Get step pattern (bits 0-3)
	movwf	tempPortE, A	; Save Base pattern
	
	; Read current PORT E and preserve Claw (bits 4-7)
	movf	PORTE, W, A	; Read current PORT E
	andlw	0xF0		; Keep only Claw bits (4-7)
	iorwf	tempPortE, W, A	; Combine with Base pattern
	movwf	PORTE, A	; Write back to PORT E
	return

; ============================================
; Base_StepBackward: Execute one step backward on base motor (PORT E bits 0-3)
; Moves to previous step in sequence (0->3->2->1->0)
; Preserves Claw motor state (bits 4-7)
; ============================================
Base_StepBackward:
	movf	baseStepIndex, W, A	; Load current step index
	addlw	0x03		; Decrement by adding 3 (wraps correctly)
	andlw	0x03		; Wrap around (0-3)
	movwf	baseStepIndex, A	; Save new step index
	
	; Get step pattern for current index
	movf	baseStepIndex, W, A
	call	GetStepValue	; Get step pattern (bits 0-3)
	movwf	tempPortE, A	; Save Base pattern
	
	; Read current PORT E and preserve Claw (bits 4-7)
	movf	PORTE, W, A	; Read current PORT E
	andlw	0xF0		; Keep only Claw bits (4-7)
	iorwf	tempPortE, W, A	; Combine with Base pattern
	movwf	PORTE, A	; Write back to PORT E
	return

; ============================================
; Elbow1_StepForward: Execute one step forward on Elbow 1 (PORT H bits 4-7)
; Advances to next step in sequence (0->1->2->3->0)
; Preserves Elbow 2 motor state (bits 0-3)
; ============================================
Elbow1_StepForward:
	movf	elbow1StepIndex, W, A	; Load current step index
	addlw	0x01		; Increment step index
	andlw	0x03		; Wrap around (0-3)
	movwf	elbow1StepIndex, A	; Save new step index
	
	; Get step pattern for current index
	movf	elbow1StepIndex, W, A
	call	GetStepValue	; Get step pattern (bits 0-3)
	
	; Shift pattern to bits 4-7 for Elbow 1
	swapf	WREG, W, A	; Shift left by 4 bits
	movwf	tempPortH, A	; Save shifted pattern
	
	; Read current PORT H and preserve Elbow 2 (bits 0-3)
	movf	PORTH, W, A	; Read current PORT H
	andlw	0x0F		; Keep only Elbow 2 bits (0-3)
	iorwf	tempPortH, W, A	; Combine with Elbow 1 pattern
	movwf	PORTH, A	; Write back to PORT H
	return

; ============================================
; Elbow1_StepBackward: Execute one step backward on Elbow 1 (PORT H bits 4-7)
; Moves to previous step in sequence (0->3->2->1->0)
; Preserves Elbow 2 motor state (bits 0-3)
; ============================================
Elbow1_StepBackward:
	movf	elbow1StepIndex, W, A	; Load current step index
	addlw	0x03		; Decrement by adding 3 (wraps correctly)
	andlw	0x03		; Wrap around (0-3)
	movwf	elbow1StepIndex, A	; Save new step index
	
	; Get step pattern for current index
	movf	elbow1StepIndex, W, A
	call	GetStepValue	; Get step pattern (bits 0-3)
	
	; Shift pattern to bits 4-7 for Elbow 1
	swapf	WREG, W, A	; Shift left by 4 bits
	movwf	tempPortH, A	; Save shifted pattern
	
	; Read current PORT H and preserve Elbow 2 (bits 0-3)
	movf	PORTH, W, A	; Read current PORT H
	andlw	0x0F		; Keep only Elbow 2 bits (0-3)
	iorwf	tempPortH, W, A	; Combine with Elbow 1 pattern
	movwf	PORTH, A	; Write back to PORT H
	return

; ============================================
; Elbow2_StepForward: Execute one step forward on Elbow 2 (PORT H bits 0-3)
; Advances to next step in sequence (0->1->2->3->0)
; Preserves Elbow 1 motor state (bits 4-7)
; ============================================
Elbow2_StepForward:
	movf	elbow2StepIndex, W, A	; Load current step index
	addlw	0x01		; Increment step index
	andlw	0x03		; Wrap around (0-3)
	movwf	elbow2StepIndex, A	; Save new step index
	
	; Get step pattern for current index
	movf	elbow2StepIndex, W, A
	call	GetStepValue	; Get step pattern (bits 0-3)
	movwf	tempPortH, A	; Save Elbow 2 pattern
	
	; Read current PORT H and preserve Elbow 1 (bits 4-7)
	movf	PORTH, W, A	; Read current PORT H
	andlw	0xF0		; Keep only Elbow 1 bits (4-7)
	iorwf	tempPortH, W, A	; Combine with Elbow 2 pattern
	movwf	PORTH, A	; Write back to PORT H
	return

; ============================================
; Elbow2_StepBackward: Execute one step backward on Elbow 2 (PORT H bits 0-3)
; Moves to previous step in sequence (0->3->2->1->0)
; Preserves Elbow 1 motor state (bits 4-7)
; ============================================
Elbow2_StepBackward:
	movf	elbow2StepIndex, W, A	; Load current step index
	addlw	0x03		; Decrement by adding 3 (wraps correctly)
	andlw	0x03		; Wrap around (0-3)
	movwf	elbow2StepIndex, A	; Save new step index
	
	; Get step pattern for current index
	movf	elbow2StepIndex, W, A
	call	GetStepValue	; Get step pattern (bits 0-3)
	movwf	tempPortH, A	; Save Elbow 2 pattern
	
	; Read current PORT H and preserve Elbow 1 (bits 4-7)
	movf	PORTH, W, A	; Read current PORT H
	andlw	0xF0		; Keep only Elbow 1 bits (4-7)
	iorwf	tempPortH, W, A	; Combine with Elbow 2 pattern
	movwf	PORTH, A	; Write back to PORT H
	return

; ============================================
; Elbow_StepForward: Step both Elbow motors forward (Elbow 1 forward, Elbow 2 backward)
; Elbow 2 moves opposite to Elbow 1 for gear train synchronization
; ============================================
Elbow_StepForward:
	call	Elbow1_StepForward	; Step Elbow 1 forward
	call	Elbow2_StepBackward	; Step Elbow 2 backward (opposite direction)
	return

; ============================================
; Elbow_StepBackward: Step both Elbow motors backward (Elbow 1 backward, Elbow 2 forward)
; Elbow 2 moves opposite to Elbow 1 for gear train synchronization
; ============================================
Elbow_StepBackward:
	call	Elbow1_StepBackward	; Step Elbow 1 backward
	call	Elbow2_StepForward	; Step Elbow 2 forward (opposite direction)
	return

; ============================================
; Wrist1_StepForward: Execute one step forward on Wrist 1 (PORT J bits 0-3)
; Advances to next step in sequence (0->1->2->3->0)
; Preserves Wrist 2 motor state (bits 4-7)
; ============================================
Wrist1_StepForward:
	movf	wrist1StepIndex, W, A	; Load current step index
	addlw	0x01		; Increment step index
	andlw	0x03		; Wrap around (0-3)
	movwf	wrist1StepIndex, A	; Save new step index
	
	; Get step pattern for current index
	movf	wrist1StepIndex, W, A
	call	GetStepValue	; Get step pattern (bits 0-3)
	movwf	tempPortJ, A	; Save Wrist 1 pattern
	
	; Read current PORT J and preserve Wrist 2 (bits 4-7)
	movf	PORTJ, W, A	; Read current PORT J
	andlw	0xF0		; Keep only Wrist 2 bits (4-7)
	iorwf	tempPortJ, W, A	; Combine with Wrist 1 pattern
	movwf	PORTJ, A	; Write back to PORT J
	return

; ============================================
; Wrist1_StepBackward: Execute one step backward on Wrist 1 (PORT J bits 0-3)
; Moves to previous step in sequence (0->3->2->1->0)
; Preserves Wrist 2 motor state (bits 4-7)
; ============================================
Wrist1_StepBackward:
	movf	wrist1StepIndex, W, A	; Load current step index
	addlw	0x03		; Decrement by adding 3 (wraps correctly)
	andlw	0x03		; Wrap around (0-3)
	movwf	wrist1StepIndex, A	; Save new step index
	
	; Get step pattern for current index
	movf	wrist1StepIndex, W, A
	call	GetStepValue	; Get step pattern (bits 0-3)
	movwf	tempPortJ, A	; Save Wrist 1 pattern
	
	; Read current PORT J and preserve Wrist 2 (bits 4-7)
	movf	PORTJ, W, A	; Read current PORT J
	andlw	0xF0		; Keep only Wrist 2 bits (4-7)
	iorwf	tempPortJ, W, A	; Combine with Wrist 1 pattern
	movwf	PORTJ, A	; Write back to PORT J
	return

; ============================================
; Wrist2_StepForward: Execute one step forward on Wrist 2 (PORT J bits 4-7)
; Advances to next step in sequence (0->1->2->3->0)
; Preserves Wrist 1 motor state (bits 0-3)
; ============================================
Wrist2_StepForward:
	movf	wrist2StepIndex, W, A	; Load current step index
	addlw	0x01		; Increment step index
	andlw	0x03		; Wrap around (0-3)
	movwf	wrist2StepIndex, A	; Save new step index
	
	; Get step pattern for current index
	movf	wrist2StepIndex, W, A
	call	GetStepValue	; Get step pattern (bits 0-3)
	
	; Shift pattern to bits 4-7 for Wrist 2
	swapf	WREG, W, A	; Shift left by 4 bits
	movwf	tempPortJ, A	; Save shifted pattern
	
	; Read current PORT J and preserve Wrist 1 (bits 0-3)
	movf	PORTJ, W, A	; Read current PORT J
	andlw	0x0F		; Keep only Wrist 1 bits (0-3)
	iorwf	tempPortJ, W, A	; Combine with Wrist 2 pattern
	movwf	PORTJ, A	; Write back to PORT J
	return

; ============================================
; Wrist2_StepBackward: Execute one step backward on Wrist 2 (PORT J bits 4-7)
; Moves to previous step in sequence (0->3->2->1->0)
; Preserves Wrist 1 motor state (bits 0-3)
; ============================================
Wrist2_StepBackward:
	movf	wrist2StepIndex, W, A	; Load current step index
	addlw	0x03		; Decrement by adding 3 (wraps correctly)
	andlw	0x03		; Wrap around (0-3)
	movwf	wrist2StepIndex, A	; Save new step index
	
	; Get step pattern for current index
	movf	wrist2StepIndex, W, A
	call	GetStepValue	; Get step pattern (bits 0-3)
	
	; Shift pattern to bits 4-7 for Wrist 2
	swapf	WREG, W, A	; Shift left by 4 bits
	movwf	tempPortJ, A	; Save shifted pattern
	
	; Read current PORT J and preserve Wrist 1 (bits 0-3)
	movf	PORTJ, W, A	; Read current PORT J
	andlw	0x0F		; Keep only Wrist 1 bits (0-3)
	iorwf	tempPortJ, W, A	; Combine with Wrist 2 pattern
	movwf	PORTJ, A	; Write back to PORT J
	return

; ============================================
; Wrist_StepForward: Step both Wrist motors forward (Wrist 1 forward, Wrist 2 backward)
; Wrist 2 moves opposite to Wrist 1 for gear train synchronization
; ============================================
Wrist_StepForward:
	call	Wrist1_StepForward	; Step Wrist 1 forward
	call	Wrist2_StepBackward	; Step Wrist 2 backward (opposite direction)
	return

; ============================================
; Wrist_StepBackward: Step both Wrist motors backward (Wrist 1 backward, Wrist 2 forward)
; Wrist 2 moves opposite to Wrist 1 for gear train synchronization
; ============================================
Wrist_StepBackward:
	call	Wrist1_StepBackward	; Step Wrist 1 backward
	call	Wrist2_StepForward	; Step Wrist 2 forward (opposite direction)
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
	call	Base_StepForward	; Step Base motor forward
	call	Motor_StepDelay		; Delay after step
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
	call	Base_StepBackward	; Step Base motor backward
	call	Motor_StepDelay		; Delay after step
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
; Elbow_StepsForward: Execute multiple steps forward on Elbow motors
; Input: W = number of steps to execute
; ============================================
Elbow_StepsForward:
	movwf	stepCount, A	; Save step count
	
elbow_forward_loop:
	call	Elbow_StepForward	; Step Elbow motors forward
	call	Motor_StepDelay		; Delay after step
	decf	stepCount, F, A
	bnz	elbow_forward_loop	; Continue if not zero
	return

; ============================================
; Elbow_StepsBackward: Execute multiple steps backward on Elbow motors
; Input: W = number of steps to execute
; ============================================
Elbow_StepsBackward:
	movwf	stepCount, A	; Save step count
	
elbow_backward_loop:
	call	Elbow_StepBackward	; Step Elbow motors backward
	call	Motor_StepDelay		; Delay after step
	decf	stepCount, F, A
	bnz	elbow_backward_loop	; Continue if not zero
	return

; ============================================
; Wrist_StepsForward: Execute multiple steps forward on Wrist motors
; Input: W = number of steps to execute
; ============================================
Wrist_StepsForward:
	movwf	stepCount, A	; Save step count
	
wrist_forward_loop:
	call	Wrist_StepForward	; Step Wrist motors forward
	call	Motor_StepDelay		; Delay after step
	decf	stepCount, F, A
	bnz	wrist_forward_loop	; Continue if not zero
	return

; ============================================
; Wrist_StepsBackward: Execute multiple steps backward on Wrist motors
; Input: W = number of steps to execute
; ============================================
Wrist_StepsBackward:
	movwf	stepCount, A	; Save step count
	
wrist_backward_loop:
	call	Wrist_StepBackward	; Step Wrist motors backward
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
; Motor_SequentialDemo: Sequential demo of all 4 degrees of freedom
; Cycles through Base, Claw, Elbow, and Wrist with forward/backward motion
; Each DOF uses its configurable step count constant
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
