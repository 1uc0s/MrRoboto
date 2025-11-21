; ==============================================================================
; UART Echo Test - Simple Byte Echo for Serial Communication Testing
; ==============================================================================
; Purpose: Test basic UART communication by echoing received bytes
; 
; This is a minimal test program that:
; - Initializes UART at 9600 baud, 8N1
; - Receives bytes via RX interrupt
; - Immediately transmits the same byte back (echo)
; - No command parsing, no buffers
;
; Use this to verify:
; - COM port is correct (Windows: COM3, macOS: /dev/tty.usbserial-xxx)
; - Baud rate is correct (9600)
; - Hardware switches are ON (SW5.1 and SW5.2 on EasyPIC Pro 7)
; - USB cable is connected
; - FTDI drivers are installed
;
; Testing:
; 1. Build and program this to PIC18F87K22
; 2. Python: robot> echo 10
; 3. RealTerm: Type characters and see them echoed back
;
; Expected result: 100% echo success rate
; ==============================================================================

#include <xc.inc>

psect code, abs

; ==============================================================================
; Reset Vector
; ==============================================================================
org 0x0
    goto    setup
    
; ==============================================================================
; High Priority Interrupt Vector
; ==============================================================================
org 0x08
    goto    isr

; ==============================================================================
; Setup: Initialize UART
; ==============================================================================
setup:
    ; Disable UART first
    bcf     SPEN            ; Serial port disable
    
    ; Configure baud rate for 9600 @ 16MHz
    ; SPBRG = (FOSC / (64 * Baud)) - 1
    ; SPBRG = (16000000 / (64 * 9600)) - 1 = 25.04 ≈ 25
    ; Using 103 for better accuracy (confirmed working value)
    movlw   103
    movwf   SPBRG1, A
    
    bcf     BRGH            ; Low speed mode
    bcf     BRG16           ; 8-bit baud rate generator
    
    ; Configure TX pin (RC6)
    bcf     TRISC, 6, A     ; RC6 = TX1 as output
    bsf     TXEN            ; Enable transmitter
    
    ; Configure RX pin (RC7)
    bsf     TRISC, 7, A     ; RC7 = RX1 as input
    bsf     CREN            ; Enable continuous receive
    
    ; Enable UART
    bsf     SPEN            ; Serial port enable
    
    ; Enable interrupts
    bsf     RC1IE           ; Enable USART1 receive interrupt
    bsf     PEIE            ; Enable peripheral interrupts
    bsf     GIE             ; Enable global interrupts
    
; ==============================================================================
; Main Loop: Idle (all work done in interrupt)
; ==============================================================================
loop:
    nop                     ; Do nothing
    bra     loop            ; Loop forever

; ==============================================================================
; Interrupt Service Routine: Echo received byte
; ==============================================================================
isr:
    ; Check if this is a UART RX interrupt
    btfss   RC1IF           ; Check RX interrupt flag
    retfie                  ; Not RX interrupt, return
    
    ; Read received byte (clears RC1IF automatically)
    movf    RCREG1, W, A    ; Read byte into W
    
    ; Check for and clear any receive errors
    btfsc   OERR            ; Check overrun error
    bcf     CREN            ; Clear by disabling receiver
    btfsc   OERR
    bsf     CREN            ; Re-enable receiver
    
    btfsc   FERR            ; Check framing error
    movf    RCREG1, W, A    ; Clear by reading RCREG
    
    ; Wait for transmit buffer to be ready
wait_tx:
    btfss   TRMT            ; Check if transmit shift register empty
    bra     wait_tx         ; Wait until ready
    
    ; Echo the byte back
    movwf   TXREG1, A       ; Write byte to transmit register
    
    ; Interrupt flag cleared automatically by reading RCREG
    ; If not cleared, clear it manually
    bcf     RC1IF           ; Clear RX interrupt flag
    
    retfie                  ; Return from interrupt

end

