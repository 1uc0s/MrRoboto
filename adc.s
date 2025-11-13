#include <xc.inc>
psect adc_code,class=CODE,reloc=2

; ============================================
; ADC Module for Joystick Control
; Reads analog inputs from RA0 (AN0, X-axis) and RA1 (AN1, Y-axis)
; 12-bit ADC with 4.096V internal reference
; Result: 12-bit value in ADRESH:ADRESL (right-justified)
; Resolution: 1 mV per bit (4.096V / 4096 = 1 mV)
; Maximum value: 0x0FFF (4095 decimal) = 4.095V
; ============================================

; Export functions for use in other modules
global	ADC_Setup, ADC_Read_AN0, ADC_Read_AN1

; ============================================
; ADC_Setup: Initialize ADC for AN0 and AN1
; Configures TRISA, ANSEL0, ADCON0, ADCON1, ADCON2
; Sets up both RA0 (AN0) and RA1 (AN1) as analog inputs
; ============================================
ADC_Setup:
	; Configure TRISA bits 0 and 1 as inputs (RA0 and RA1)
	bsf	TRISA, PORTA_RA0_POSN, A	; pin RA0==AN0 input
	bsf	TRISA, PORTA_RA1_POSN, A	; pin RA1==AN1 input
	
	; ANCON0 is not in access RAM, need to set bank to 15 (0x0F)
	movlb	0x0f			; Set BSR to bank 15 for ANCON0 access
	
	; Set ANCON0 bits to enable analog mode
	; ANCON0 bit 0 (ANSEL0) enables AN0, bit 1 (ANSEL1) enables AN1
	bsf	ANCON0, 0, A		; set AN0 to analog
	bsf	ANCON0, 1, A		; set AN1 to analog
	
	; Restore BSR to bank 0 for ADCON registers (they are in access RAM)
	movlb	0x00			; Restore BSR to bank 0
	
	; Configure ADCON0: select AN0 initially, enable ADC
	; ADCON0 bit 7 (ADON): ADC enable = 1
	; ADCON0 bits 4:0 (CHS<4:0>): Channel select = 00001 (AN0)
	; Value: 0x81 = 10000001 (ADON=1, CHS=00001)
	movlw	0x81			; select AN0 for measurement and turn ADC on
	movwf	ADCON0, A		; write to ADCON0
	
	; Configure ADCON1: voltage reference configuration
	; ADCON1 bits 5:4 (VCFG<1:0>): 11 = Internal VREF+ (4.096V)
	; ADCON1 bits 1:0 (VNCFG<1:0>): 00 = VSS (0V) for negative reference
	; Value: 0x30 = 00110000
	movlw	0x30			; Select 4.096V positive reference
	movwf	ADCON1, A		; 0V for -ve reference and -ve input
	
	; Configure ADCON2: data format and clock selection
	; ADCON2 bit 7 (ADFM): 1 = Right justified output
	; ADCON2 bits 6:4 (ACQT<2:0>): 111 = 20 TAD acquisition time
	; ADCON2 bits 2:0 (ADCS<2:0>): 110 = Fosc/64 clock
	; Value: 0xF6 = 11110110
	movlw	0xF6			; Right justified output
	movwf	ADCON2, A		; Fosc/64 clock and acquisition times
	
	return

; ============================================
; ADC_Read_AN0: Read analog value from AN0 (RA0, X-axis)
; Selects AN0 channel, starts conversion, waits for completion
; Result: 12-bit value in ADRESH:ADRESL (right-justified)
; ADRESH contains bits 11-8, ADRESL contains bits 7-0
; ============================================
ADC_Read_AN0:
	; Select AN0 channel in ADCON0
	; ADCON0 bits 4:0 (CHS<4:0>): Channel select = 00001 (AN0)
	; Keep ADON bit set (bit 7 = 1)
	; Value: 0x81 = 10000001
	movlw	0x81			; select AN0 for measurement
	movwf	ADCON0, A		; write to ADCON0 (keeps ADC enabled)
	
	; Start conversion by setting GO bit (ADCON0 bit 1)
	bsf	ADCON0, 1, A		; Start conversion by setting GO bit
	
	; Wait for conversion to complete (poll GO bit)
	; GO bit clears automatically when conversion is done
adc_loop_an0:
	btfsc	ADCON0, 1, A		; check to see if finished (GO bit cleared = done)
	bra	adc_loop_an0		; loop if still converting
	
	; Conversion complete, result is in ADRESH:ADRESL
	return

; ============================================
; ADC_Read_AN1: Read analog value from AN1 (RA1, Y-axis)
; Selects AN1 channel, starts conversion, waits for completion
; Result: 12-bit value in ADRESH:ADRESL (right-justified)
; ADRESH contains bits 11-8, ADRESL contains bits 7-0
; ============================================
ADC_Read_AN1:
	; Select AN1 channel in ADCON0
	; ADCON0 bits 4:0 (CHS<4:0>): Channel select = 00101 (AN1)
	; Keep ADON bit set (bit 7 = 1)
	; Value: 0x85 = 10000101
	movlw	0x85			; select AN1 for measurement
	movwf	ADCON0, A		; write to ADCON0 (keeps ADC enabled)
	
	; Start conversion by setting GO bit (ADCON0 bit 1)
	bsf	ADCON0, 1, A		; Start conversion by setting GO bit
	
	; Wait for conversion to complete (poll GO bit)
	; GO bit clears automatically when conversion is done
adc_loop_an1:
	btfsc	ADCON0, 1, A		; check to see if finished (GO bit cleared = done)
	bra	adc_loop_an1		; loop if still converting
	
	; Conversion complete, result is in ADRESH:ADRESL
	return

	end

