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
		; PORT E: Elbow 2 Motor (bits 0-3) and Elbow 1 Motor (bits 4-7)
		; PORT H: Wrist 1 Motor (bits 0-3) and Wrist 2 Motor (bits 4-7)
		movlw	0x00
		movwf	TRISD, A    ; setup D as output (Claw and Base motors)
		movlw	0x00
		movwf	TRISE, A    ; setup E as output (Elbow motors)
		movlw	0x00
		movwf	TRISH, A    ; setup H as output (Wrist motors)
		align	2			; ensure alignment of subsequent instructions
		
		; ******* Motor Control Setup *********************
		call	Motor_Init		; Initialize all motors (Base, Claw, Elbow, Wrist)
		goto	start

start:		
		; Main loop: Run sequential demo continuously
		; Cycles through all 4 degrees of freedom (Base, Claw, Elbow, Wrist)
loop:	
		call	Motor_SequentialDemo	; Execute sequential demo on all DOFs
		bra		loop			; Loop forever
	
	end main