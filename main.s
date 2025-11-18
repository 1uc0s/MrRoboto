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
		; PORT E: Base Motor (bits 0-3) and Claw Motor (bits 4-7)
		; PORT H: Elbow 1 Motor (bits 4-7) and Elbow 2 Motor (bits 0-3)
		; PORT J: Wrist 1 Motor (bits 0-3) and Wrist 2 Motor (bits 4-7)
		movlw	0x00
		movwf	TRISE, A    ; setup E as output (Base and Claw motors)
		movlw	0x00
		movwf	TRISH, A    ; setup H as output (Elbow motors)
		movlw	0x00
		movwf	TRISJ, A    ; setup J as output (Wrist motors)
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