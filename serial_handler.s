; ==============================================================================
; Serial Command Handler for Robot Arm Control
; ==============================================================================
; Receives commands from Python control software via UART
; Protocol:
;   MOVE <theta1> <theta2> <theta3> <theta4>  - Move to joint angles (degrees) - TODO
;   STEP <base> <shoulder> <elbow> <wrist>    - Move by step counts
;   HOME                                       - Move to home position - TODO
;   STOP                                       - Emergency stop - TODO
;   STATUS                                     - Report current angles - TODO
;   SPEED <value>                              - Set motor speed - TODO
;   CAL <joint> <steps>                        - Calibrate single joint - TODO
;
; Responses:
;   OK        - Command completed successfully
;   ERROR     - Command failed
;   STATUS <theta1> <theta2> <theta3> <theta4>  - Current joint angles
; ==============================================================================

#include <xc.inc>

; ==============================================================================
; Exported Functions
; ==============================================================================
global  UART_Init, UART_RX_ISR, UART_Send_OK, UART_Send_Error
global  UART_Process_Command

; ==============================================================================
; Imported Functions (from motor_control.s)
; ==============================================================================
extrn Base_StepsForward, Base_StepsBackward
extrn Shoulder_StepsForward, Shoulder_StepsBackward
extrn Elbow_StepsForward, Elbow_StepsBackward
extrn Wrist_StepsForward, Wrist_StepsBackward
extrn Claw_StepsForward, Claw_StepsBackward
; extrn Motor_Init ; Already called in main

; ==============================================================================
; Serial Communication Parameters
; ==============================================================================
BAUD_RATE       EQU     9600            ; Baud rate
FOSC            EQU     16000000        ; Oscillator frequency (16 MHz)

; UART Receive Buffer (Allocated in Access Bank for speed)
UART_RX_BUFFER_SIZE EQU 64
UART_RX_BUFFER  EQU     0x100           ; Starting address for RX buffer (Bank 1)
UART_RX_IDX     EQU     0xF0            ; Current index in RX buffer
UART_RX_COUNT   EQU     0xF1            ; Number of bytes in buffer

; Command parsing
CMD_TYPE        EQU     0xF2            ; Command type code
; Parameters parsed from command string (16-bit signed integers)
PARAM1_L        EQU     0xF3            ; Parameter 1 Low
PARAM1_H        EQU     0xF4            ; Parameter 1 High
PARAM2_L        EQU     0xF5            ; Parameter 2 Low
PARAM2_H        EQU     0xF6            ; Parameter 2 High
PARAM3_L        EQU     0xF7            ; Parameter 3 Low
PARAM3_H        EQU     0xF8            ; Parameter 3 High
PARAM4_L        EQU     0xF9            ; Parameter 4 Low
PARAM4_H        EQU     0xFA            ; Parameter 4 High

; Temp vars for parsing
PARSE_PTR_L     EQU     0xFB
PARSE_PTR_H     EQU     0xFC
PARSE_TEMP      EQU     0xFD
PARSE_SIGN      EQU     0xFE

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
    ; Assumes FOSC = 64 MHz (16MHz Crystal + PLL)
    
    ; Disable UART
    bcf	    RCSTA1, 7, A	; SPEN=0 (Serial Port Disable)
    
    ; Configure baud rate generator
    ; Formula: Baud = FOSC / (64 * (SPBRG + 1))
    ; 9600 = 64,000,000 / (64 * (103 + 1))
    movlw   103
    movwf   SPBRG1, A
    
    bcf	    TXSTA1, 4, A	; SYNC=0 (Asynchronous)
    bcf	    TXSTA1, 2, A	; BRGH=0 (Low Speed)
    bcf	    BAUDCON1, 3, A	; BRG16=0 (8-bit Generator)
    
    ; Configure TX
    bsf     TXSTA1, 5, A	; TXEN=1 (Enable Transmit)
    bcf     TRISC, 6, A		; RC6 = TX1 as output
    
    ; Configure RX
    bsf     RCSTA1, 4, A	; CREN=1 (Enable Continuous Receive)
    bsf     TRISC, 7, A		; RC7 = RX1 as input
    
    ; Enable UART
    bsf	    RCSTA1, 7, A	; SPEN=1 (Serial Port Enable)
    
    ; Enable RX interrupt
    bsf	    PIE1, 5, A		; RC1IE (Enable UART1 receive interrupt)
    bsf	    INTCON, 6, A	; PEIE (Enable peripheral interrupts)
    bsf	    INTCON, 7, A	; GIE (Enable global interrupts)
    
    ; Initialize buffer pointers
    clrf    UART_RX_IDX, A
    clrf    UART_RX_COUNT, A
    clrf    CMD_TYPE, A
    
    return

; ==============================================================================
; UART Receive Interrupt Handler
; ==============================================================================
; Call this from main ISR when RC1IF is set
; ==============================================================================
UART_RX_ISR:
    ; Check for receive errors
    btfsc   RCSTA1, 1, A    ; OERR (Overrun Error)
    bra     handle_oerr
    btfsc   RCSTA1, 2, A    ; FERR (Framing Error)
    bra     handle_ferr
    
    ; Read received byte
    movf    RCREG1, W, A    ; Read from receive register (clears RC1IF)
    movwf   0x00, A         ; Save to Temp (Access Bank 0x00)
    
    ; Echo byte back (optional, useful for debugging)
    ; call    UART_TX_Byte_Fast 
    
    ; Restore W
    movf    0x00, W, A
    
    ; Check for newline (command terminator)
    sublw   0x0A            ; Compare with '\n'
    btfsc   STATUS, 2, A
    goto    UART_Process_Command    ; Complete command received
    
    ; Restore W
    movf    0x00, W, A
    sublw   0x0D            ; Compare with '\r'
    btfsc   STATUS, 2, A
    goto    UART_Process_Command
    
    ; Store byte in buffer if not full
    movf    UART_RX_COUNT, W, A
    sublw   UART_RX_BUFFER_SIZE - 1 ; Check if buffer full
    btfss   STATUS, 0, A            ; Carry clear = W > Literal (Buffer full)
    return                          ; Buffer full, ignore byte
    
    ; Calculate buffer address and store
    lfsr    0, UART_RX_BUFFER
    movf    UART_RX_IDX, W, A
    addwf   FSR0L, F, A
    movlw   0
    addwfc  FSR0H, F, A
    
    movf    0x00, W, A              ; Get char back
    movwf   INDF0, A                ; Store in buffer
    
    incf    UART_RX_IDX, F, A       ; Increment index
    incf    UART_RX_COUNT, F, A     ; Increment count
    return

handle_oerr:
    bcf     RCSTA1, 4, A    ; Clear CREN
    bsf     RCSTA1, 4, A    ; Set CREN
    return

handle_ferr:
    movf    RCREG1, W, A    ; Read to clear
    return

; ==============================================================================
; Process Received Command
; ==============================================================================
UART_Process_Command:
    ; 1. Null-terminate the buffer string
    lfsr    0, UART_RX_BUFFER
    movf    UART_RX_IDX, W, A
    addwf   FSR0L, F, A     ; Point to next char
    movlw   0
    addwfc  FSR0H, F, A
    clrf    INDF0, A        ; Null terminate
    
    ; 2. Parse Command
    call    Parse_Command
    
    ; 3. Execute Command
    movf    CMD_TYPE, W, A
    xorlw   CMD_STEP
    btfsc   STATUS, 2, A
    goto    Execute_Step
    
    movf    CMD_TYPE, W, A
    xorlw   CMD_HOME
    btfsc   STATUS, 2, A
    goto    Execute_Home
    
    movf    CMD_TYPE, W, A
    xorlw   CMD_STATUS
    btfsc   STATUS, 2, A
    goto    Execute_Status
    
    ; Unknown command or parse error
    call    UART_Send_Error
    goto    UART_Reset_Buffer_End

Execute_Done:
    call    UART_Send_OK

UART_Reset_Buffer_End:
    ; 4. Reset Buffer
    clrf    UART_RX_IDX, A
    clrf    UART_RX_COUNT, A
    return

; ==============================================================================
; Command Parsers
; ==============================================================================
Parse_Command:
    ; Check first char
    lfsr    0, UART_RX_BUFFER
    movf    INDF0, W, A
    
    sublw   'H'
    btfsc   STATUS, 2, A
    goto    Set_Cmd_Home
    
    movf    INDF0, W, A
    sublw   'S'             ; Check 'S'
    btfsc   STATUS, 2, A
    goto    Parse_S_Cmd
    
    clrf    CMD_TYPE, A     ; Unknown
    return

Parse_S_Cmd:
    ; Check next char to distinguish STEP / STATUS / STOP / SPEED
    movf    POSTINC0, W, A  ; 'S'
    movf    INDF0, W, A     ; Next char
    
    sublw   'T'
    btfsc   STATUS, 2, A
    goto    Parse_ST_Cmd    ; STEP / STATUS / STOP
    
    return

Parse_ST_Cmd:
    movf    POSTINC0, W, A  ; 'T'
    movf    INDF0, W, A     ; Next char
    
    sublw   'E'             ; STEP
    btfsc   STATUS, 2, A
    goto    Set_Cmd_Step
    
    ; Reload character for STATUS check (sublw modified WREG)
    movf    INDF0, W, A     ; Next char again
    sublw   'A'             ; STATUS
    btfsc   STATUS, 2, A
    goto    Set_Cmd_Status
    
    return

Set_Cmd_Home:
    movlw   CMD_HOME
    movwf   CMD_TYPE, A
    return

Set_Cmd_Status:
    movlw   CMD_STATUS
    movwf   CMD_TYPE, A
    return

Set_Cmd_Step:
    ; Parse STEP parameters: STEP <p1> <p2> <p3> <p4>
    movlw   CMD_STEP
    movwf   CMD_TYPE, A
    
    ; Advance FSR0 to after "STEP"
    ; Currently points to 'E'. Need to skip 'E', 'P', ' '
    movf    POSTINC0, W, A ; Skip 'E'
    movf    POSTINC0, W, A ; Skip 'P'
    
    ; Skip spaces
Skip_Spaces_1:
    movf    INDF0, W, A
    sublw   ' '
    btfss   STATUS, 2, A
    bra     Parse_P1
    movf    POSTINC0, W, A ; Skip space
    bra     Skip_Spaces_1

Parse_P1:
    call    Parse_Integer
    movff   PARSE_TEMP, PARAM1_L ; Low byte only for now (8-bit steps)
    clrf    PARAM1_H, A
    
    ; Skip spaces
Skip_Spaces_2:
    movf    INDF0, W, A
    sublw   ' '
    btfss   STATUS, 2, A
    bra     Parse_P2
    movf    POSTINC0, W, A
    bra     Skip_Spaces_2

Parse_P2:
    call    Parse_Integer
    movff   PARSE_TEMP, PARAM2_L
    clrf    PARAM2_H, A
    
    ; Skip spaces
Skip_Spaces_3:
    movf    INDF0, W, A
    sublw   ' '
    btfss   STATUS, 2, A
    bra     Parse_P3
    movf    POSTINC0, W, A
    bra     Skip_Spaces_3

Parse_P3:
    call    Parse_Integer
    movff   PARSE_TEMP, PARAM3_L
    clrf    PARAM3_H, A
    
    ; Skip spaces
Skip_Spaces_4:
    movf    INDF0, W, A
    sublw   ' '
    btfss   STATUS, 2, A
    bra     Parse_P4
    movf    POSTINC0, W, A
    bra     Skip_Spaces_4

Parse_P4:
    call    Parse_Integer
    movff   PARSE_TEMP, PARAM4_L
    clrf    PARAM4_H, A
    return

; ==============================================================================
; Parse Integer (ASCII -> Value)
; ==============================================================================
; Inputs: FSR0 points to string
; Outputs: PARSE_TEMP (8-bit value), FSR0 updated
; Trashes: W, STATUS
Parse_Integer:
    clrf    PARSE_TEMP, A
    clrf    PARSE_SIGN, A   ; 0 = positive, 1 = negative
    
    ; Check for sign
    movf    INDF0, W, A
    sublw   '-'
    btfss   STATUS, 2, A
    bra     Parse_Digit_Loop
    
    ; It is negative
    movlw   1
    movwf   PARSE_SIGN, A
    movf    POSTINC0, W, A ; Consume '-'

Parse_Digit_Loop:
    movf    INDF0, W, A
    
    ; Check if digit (0-9)
    ; Lower bound '0' (0x30)
    addlw   -0x30
    btfss   STATUS, 0, A    ; C=0 if W < 0 (not a digit)
    bra     Parse_End       ; Not a digit (space, null, etc)
    
    ; Upper bound '9' (0x39 - 0x30 = 9)
    sublw   9
    btfss   STATUS, 0, A    ; C=0 if W > 9 (not a digit)
    bra     Parse_End
    
    ; Valid digit in W (original - '0')? No, sublw 9 does 9-W.
    ; Need to recover value.
    movf    INDF0, W, A
    addlw   -0x30           ; W = Digit Value
    
    ; PARSE_TEMP = PARSE_TEMP * 10 + W
    ; Multiply by 10
    movff   PARSE_TEMP, 0x01 ; Save
    bcf     STATUS, 0, A     ; Clear C
    rlncf   PARSE_TEMP, F, A ; *2
    rlncf   PARSE_TEMP, F, A ; *4
    addwf   PARSE_TEMP, F, A ; *4 + val
    bcf     STATUS, 0, A
    rlncf   PARSE_TEMP, F, A ; (*4 + val) * 2 ?? Wrong.
    
    ; Simple multiply: x10 = x8 + x2
    ; x2
    movf    0x01, W, A
    addwf   0x01, W, A      ; W = temp * 2
    movwf   0x02, A         ; Save x2
    
    ; x8
    addwf   0x02, W, A      ; x4
    addwf   0x02, W, A      ; x6 ... slow.
    
    ; Let's restart multiply logic
    ; x * 10 = (x * 2) * 5 ?? No.
    ; x * 10 = (x << 3) + (x << 1)
    movf    0x01, W, A      ; Original
    bcf     STATUS, 0, A
    rlncf   WREG, W, A      ; x2
    movwf   0x02, A         ; Save x2
    bcf     STATUS, 0, A
    rlncf   WREG, W, A      ; x4
    bcf     STATUS, 0, A
    rlncf   WREG, W, A      ; x8
    addwf   0x02, W, A      ; x8 + x2 = x10
    
    ; Add new digit
    movwf   PARSE_TEMP, A
    movf    INDF0, W, A
    addlw   -0x30
    addwf   PARSE_TEMP, F, A
    
    movf    POSTINC0, W, A  ; Consume char
    bra     Parse_Digit_Loop

Parse_End:
    ; Apply sign
    movf    PARSE_SIGN, W, A
    btfss   STATUS, 2, A    ; Skip if zero (positive)
    negf    PARSE_TEMP, A   ; Negate if negative
    
    return

; ==============================================================================
; Command Executors
; ==============================================================================
Execute_Home:
    ; Call Motor_Home (TODO)
    goto    Execute_Done

Execute_Status:
    call    UART_Send_Status
    goto    UART_Reset_Buffer_End

Execute_Step:
    ; Move motors based on params (signed 8-bit)
    ; Base (Param1)
    movf    PARAM1_L, W, A
    btfsc   WREG, 7, A      ; Check sign bit
    bra     Step_Base_Neg
    
    ; Positive
    call    Base_StepsForward
    bra     Step_Shoulder
Step_Base_Neg:
    negf    WREG, A
    call    Base_StepsBackward

Step_Shoulder:
    movf    PARAM2_L, W, A
    btfsc   WREG, 7, A
    bra     Step_Shoulder_Neg
    call    Shoulder_StepsForward
    bra     Step_Elbow
Step_Shoulder_Neg:
    negf    WREG, A
    call    Shoulder_StepsBackward

Step_Elbow:
    movf    PARAM3_L, W, A
    btfsc   WREG, 7, A
    bra     Step_Elbow_Neg
    call    Elbow_StepsForward
    bra     Step_Wrist
Step_Elbow_Neg:
    negf    WREG, A
    call    Elbow_StepsBackward

Step_Wrist:
    movf    PARAM4_L, W, A
    btfsc   WREG, 7, A
    bra     Step_Wrist_Neg
    call    Wrist_StepsForward
    goto    Execute_Done
Step_Wrist_Neg:
    negf    WREG, A
    call    Wrist_StepsBackward
    goto    Execute_Done

; ==============================================================================
; UART Transmit Functions
; ==============================================================================
UART_TX_Byte_Fast:
    ; Double-buffered transmit
    btfss   PIR1, 4, A      ; TX1IF
    bra     UART_TX_Byte_Fast
    movwf   TXREG1, A
    return

UART_Send_OK:
    movlw   'O'
    call    UART_TX_Byte_Fast
    movlw   'K'
    call    UART_TX_Byte_Fast
    movlw   0x0A            ; '\n'
    call    UART_TX_Byte_Fast
    return

UART_Send_Error:
    movlw   'E'
    call    UART_TX_Byte_Fast
    movlw   'R'
    call    UART_TX_Byte_Fast
    movlw   'R'
    call    UART_TX_Byte_Fast
    movlw   0x0A
    call    UART_TX_Byte_Fast
    return

UART_Send_Status:
    movlw   'S'
    call    UART_TX_Byte_Fast
    movlw   'T'
    call    UART_TX_Byte_Fast
    movlw   'A'
    call    UART_TX_Byte_Fast
    movlw   'T'
    call    UART_TX_Byte_Fast
    movlw   0x0A
    call    UART_TX_Byte_Fast
    return

    END
