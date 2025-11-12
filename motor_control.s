#include <xc.inc>
psect code, abs

; ============================================
; Motor Control Module for L298N Driver
; Unipolar Stepper Motor: 9904 112 35014
; Control Pins: PORT F (RF0=IN1, RF1=IN2, RF2=IN3, RF3=IN4)
; ENA/ENB: Connected to +5V (always enabled)
; ============================================

; Export functions for use in other modules
global	Motor_Init, Motor_BidirectionalTest, Motor_StepForward, Motor_StepBackward, Motor_StepsForward, Motor_StepsBackward

; Motor step sequence constants (unipolar wave drive)
; Each step energizes one phase at a time
STEP1	EQU	0x01	; IN1=1, others=0 (RF0=1, RF1=0, RF2=0, RF3=0)
STEP2	EQU	0x04	; IN3=1, others=0 (RF0=0, RF1=0, RF2=1, RF3=0)
STEP3	EQU	0x02	; IN2=1, others=0 (RF0=0, RF1=1, RF2=0, RF3=0)
STEP4	EQU	0x08	; IN4=1, others=0 (RF0=0, RF1=0, RF2=0, RF3=1)

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
; Sets PORT F as output and initializes motor to step 0
; ============================================
Motor_Init:
	; PORT F is already configured as output in main.s setup
	; Initialize motor to first step position
	movlw	0x00
	movwf	stepIndex, A	; Start at step 0
	movlw	STEP1
	movwf	PORTF, A	; Set initial step position
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
	movwf	PORTF, A	; Output step pattern to PORT F
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
	movwf	PORTF, A	; Output step pattern to PORT F
	return

; ============================================
; GetStepValue: Returns step pattern for given index
; Input: W = step index (0-3)
; Output: W = step pattern value
; ============================================
GetStepValue:
	; Create jump table for step values
	addwf	PCL, F, A	; Add offset to program counter
	retlw	STEP1		; Index 0
	retlw	STEP2		; Index 1
	retlw	STEP3		; Index 2
	retlw	STEP4		; Index 3

; ============================================
; Motor_StepDelay: Delay between steps
; Provides safe timing to prevent motor stalling
; Adjustable delay (currently ~10ms at 16MHz)
; ============================================
Motor_StepDelay:
	movlw	high(0x0FFF)	; High byte of delay counter
	movwf	stepDelayH, A
	movlw	low(0x0FFF)	; Low byte of delay counter
	movwf	stepDelayL, A
	
delay_loop:
	decf	stepDelayL, F, A
	subwfb	stepDelayH, F, A
	bc	delay_loop	; Continue if not zero
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

