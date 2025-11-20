#include <xc.inc>

extrn	Motor_Init, Motor_SequentialDemo  ; external subroutines

psect code, abs
main:
		org 0x0
		goto	setup
		
		org 0x100			    ; Main code starts here at address 0x100

		; ******* Programme FLASH read Setup Code ****  
setup:		
		bcf		CFGS	; point to Flash program memory  
		bsf		EEPGD		; access Flash program memory
		
		; ******* Port Configuration (Motor Assignments) *******
		; PORT D: Claw Motor (bits 0-3) and Base Motor (bits 4-7)
		; PORT E: Shoulder Motor (bits 0-3) and Elbow Motor (bits 4-7)
		; PORT H: Wrist Pitch Motor (bits 0-3) and Wrist Roll Motor (bits 4-7)
		movlw	0x00
		movwf	TRISD, A    ; setup D as output (Claw and Base motors)
		movlw	0x00
		movwf	TRISE, A    ; setup E as output (Shoulder and Elbow motors)
		movlw	0x00
		movwf	TRISH, A    ; setup H as output (Wrist pitch and roll motors)
		align	2			; ensure alignment of subsequent instructions
		
		; ******* Motor Control Setup *********************
		call	Motor_Init		; Initialize all motors (Base, Shoulder, Elbow, Wrist pitch, Wrist roll, Claw)
		goto	start

start:		
		; Main loop: Run sequential demo continuously
		; Cycles through all degrees of freedom (Base, Shoulder, Elbow, Wrist pitch, Wrist roll, Claw)
loop:	
		call	Motor_SequentialDemo	; Execute sequential demo on all DOFs
		bra		loop			; Loop forever
	
	end main