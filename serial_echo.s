; ==============================================================================
; Serial Echo Test - Standalone
; ==============================================================================
; Hardware: PIC18F87K22 on EasyPIC Pro v7
; Crystal: 16MHz
; Configuration: HS Oscillator + PLL Enabled -> 64MHz System Clock
; UART: 9600 Baud, 8N1
; 
; Connections:
; - RC6 (TX1) -> USB-UART RX
; - RC7 (RX1) -> USB-UART TX
; - SW5.1 and SW5.2 MUST be ON
; ==============================================================================

#include <xc.inc>

; ==============================================================================
; Configuration Bits (Exact copy from working config.s)
; ==============================================================================

; CONFIG1L
  CONFIG  RETEN = ON            ; VREG Sleep Enable bit (Enabled)
  CONFIG  INTOSCSEL = HIGH      ; LF-INTOSC Low-power Enable bit (LF-INTOSC in High-power mode during Sleep)
  CONFIG  SOSCSEL = DIG         ; SOSC Power Selection and mode Configuration bits (Digital IO selected)
  CONFIG  XINST = OFF           ; Extended Instruction Set (Disabled)

; CONFIG1H
  CONFIG  FOSC = HS1            ; Oscillator (HS oscillator (Medium power, 4 MHz - 16 MHz))
  CONFIG  PLLCFG = ON           ; PLL x4 Enable bit (Enabled)
  CONFIG  FCMEN = OFF           ; Fail-Safe Clock Monitor (Disabled)
  CONFIG  IESO = OFF            ; Internal External Oscillator Switch Over Mode (Disabled)

; CONFIG2L
  CONFIG  PWRTEN = OFF          ; Power Up Timer (Disabled)
  CONFIG  BOREN = SBORDIS       ; Brown Out Detect (Enabled in hardware, SBOREN disabled)
  CONFIG  BORV = 3              ; Brown-out Reset Voltage bits (1.8V)
  CONFIG  BORPWR = ZPBORMV      ; BORMV Power level (ZPBORMV instead of BORMV is selected)

; CONFIG2H
  CONFIG  WDTEN = OFF		; Watchdog Timer (WDT enabled in hardware; SWDTEN bit disabled)
  CONFIG  WDTPS = 1048576       ; Watchdog Postscaler (1:1048576)

; CONFIG3L
  CONFIG  RTCOSC = SOSCREF      ; RTCC Clock Select (RTCC uses SOSC)
  CONFIG  EASHFT = ON           ; External Address Shift bit (Address Shifting enabled)
  CONFIG  ABW = MM              ; Address Bus Width Select bits (8-bit address bus)
  CONFIG  BW = 16               ; Data Bus Width (16-bit external bus mode)
  CONFIG  WAIT = OFF            ; External Bus Wait (Disabled)

; CONFIG3H
  CONFIG  CCP2MX = PORTC        ; CCP2 Mux (RC1)
  CONFIG  ECCPMX = PORTE        ; ECCP Mux (Enhanced CCP1/3 [P1B/P1C/P3B/P3C] muxed with RE6/RE5/RE4/RE3)
  CONFIG  MSSPMSK = 1		; MSSP address masking (7 Bit address masking mode)
  CONFIG  MCLRE = ON            ; Master Clear Enable (MCLR Enabled, RG5 Disabled)

; CONFIG4L
  CONFIG  STVREN = ON           ; Stack Overflow Reset (Enabled)
  CONFIG  BBSIZ = BB2K          ; Boot Block Size (2K word Boot Block size)

; CONFIG5L
  CONFIG  CP0 = OFF             ; Code Protect 00800-03FFF (Disabled)
  CONFIG  CP1 = OFF             ; Code Protect 04000-07FFF (Disabled)
  CONFIG  CP2 = OFF             ; Code Protect 08000-0BFFF (Disabled)
  CONFIG  CP3 = OFF             ; Code Protect 0C000-0FFFF (Disabled)
  CONFIG  CP4 = OFF             ; Code Protect 10000-13FFF (Disabled)
  CONFIG  CP5 = OFF             ; Code Protect 14000-17FFF (Disabled)
  CONFIG  CP6 = OFF             ; Code Protect 18000-1BFFF (Disabled)
  CONFIG  CP7 = OFF             ; Code Protect 1C000-1FFFF (Disabled)

; CONFIG5H
  CONFIG  CPB = OFF             ; Code Protect Boot (Disabled)
  CONFIG  CPD = OFF             ; Data EE Read Protect (Disabled)

; CONFIG6L
  CONFIG  WRT0 = OFF            ; Table Write Protect 00800-03FFF (Disabled)
  CONFIG  WRT1 = OFF            ; Table Write Protect 04000-07FFF (Disabled)
  CONFIG  WRT2 = OFF            ; Table Write Protect 08000-0BFFF (Disabled)
  CONFIG  WRT3 = OFF            ; Table Write Protect 0C000-0FFFF (Disabled)
  CONFIG  WRT4 = OFF            ; Table Write Protect 10000-13FFF (Disabled)
  CONFIG  WRT5 = OFF            ; Table Write Protect 14000-17FFF (Disabled)
  CONFIG  WRT6 = OFF            ; Table Write Protect 18000-1BFFF (Disabled)
  CONFIG  WRT7 = OFF            ; Table Write Protect 1C000-1FFFF (Disabled)

; CONFIG6H
  CONFIG  WRTC = OFF            ; Config. Write Protect (Disabled)
  CONFIG  WRTB = OFF            ; Table Write Protect Boot (Disabled)
  CONFIG  WRTD = OFF            ; Data EE Write Protect (Disabled)

; CONFIG7L
  CONFIG  EBRT0 = OFF           ; Table Read Protect 00800-03FFF (Disabled)
  CONFIG  EBRT1 = OFF           ; Table Read Protect 04000-07FFF (Disabled)
  CONFIG  EBRT2 = OFF           ; Table Read Protect 08000-0BFFF (Disabled)
  CONFIG  EBRT3 = OFF           ; Table Read Protect 0C000-0FFFF (Disabled)
  CONFIG  EBRT4 = OFF           ; Table Read Protect 10000-13FFF (Disabled)
  CONFIG  EBRT5 = OFF           ; Table Read Protect 14000-17FFF (Disabled)
  CONFIG  EBRT6 = OFF           ; Table Read Protect 18000-1BFFF (Disabled)
  CONFIG  EBRT7 = OFF           ; Table Read Protect 1C000-1FFFF (Disabled)

; CONFIG7H
  CONFIG  EBRTB = OFF           ; Table Read Protect Boot (Disabled)

; ==============================================================================
; Reset and Interrupt Vectors
; ==============================================================================
psect code, abs
org 0x0000
    goto    setup

org 0x0008
    goto    isr

; ==============================================================================
; Setup Routine
; ==============================================================================
setup:
    ; 1. Initialize Visual Debugging (RA0 LED)
    bcf     TRISA, 0, A     ; Set RA0 as output (LED)
    bcf     LATA, 0, A      ; Turn LED OFF initially

    ; 2. Initialize UART1 (RC6=TX, RC7=RX)
    ; Formula: Baud = FOSC / (64 * (SPBRG + 1))
    ; Desired: 9600, FOSC: 64,000,000
    ; 9600 = 64,000,000 / (64 * (x + 1))
    ; 64 * (x + 1) = 6666.66
    ; x + 1 = 104.16
    ; x = 103.16 -> 103
    
    movlw   103             ; SPBRG for 9600 baud @ 64MHz (Low Speed)
    movwf   SPBRG1, A
    
    ; Configure UART Control Registers
    bcf     TXSTA1, 4, A    ; SYNC=0 (Asynchronous)
    bcf     TXSTA1, 2, A    ; BRGH=0 (Low Speed)
    bcf     BAUDCON1, 3, A  ; BRG16=0 (8-bit Generator)
    
    bsf     TXSTA1, 5, A    ; TXEN=1 (Enable Transmit)
    bsf     RCSTA1, 7, A    ; SPEN=1 (Serial Port Enable)
    bsf     RCSTA1, 4, A    ; CREN=1 (Continuous Receive Enable)
    
    ; Configure Pins
    bcf     TRISC, 6, A     ; RC6 as Output (TX)
    bsf     TRISC, 7, A     ; RC7 as Input (RX)

    ; 3. Enable Interrupts
    bsf     PIE1, 5, A      ; RC1IE (UART RX Interrupt Enable)
    bsf     INTCON, 6, A    ; PEIE (Peripheral Interrupt Enable)
    bsf     INTCON, 7, A    ; GIE (Global Interrupt Enable)

    ; Flash LED 3 times to indicate startup
    call    Startup_Flash

main_loop:
    goto    main_loop       ; Loop forever, ISR handles data

; ==============================================================================
; Interrupt Service Routine
; ==============================================================================
isr:
    ; Check if UART RX Interrupt
    btfss   PIR1, 5, A      ; RC1IF set?
    retfie                  ; No, return

    ; Check for Errors
    btfsc   RCSTA1, 1, A    ; OERR (Overrun Error)
    bra     handle_oerr
    btfsc   RCSTA1, 2, A    ; FERR (Framing Error)
    bra     handle_ferr

    ; Read Byte (Clears Interrupt Flag)
    movf    RCREG1, W, A
    
    ; Echo Byte Back immediately
    call    Transmit_Byte

    ; Toggle RA0 LED to show activity
    btg     LATA, 0, A

    retfie

handle_oerr:
    bcf     RCSTA1, 4, A    ; Clear CREN
    bsf     RCSTA1, 4, A    ; Set CREN
    retfie

handle_ferr:
    movf    RCREG1, W, A    ; Read to clear
    retfie

; ==============================================================================
; Helper Functions
; ==============================================================================
Transmit_Byte:
    ; Wait for TX buffer to be empty (TX1IF) instead of Shift Register (TRMT)
    ; This allows double-buffering (loading next byte while current is sending)
    btfss   PIR1, 4, A      ; TX1IF (PIR1 bit 4)
    bra     Transmit_Byte
    movwf   TXREG1, A       ; Send W
    return

Startup_Flash:
    movlw   3
    movwf   0x20, A         ; Use 0x20 as counter
flash_loop:
    bsf     LATA, 0, A      ; LED ON
    call    Delay_Long
    bcf     LATA, 0, A      ; LED OFF
    call    Delay_Long
    decfsz  0x20, F, A
    bra     flash_loop
    return

Delay_Long:                 ; Simple busy wait delay
    movlw   0xFF
    movwf   0x21, A
d1: movlw   0xFF
    movwf   0x22, A
d2: decfsz  0x22, F, A
    bra     d2
    decfsz  0x21, F, A
    bra     d1
    return

    end

