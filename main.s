#include <xc.inc>

extrn	Motor_Init, Motor_BidirectionalTest  ; external subroutines

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
		; PORT E: Claw Motor (single motor)
		; PORT F: Base Motor (single motor)
		; PORT G: Wrist Motors (pair - future expansion)
		; PORT H: Elbow Motors (pair - future expansion)
		movlw	0x00
		movwf	TRISH, A    ; setup H as output (Elbow motors - future)
		movlw	0x00
		movwf	TRISG, A    ; setup G as output (Wrist motors - future)
		movlw	0x00
		movwf	TRISF, A    ; setup F as output (Base motor)
		movlw	0x00
		movwf	TRISE, A    ; setup E as output (Claw motor)
		align	2			; ensure alignment of subsequent instructions
		
		; ******* Motor Control Setup *********************
		call	Motor_Init		; Initialize Claw and Base motors
		goto	start

start:		
		; Main loop: Run bidirectional motor test continuously
		; Tests both Claw (PORT E) and Base (PORT F) motors simultaneously
loop:	
		call	Motor_BidirectionalTest	; Execute bidirectional test on both motors
		bra		loop			; Loop forever
	
	end main