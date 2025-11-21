; ==============================================================================
; Serial Command Handler for Robot Arm Control
; ==============================================================================
; Receives commands from Python control software via UART
; Protocol:
;   MOVE <theta1> <theta2> <theta3> <theta4>  - Move to joint angles
;   STEP <steps1> <steps2> <steps3> <steps4>  - Move by step counts
;   HOME                                       - Move to home position
;   STOP                                       - Emergency stop
;   STATUS                                     - Report current angles
;   SPEED <value>                              - Set motor speed
;   CAL <joint> <steps>                        - Calibrate single joint
;
; Responses:
;   OK        - Command completed successfully
;   ERROR     - Command failed
;   STATUS <theta1> <theta2> <theta3> <theta4>  - Current joint angles
; ==============================================================================

#include <xc.inc>

; ==============================================================================
; Serial Communication Parameters
; ==============================================================================
BAUD_RATE       EQU     9600            ; Baud rate
FOSC            EQU     16000000        ; Oscillator frequency (16 MHz)

; UART Receive Buffer
UART_RX_BUFFER_SIZE EQU 64
UART_RX_BUFFER  EQU     0x100           ; Starting address for RX buffer
UART_RX_IDX     EQU     0xF0            ; Current index in RX buffer
UART_RX_COUNT   EQU     0xF1            ; Number of bytes in buffer

; Command parsing
CMD_BUFFER      EQU     0x140           ; Parsed command buffer (32 bytes)
CMD_TYPE        EQU     0xF2            ; Command type code
CMD_PARAM1      EQU     0xF3            ; First parameter (2 bytes)
CMD_PARAM2      EQU     0xF5            ; Second parameter (2 bytes)
CMD_PARAM3      EQU     0xF7            ; Third parameter (2 bytes)
CMD_PARAM4      EQU     0xF9            ; Fourth parameter (2 bytes)

; Command type codes
CMD_NONE        EQU     0x00
CMD_MOVE        EQU     0x01
CMD_STEP        EQU     0x02
CMD_HOME        EQU     0x03
CMD_STOP        EQU     0x04
CMD_STATUS      EQU     0x05
CMD_SPEED       EQU     0x06
CMD_CAL         EQU     0x07

; ==============================================================================
; UART Initialization
; ==============================================================================
psect serial_handler_code,class=CODE

UART_Init:
    ; Configure UART1 for 9600 baud, 8N1
    ; Assumes FOSC = 16 MHz
    
    ; Disable UART
    bcf	    SPEN		; Serial port disable
    
    ; Configure baud rate generator
    ; SPBRG = (FOSC / (64 * Baud)) - 1  for BRGH=0
    ; SPBRG = (16000000 / (64 * 9600)) - 1 = 25.04 ≈ 25
    movlw   25
    movwf   SPBRG1
    
    bcf	    BRGH		; Low speed baud rate
    bcf	    BRG16		; 8-bit baud rate generator
    
    ; Configure TX
    bcf     TRISC, 6		; RC6 = TX1 as output
    bsf	    TXEN		; Enable transmitter
    
    ; Configure RX
    bsf     TRISC, 7		; RC7 = RX1 as input
    bsf	    CREN		; Enable receiver
    
    ; Enable UART
    bsf	    SPEN		; Serial port enable
    
    ; Enable RX interrupt
    bsf	    RC1IE		; Enable UART1 receive interrupt
    bsf	    PEIE		; Enable peripheral interrupts
    bsf	    GIE			; Enable global interrupts
    
    ; Initialize buffer pointers
    clrf    UART_RX_IDX
    clrf    UART_RX_COUNT
    clrf    CMD_TYPE
    
    return

; ==============================================================================
; UART Receive Interrupt Handler
; ==============================================================================
; Call this from main ISR when RC1IF is set
; ==============================================================================
UART_RX_ISR:
    ; Check for receive errors
    btfsc   OERR		; Overrun error?
    call    UART_Clear_Errors
    
    btfsc   FERR		; Framing error?
    call    UART_Clear_Errors
    
    ; Read received byte
    movf    RCREG1, W               ; Read from receive register (clears RC1IF)
    
    ; Check for newline (command terminator)
    sublw   0x0A                    ; Compare with '\n'
    btfsc   STATUS, 2, A
    goto    UART_Process_Command    ; Complete command received
    
    ; Check for carriage return (also treat as newline)
    movf    RCREG1, W
    sublw   0x0D                    ; Compare with '\r'
    btfsc   STATUS, 2, A
    goto    UART_Process_Command
    
    ; Store byte in buffer if not full
    movf    UART_RX_COUNT, W
    sublw   UART_RX_BUFFER_SIZE - 1 ; Check if buffer full
    btfsc   STATUS, 0, A		; Carry clear = buffer full
    goto    UART_Store_Byte
    
    ; Buffer full, ignore byte
    return
    
UART_Store_Byte:
    ; Calculate buffer address
    movlw   HIGH UART_RX_BUFFER
    movwf   FSR0H
    movlw   LOW UART_RX_BUFFER
    addwf   UART_RX_IDX, W
    movwf   FSR0L
    
    ; Store byte
    movf    RCREG1, W
    movwf   INDF0
    
    ; Increment counters
    incf    UART_RX_IDX
    incf    UART_RX_COUNT
    
    return

UART_Clear_Errors:
    bcf	    CREN		; Disable receiver
    bsf	    CREN		; Re-enable receiver
    return

; ==============================================================================
; Process Received Command
; ==============================================================================
UART_Process_Command:
    ; Null-terminate buffer
    movlw   HIGH UART_RX_BUFFER
    movwf   FSR0H
    movlw   LOW UART_RX_BUFFER
    addwf   UART_RX_IDX, W
    movwf   FSR0L
    clrf    INDF0                   ; Add null terminator
    
    ; Parse command
    call    Parse_Command
    
    ; Execute command based on type
    movf    CMD_TYPE, W
    
    sublw   CMD_MOVE
    btfsc   STATUS, 2, A
    goto    Execute_Move
    
    movf    CMD_TYPE, W
    sublw   CMD_STEP
    btfsc   STATUS, 2, A
    goto    Execute_Step
    
    movf    CMD_TYPE, W
    sublw   CMD_HOME
    btfsc   STATUS, 2, A
    goto    Execute_Home
    
    movf    CMD_TYPE, W
    sublw   CMD_STOP
    btfsc   STATUS, 2, A
    goto    Execute_Stop
    
    movf    CMD_TYPE, W
    sublw   CMD_STATUS
    btfsc   STATUS, 2, A
    goto    Execute_Status
    
    movf    CMD_TYPE, W
    sublw   CMD_SPEED
    btfsc   STATUS, 2, A
    goto    Execute_Speed
    
    movf    CMD_TYPE, W
    sublw   CMD_CAL
    btfsc   STATUS, 2, A
    goto    Execute_Calibrate
    
    ; Unknown command
    call    UART_Send_Error
    goto    UART_Reset_Buffer

; ==============================================================================
; Parse Command String
; ==============================================================================
Parse_Command:
    ; Reset command type
    clrf    CMD_TYPE
    
    ; Check for "MOVE"
    movlw   HIGH UART_RX_BUFFER
    movwf   FSR0H
    movlw   LOW UART_RX_BUFFER
    movwf   FSR0L
    
    movf    INDF0, W
    sublw   'M'
    btfss   STATUS, 2, A
    goto    Parse_Check_Step
    
    ; Could be MOVE
    movf    POSTINC0, W
    sublw   'O'
    btfss   STATUS, 2, A
    goto    Parse_Failed
    
    movf    POSTINC0, W
    sublw   'V'
    btfss   STATUS, 2, A
    goto    Parse_Failed
    
    movf    POSTINC0, W
    sublw   'E'
    btfss   STATUS, 2, A
    goto    Parse_Failed
    
    ; It's MOVE command
    movlw   CMD_MOVE
    movwf   CMD_TYPE
    call    Parse_Four_Params       ; Parse 4 angle parameters
    return

Parse_Check_Step:
    ; Check for "STEP"
    movlw   HIGH UART_RX_BUFFER
    movwf   FSR0H
    movlw   LOW UART_RX_BUFFER
    movwf   FSR0L
    
    movf    INDF0, W
    sublw   'S'
    btfss   STATUS, 2, A
    goto    Parse_Check_Home
    
    movf    POSTINC0, W
    sublw   'T'
    btfss   STATUS, 2, A
    goto    Parse_Check_Status      ; Could be STATUS
    
    movf    POSTINC0, W
    sublw   'E'
    btfss   STATUS, 2, A
    goto    Parse_Failed
    
    movf    POSTINC0, W
    sublw   'P'
    btfss   STATUS, 2, A
    goto    Parse_Failed
    
    ; It's STEP command
    movlw   CMD_STEP
    movwf   CMD_TYPE
    call    Parse_Four_Params
    return

Parse_Check_Status:
    ; Already read "ST", check for "ATUS"
    movf    POSTINC0, W
    sublw   'A'
    btfss   STATUS, 2, A
    goto    Parse_Failed
    
    movf    POSTINC0, W
    sublw   'T'
    btfss   STATUS, 2, A
    goto    Parse_Failed
    
    movf    POSTINC0, W
    sublw   'U'
    btfss   STATUS, 2, A
    goto    Parse_Failed
    
    movf    POSTINC0, W
    sublw   'S'
    btfss   STATUS, 2, A
    goto    Parse_Failed
    
    ; It's STATUS command
    movlw   CMD_STATUS
    movwf   CMD_TYPE
    return

Parse_Check_Home:
    ; Check for "HOME"
    movlw   HIGH UART_RX_BUFFER
    movwf   FSR0H
    movlw   LOW UART_RX_BUFFER
    movwf   FSR0L
    
    movf    INDF0, W
    sublw   'H'
    btfss   STATUS, 2, A
    goto    Parse_Check_Stop
    
    movf    POSTINC0, W
    sublw   'O'
    btfss   STATUS, 2, A
    goto    Parse_Failed
    
    movf    POSTINC0, W
    sublw   'M'
    btfss   STATUS, 2, A
    goto    Parse_Failed
    
    movf    POSTINC0, W
    sublw   'E'
    btfss   STATUS, 2, A
    goto    Parse_Failed
    
    ; It's HOME command
    movlw   CMD_HOME
    movwf   CMD_TYPE
    return

Parse_Check_Stop:
    ; Check for "STOP"
    ; (Similar pattern as above)
    movlw   CMD_STOP
    movwf   CMD_TYPE
    return

Parse_Failed:
    clrf    CMD_TYPE
    return

; ==============================================================================
; Parse Four Parameters (for MOVE, STEP commands)
; ==============================================================================
Parse_Four_Params:
    ; Simplified: assumes space-separated decimal integers
    ; Real implementation would need proper ASCII to integer conversion
    ; For now, this is a placeholder
    ; TODO: Implement proper parameter parsing
    return

; ==============================================================================
; Command Execution Functions
; ==============================================================================
Execute_Move:
    ; Convert angles to steps and move motors
    ; Parameters in CMD_PARAM1-4 are joint angles (degrees)
    
    ; TODO: Call angle-to-steps conversion
    ; TODO: Call motor movement functions from motor_control.s
    
    ; For now, simulate with delay
    call    Delay_Long
    
    call    UART_Send_OK
    goto    UART_Reset_Buffer

Execute_Step:
    ; Move motors by step counts
    ; Parameters in CMD_PARAM1-4 are step counts
    
    ; TODO: Call motor stepping functions
    
    call    Delay_Long
    call    UART_Send_OK
    goto    UART_Reset_Buffer

Execute_Home:
    ; Move all motors to home position
    
    ; TODO: Call homing routine from motor_control.s
    
    call    Delay_Long
    call    UART_Send_OK
    goto    UART_Reset_Buffer

Execute_Stop:
    ; Emergency stop - halt all motors immediately
    
    ; TODO: Stop all motor outputs
    
    call    UART_Send_OK
    goto    UART_Reset_Buffer

Execute_Status:
    ; Report current joint angles
    
    ; TODO: Get current angles from motor state
    ; TODO: Format and send "STATUS <angles>"
    
    call    UART_Send_Status
    goto    UART_Reset_Buffer

Execute_Speed:
    ; Set motor speed
    
    ; TODO: Update motor speed parameter
    
    call    UART_Send_OK
    goto    UART_Reset_Buffer

Execute_Calibrate:
    ; Move single joint for calibration
    
    ; TODO: Parse joint number and steps
    ; TODO: Move specified joint
    
    call    UART_Send_OK
    goto    UART_Reset_Buffer

; ==============================================================================
; Reset RX Buffer
; ==============================================================================
UART_Reset_Buffer:
    clrf    UART_RX_IDX
    clrf    UART_RX_COUNT
    clrf    CMD_TYPE
    return

; ==============================================================================
; UART Transmit Functions
; ==============================================================================
UART_Send_OK:
    movlw   'O'
    call    UART_TX_Byte
    movlw   'K'
    call    UART_TX_Byte
    movlw   0x0A                    ; '\n'
    call    UART_TX_Byte
    return

UART_Send_Error:
    movlw   'E'
    call    UART_TX_Byte
    movlw   'R'
    call    UART_TX_Byte
    movlw   'R'
    call    UART_TX_Byte
    movlw   'O'
    call    UART_TX_Byte
    movlw   'R'
    call    UART_TX_Byte
    movlw   0x0A                    ; '\n'
    call    UART_TX_Byte
    return

UART_Send_Status:
    ; Send "STATUS <theta1> <theta2> <theta3> <theta4>\n"
    ; TODO: Format current angles as ASCII
    ; For now, send placeholder
    
    movlw   'S'
    call    UART_TX_Byte
    movlw   'T'
    call    UART_TX_Byte
    movlw   'A'
    call    UART_TX_Byte
    movlw   'T'
    call    UART_TX_Byte
    movlw   'U'
    call    UART_TX_Byte
    movlw   'S'
    call    UART_TX_Byte
    movlw   ' '
    call    UART_TX_Byte
    movlw   '0'
    call    UART_TX_Byte
    movlw   ' '
    call    UART_TX_Byte
    movlw   '0'
    call    UART_TX_Byte
    movlw   ' '
    call    UART_TX_Byte
    movlw   '0'
    call    UART_TX_Byte
    movlw   ' '
    call    UART_TX_Byte
    movlw   '0'
    call    UART_TX_Byte
    movlw   0x0A
    call    UART_TX_Byte
    return

UART_TX_Byte:
    ; Wait for TX buffer to be empty
    btfss   TRMT
    goto    $-1
    
    ; Send byte
    movwf   TXREG1
    return

; ==============================================================================
; Utility Functions
; ==============================================================================
Delay_Long:
    ; Simple delay loop (adjust as needed)
    movlw   0xFF
    movwf   0x200
Delay_Outer:
    movlw   0xFF
    movwf   0x201
Delay_Inner:
    decfsz  0x201, F
    goto    Delay_Inner
    decfsz  0x200, F
    goto    Delay_Outer
    return

; ==============================================================================
; Integration Notes
; ==============================================================================
; To integrate this into main.s:
;
; 1. Add to main initialization:
;    call UART_Init
;
; 2. Add to main ISR (interrupt service routine):
;    btfsc PIR1, RC1IF        ; UART receive interrupt?
;    call  UART_RX_ISR        ; Handle received byte
;
; 3. Link with motor_control.s functions:
;    - Replace TODO comments with actual motor control calls
;    - Add angle-to-steps conversion
;    - Add current position tracking
;
; 4. Include this file in your project and update Makefile
;
; ==============================================================================

END

