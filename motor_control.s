#include <xc.inc>
psect motor_code,class=CODE,reloc=2

; ============================================
; Motor Control Module for L298N Driver
; Unipolar Stepper Motor: 9904 112 35014 (6 terminals, 4-phase unipolar)
; Using L298N to drive individual coils (not as H-bridges)
; Control Pins: PORT E (RE0=Coil1, RE1=Coil2, RE2=Coil3, RE3=Coil4)
; ENA/ENB: Connected to +5V (always enabled)
; ============================================

; Export functions for use in other modules
global	Motor_Init, Motor_BidirectionalTest, Motor_StepForward, Motor_StepBackward, Motor_StepsForward, Motor_StepsBackward, Motor_StepDelay

; Motor step sequence constants (unipolar wave drive - one coil at a time)
; According to Philips documentation: Wave drive sequence is 1→3→2→4
; Pin connections: RE0=Coil1, RE1=Coil2, RE2=Coil3, RE3=Coil4
STEP1	EQU	0x01	; Coil 1 ON, others OFF (RE0=1, RE1=0, RE2=0, RE3=0)
STEP2	EQU	0x04	; Coil 3 ON, others OFF (RE0=0, RE1=0, RE2=1, RE3=0)
STEP3	EQU	0x02	; Coil 2 ON, others OFF (RE0=0, RE1=1, RE2=0, RE3=0)
STEP4	EQU	0x08	; Coil 4 ON, others OFF (RE0=0, RE1=0, RE2=0, RE3=1)

; Step counter for tracking current position in sequence
stepIndex	EQU	0x0A	; Current step index (0-3)
stepCount	EQU	0x0B	; Counter for number of steps to execute
stepDelayH	EQU	0x0C	; Delay counter high byte for step timing
stepDelayL	EQU	0x0D	; Delay counter low byte for step timing
pauseDelayH	EQU	0x0E	; Pause delay counter high byte
pauseDelayL	EQU	0x0F	; Pause delay counter low byte
pauseOuter	EQU	0x10	; Outer loop counter for pause

; ============================================
; Motor_Init: Initialize motor control
; Sets PORT E as output and initializes motor to step 0
; ============================================
Motor_Init:
	; PORT E is already configured as output in main.s setup
	; Initialize motor to first step position
	movlw	0x00
	movwf	stepIndex, A	; Start at step 0
	movlw	STEP1
	movwf	PORTE, A	; Set initial step position
	return

; ============================================
; Motor_StepForward: Execute one step forward
; Advances to next step in sequence (0->1->2->3->0)
; ============================================
Motor_StepForward:
	movf	stepIndex, W, A	; Load current step index
	addlw	0x01		; Increment step index
	andlw	0x03		; Wrap around (0-3)
	movwf	stepIndex, A	; Save new step index
	
	; Jump to appropriate step based on index
	movf	stepIndex, W, A
	call	GetStepValue	; Get step pattern for current index
	movwf	PORTE, A	; Output step pattern to PORT E
	return

; ============================================
; Motor_StepBackward: Execute one step backward
; Moves to previous step in sequence (0->3->2->1->0)
; ============================================
Motor_StepBackward:
	movf	stepIndex, W, A	; Load current step index
	addlw	0x03		; Decrement by adding 3 (wraps correctly)
	andlw	0x03		; Wrap around (0-3)
	movwf	stepIndex, A	; Save new step index
	
	; Jump to appropriate step based on index
	movf	stepIndex, W, A
	call	GetStepValue	; Get step pattern for current index
	movwf	PORTE, A	; Output step pattern to PORT E
	return

; ============================================
; GetStepValue: Returns step pattern for given index
; Input: W = step index (0-3)
; Output: W = step pattern value
; ============================================
GetStepValue:
	; Save W to temporary register for comparison
	movwf	stepDelayL, A	; Temporarily use stepDelayL to save W
	; Compare with 0
	movf	stepDelayL, W, A
	xorlw	0x00		; XOR with 0, sets Z if W==0
	bz	return_step1
	; Compare with 1
	movf	stepDelayL, W, A
	xorlw	0x01		; XOR with 1, sets Z if W==1
	bz	return_step2
	; Compare with 2
	movf	stepDelayL, W, A
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
; Motor_StepDelay: Delay between steps (~1 second = 1 step/sec)
; Config: 16MHz crystal with PLL x4 enabled = 64MHz system clock
; Instruction cycle = 4 clocks, so instruction rate = 64MHz / 4 = 16 MIPS
; For ~1 second delay, need ~16,000,000 instruction cycles
; Using triple nested loop with simple 8-bit counters for reliability
; Each inner loop iteration: ~2 cycles (decf + bnz when taken)
; Need: 16,000,000 / 2 ≈ 8,000,000 iterations
; Calculation: 250 × 250 × 128 ≈ 8,000,000 iterations ≈ 16,000,000 cycles ≈ 1.0 seconds
; ============================================
Motor_StepDelay:
	; Outer loop: 250 iterations
	movlw	0xFA		; 250 decimal
	movwf	pauseOuter, A
	
delay_outer:
	; Middle loop: 250 iterations  
	movlw	0xFA		; 250 decimal
	movwf	pauseDelayH, A
	
delay_middle:
	; Inner loop: 128 iterations (0x80)
	; This gives: 250 × 250 × 128 ≈ 8,000,000 iterations ≈ 16,000,000 cycles ≈ 1.0 seconds
	movlw	0x80		; 128 decimal
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
; Motor_StepsForward: Execute multiple steps forward
; Input: W = number of steps to execute
; ============================================
Motor_StepsForward:
	movwf	stepCount, A	; Save step count
	
forward_loop:
	call	Motor_StepForward
	call	Motor_StepDelay
	decf	stepCount, F, A
	bnz	forward_loop	; Continue if not zero
	return

; ============================================
; Motor_StepsBackward: Execute multiple steps backward
; Input: W = number of steps to execute
; ============================================
Motor_StepsBackward:
	movwf	stepCount, A	; Save step count
	
backward_loop:
	call	Motor_StepBackward
	call	Motor_StepDelay
	decf	stepCount, F, A
	bnz	backward_loop	; Continue if not zero
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
; Motor_BidirectionalTest: Test motor with bidirectional rotation
; Rotates forward 12 steps (90°), pauses, rotates back 12 steps
; Repeats continuously
; ============================================
Motor_BidirectionalTest:
	; Rotate forward 12 steps (90° rotation: 12 steps × 7.5° = 90°)
	movlw	0x0C		; 12 steps
	call	Motor_StepsForward
	
	; Pause between direction changes
	call	Motor_Pause
	
	; Rotate backward 12 steps (return to start)
	movlw	0x0C		; 12 steps
	call	Motor_StepsBackward
	
	; Pause before next cycle
	call	Motor_Pause
	
	return

	end
