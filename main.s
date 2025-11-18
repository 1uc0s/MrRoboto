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
		; PORT F: Wrist 1 Motor (bits 0-3) and Wrist 2 Motor (bits 4-7)
		
		; Configure PORT F as digital I/O (disable analog functions)
		; ANCON1 controls PORT F analog/digital mode (not in access RAM)
		movlb	0x0F		; Set BSR to bank 15 (0x0F) for ANCON1 access
		; ANCON1 bits 0-7 control RF0-RF7: 0 = Digital, 1 = Analog
		; Clear all bits to set PORT F as digital
		movlw	0x00
		movwf	ANCON1, A	; Set all PORT F pins to digital mode
		movlb	0x00		; Restore BSR to bank 0
		
		; Configure all ports as outputs
		movlw	0x00
		movwf	TRISD, A    ; setup D as output (Claw and Base motors)
		movlw	0x00
		movwf	TRISE, A    ; setup E as output (Elbow motors)
		movlw	0x00
		movwf	TRISF, A    ; setup F as output (Wrist motors)
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