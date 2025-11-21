#include <xc.inc>

extrn	Motor_Init, Motor_SequentialDemo  ; external subroutines
extrn	UART_Init  ; UART initialization function
; Note: UART_RX_ISR commented out - using direct echo in ISR for testing

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
		; Commands handled by ISR with simple echo for testing
loop:	
		; Sequential demo commented out - now using serial control
		; call	Motor_SequentialDemo	; Execute sequential demo on all DOFs
		nop				; Idle - waiting for UART interrupts
		bra		loop			; Loop forever

; ==============================================================================
; Interrupt Service Routine (ISR) - ECHO TEST MODE
; ==============================================================================
; This ISR implements simple byte echo for testing UART communication
; Once echo works, can be replaced with: call UART_RX_ISR
; ==============================================================================
high_isr:
		; Save context if needed (W, STATUS, BSR)
		; For simple echo test, not strictly necessary
		
		; Check if this is UART RX interrupt
		btfss	RC1IF		; Check UART1 RX interrupt flag
		retfie				; Not UART interrupt, return
		
		; Read received byte (clears RC1IF)
		movf	RCREG1, W, A	; Read byte into W
		
		; Check for receive errors
		btfsc	OERR		; Check overrun error
		bcf		CREN		; Clear by disabling receiver
		btfsc	OERR
		bsf		CREN		; Re-enable receiver
		
		btfsc	FERR		; Check framing error  
		movf	RCREG1, W, A	; Clear by reading RCREG
		
		; Wait for TX buffer ready
echo_wait:
		btfss	TRMT		; Check if transmit register empty
		bra		echo_wait	; Wait until ready
		
		; Echo byte back
		movwf	TXREG1, A	; Write to transmit register
		
		; Clear interrupt flag (usually cleared by read, but ensure)
		bcf		RC1IF
		
		retfie				; Return from interrupt

	end main