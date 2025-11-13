#include <xc.inc>

extrn	Motor_Init, Motor_StepForward, Motor_StepDelay  ; external subroutines

psect code, abs
main:
		org 0x0
		goto	setup
		
		org 0x100			    ; Main code starts here at address 0x100

		; ******* Programme FLASH read Setup Code ****  
setup:		
		bcf		CFGS	; point to Flash program memory  
		bsf		EEPGD		; access Flash program memory
		movlw	0x00
		movwf	TRISH, A    ; setup H as an output 
		movlw	0x00
		movwf	TRISF, A    ; setup F as an output
		movlw	0x00
		movwf	TRISG, A    ; setup G as an output
		movlw	0x00
		movwf	TRISE, A    ; setup E as an output (for motor control testing)
		align	2			; ensure alignment of subsequent instructions
		; ******* Motor Control Setup *********************
		call	Motor_Init		; Initialize motor control
		goto	start

start:		
		; Main loop: Continuous forward stepping (~1 step per second)
loop:	
		call	Motor_StepForward	; Execute one step forward
		call	Motor_StepDelay		; Wait ~1 second
		bra		loop			; Loop forever (continuous forward movement)
		; SPI and delay functions removed - now using motor_control.s module
	
	end main