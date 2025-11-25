#include <xc.inc>

extrn	Motor_Init, Motor_SequentialDemo  ; external subroutines
extrn	UART_Init, UART_RX_ISR  ; UART initialization and ISR functions

psect code, abs
main:
		org 0x0
		goto	setup
		
		org 0x08			; High priority interrupt vector
		goto	high_isr		; Jump to interrupt service routine
		
		org 0x100			    ; Main code starts here at address 0x100

		; ******* Programme FLASH read Setup Code ****  
setup:		
		bcf		CFGS	; point to Flash program memory  
		bsf		EEPGD		; access Flash program memory
		
		; ******* Disable Analog - Make All Pins Digital *******
		; PIC18F87K22 uses ANCON0/ANCON1 (NOT ADCON1) for analog pin control
		; RE0=AN5, RE1=AN6, RE2=AN7 - these MUST be digital for shoulder motor
		movlw	0xFF		; All bits = 1 = all pins digital
		movwf	ANCON0, A	; Make AN0-AN7 digital (includes RE0-RE2)
		movlw	0xFF		; All bits = 1 = all pins digital
		movwf	ANCON1, A	; Make AN8-AN15 digital
		
		; ******* Disable CCP/PWM modules that could interfere with PORT E *******
		; ECCPMX config muxes CCP to RE3-RE6, ensure CCP is disabled
		clrf	CCP1CON, A	; Disable CCP1 module
		clrf	CCP2CON, A	; Disable CCP2 module
		clrf	CCP3CON, A	; Disable CCP3 module
		
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
		
		; ******* UART Setup for Serial Communication ******
		call	UART_Init		; Initialize UART for serial commands (9600 baud, interrupts enabled)
		goto	start

start:		
		; Main loop: Wait for serial commands via UART interrupts
		; Commands handled by ISR
loop:	
		nop				; Idle - waiting for UART interrupts
		bra		loop			; Loop forever

; ==============================================================================
; Interrupt Service Routine (ISR)
; ==============================================================================
high_isr:
		; Check if this is UART RX interrupt
		btfsc	PIR1, 5, A		; Check UART1 RX interrupt flag (RC1IF)
		call	UART_RX_ISR		; Handle UART receive
		
		retfie				; Return from interrupt

	end main
