; ==============================================================================
; Serial Command Handler for Robot Arm Control
; ==============================================================================
; Receives commands from Python control software via UART
; Protocol:
;   MOVE <theta1> <theta2> <theta3> <theta4>  - Move to joint angles (degrees) - TODO
;   STEP <base> <shoulder> <elbow> <wrist>    - Move by step counts (signed 8-bit)
;   ANGLE <θ1> <θ2> <θ3> <θ4>                 - Move to absolute angles (tenths of degrees, 0-3600)
;   CLAW <steps>                               - Move claw motor (signed 8-bit steps)
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
;
; Coupling Notes (for future IK implementation):
;   - Shoulder-Elbow: scissor mechanism, ratio -1:1 (elbow moves opposite to shoulder)
;   - Wrist-Shoulder: same direction, ratio 1:1 (wrist maintains orientation)
;   - Currently sending raw angles; IK will compensate for coupling on Python side
; ==============================================================================

#include <xc.inc>

; ==============================================================================
; Exported Functions
; ==============================================================================
global  UART_Init, UART_RX_ISR, UART_Send_OK, UART_Send_Error
global  UART_Process_Command, Execute_Pending_Command
global  CMD_READY

; ==============================================================================
; Imported Functions (from motor_control.s)
; ==============================================================================
extrn Base_StepsForward, Base_StepsBackward
extrn Shoulder_StepsForward, Shoulder_StepsBackward
extrn Elbow_StepsForward, Elbow_StepsBackward
extrn Wrist_StepsForward, Wrist_StepsBackward
extrn Claw_StepsForward, Claw_StepsBackward
extrn WritePortD, WritePortE, WritePortH  ; For motor hold after stepping
; extrn Motor_Init ; Already called in main

; ==============================================================================
; Serial Communication Parameters
; ==============================================================================
BAUD_RATE       EQU     9600            ; Baud rate
FOSC            EQU     16000000        ; Oscillator frequency (16 MHz)

; UART Receive Buffer (Allocated in Access Bank for speed)
UART_RX_BUFFER_SIZE EQU 64
UART_RX_BUFFER  EQU     0x100           ; Starting address for RX buffer (Bank 1)
UART_RX_IDX     EQU     0x20            ; Current index in RX buffer (Relocated from 0xF0)
UART_RX_COUNT   EQU     0x21            ; Number of bytes in buffer (Relocated from 0xF1)

; Command parsing
CMD_TYPE        EQU     0x22            ; Command type code
; Parameters parsed from command string (16-bit signed integers)
PARAM1_L        EQU     0x23            ; Parameter 1 Low
PARAM1_H        EQU     0x24            ; Parameter 1 High
PARAM2_L        EQU     0x25            ; Parameter 2 Low
PARAM2_H        EQU     0x26            ; Parameter 2 High
PARAM3_L        EQU     0x27            ; Parameter 3 Low
PARAM3_H        EQU     0x28            ; Parameter 3 High
PARAM4_L        EQU     0x29            ; Parameter 4 Low
PARAM4_H        EQU     0x2A            ; Parameter 4 High

; Temp vars for parsing
PARSE_PTR_L     EQU     0x2B
PARSE_PTR_H     EQU     0x2C
PARSE_TEMP      EQU     0x2D
PARSE_SIGN      EQU     0x2E

; Command execution flag (set by ISR, cleared by main loop after execution)
CMD_READY       EQU     0x2F            ; 0 = no command, non-zero = command ready to execute

; Additional temp vars for 16-bit parsing and math
PARSE_TEMP_L    EQU     0x30            ; 16-bit parse result (low byte)
PARSE_TEMP_H    EQU     0x31            ; 16-bit parse result (high byte)
MATH_TEMP_0     EQU     0x32            ; Math temp registers for multiply/divide
MATH_TEMP_1     EQU     0x33
MATH_TEMP_2     EQU     0x34
MATH_TEMP_3     EQU     0x35
STEPS_RESULT_L  EQU     0x36            ; Step conversion result (low)
STEPS_RESULT_H  EQU     0x37            ; Step conversion result (high)

; Command type codes
CMD_NONE        EQU     0x00
CMD_MOVE        EQU     0x01
CMD_STEP        EQU     0x02
CMD_HOME        EQU     0x03
CMD_STOP        EQU     0x04
CMD_STATUS      EQU     0x05
CMD_SPEED       EQU     0x06
CMD_CAL         EQU     0x07
CMD_ANGLE       EQU     0x08            ; ANGLE command (absolute angles in tenths)
CMD_CLAW        EQU     0x09            ; CLAW command (signed 8-bit steps)

; ==============================================================================
; Gear Ratio Constants for Angle-to-Step Conversion
; ==============================================================================
; Angles are received as tenths of degrees (0-3600 = 0.0-360.0 deg)
; Conversion: steps = angle_tenths * RATIO_NUM / RATIO_DEN
;
; Measured calibration data:
;   96 steps = 18.5 degrees = 185 tenths
;   ratio = 96/185 steps per tenth
;
; For integer math: steps = angle_tenths * numerator / denominator
; ==============================================================================
RATIO_BASE_NUM      EQU     96          ; Base: 96/185 steps per tenth
RATIO_BASE_DEN      EQU     185
RATIO_SHOULDER_NUM  EQU     96          ; Shoulder: 96/185 steps per tenth
RATIO_SHOULDER_DEN  EQU     185
RATIO_ELBOW_NUM     EQU     96          ; Elbow: 96/185 steps per tenth
RATIO_ELBOW_DEN     EQU     185
RATIO_WRIST_NUM     EQU     96          ; Wrist: 96/185 steps per tenth
RATIO_WRIST_DEN     EQU     185

; Coupling ratios (for future IK - currently unused)
; COUPLING_SE_RATIO: Shoulder-Elbow = -1 (opposite directions)
; COUPLING_WS_RATIO: Wrist-Shoulder = +1 (same direction)

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
    
    ; Initialize buffer pointers and flags
    clrf    UART_RX_IDX, A
    clrf    UART_RX_COUNT, A
    clrf    CMD_TYPE, A
    clrf    CMD_READY, A        ; No command pending
    
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
; Process Received Command (called from ISR - just parse and set flag)
; ==============================================================================
UART_Process_Command:
    ; 1. Null-terminate the buffer string
    lfsr    0, UART_RX_BUFFER
    movf    UART_RX_IDX, W, A
    addwf   FSR0L, F, A     ; Point to next char
    movlw   0
    addwfc  FSR0H, F, A
    clrf    INDF0, A        ; Null terminate
    
    ; 2. Parse Command (fills CMD_TYPE and PARAMx_L)
    call    Parse_Command
    
    ; 3. Set command ready flag (main loop will execute)
    movf    CMD_TYPE, W, A
    movwf   CMD_READY, A    ; CMD_READY = CMD_TYPE (non-zero if valid command)
    
    ; 4. Reset Buffer (ready for next command)
    clrf    UART_RX_IDX, A
    clrf    UART_RX_COUNT, A
    return

; ==============================================================================
; Execute Pending Command (called from main loop, NOT from ISR)
; ==============================================================================
Execute_Pending_Command:
    ; Check what command to execute
    movf    CMD_READY, W, A
    bz      Exec_Done_NoResponse    ; No command pending
    
    ; Check command type
    xorlw   CMD_STEP
    btfsc   STATUS, 2, A
    goto    Execute_Step
    
    movf    CMD_READY, W, A
    xorlw   CMD_HOME
    btfsc   STATUS, 2, A
    goto    Execute_Home
    
    movf    CMD_READY, W, A
    xorlw   CMD_STATUS
    btfsc   STATUS, 2, A
    goto    Execute_Status
    
    movf    CMD_READY, W, A
    xorlw   CMD_ANGLE
    btfsc   STATUS, 2, A
    goto    Execute_Angle
    
    movf    CMD_READY, W, A
    xorlw   CMD_CLAW
    btfsc   STATUS, 2, A
    goto    Execute_Claw
    
    ; Unknown command - send error
    call    UART_Send_Error
    goto    Exec_Clear_Flag

Execute_Done:
    call    UART_Send_OK

Exec_Clear_Flag:
    clrf    CMD_READY, A    ; Clear flag - command processed
    
Exec_Done_NoResponse:
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
    
    movf    INDF0, W, A
    sublw   'A'             ; Check 'A' for ANGLE
    btfsc   STATUS, 2, A
    goto    Set_Cmd_Angle
    
    movf    INDF0, W, A
    sublw   'C'             ; Check 'C' for CLAW
    btfsc   STATUS, 2, A
    goto    Set_Cmd_Claw
    
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

Set_Cmd_Angle:
    ; Parse ANGLE parameters: ANGLE <θ1> <θ2> <θ3> <θ4> (16-bit unsigned, 0-3600)
    movlw   CMD_ANGLE
    movwf   CMD_TYPE, A
    
    ; Advance FSR0 past "ANGLE" (A-N-G-L-E = 5 chars)
    movf    POSTINC0, W, A  ; Skip 'A'
    movf    POSTINC0, W, A  ; Skip 'N'
    movf    POSTINC0, W, A  ; Skip 'G'
    movf    POSTINC0, W, A  ; Skip 'L'
    movf    POSTINC0, W, A  ; Skip 'E'
    
    ; Skip spaces before first param
Angle_Skip_Spaces_1:
    movf    INDF0, W, A
    sublw   ' '
    btfss   STATUS, 2, A
    bra     Angle_Parse_P1
    movf    POSTINC0, W, A
    bra     Angle_Skip_Spaces_1

Angle_Parse_P1:
    call    Parse_Integer_16
    movff   PARSE_TEMP_L, PARAM1_L
    movff   PARSE_TEMP_H, PARAM1_H
    
Angle_Skip_Spaces_2:
    movf    INDF0, W, A
    sublw   ' '
    btfss   STATUS, 2, A
    bra     Angle_Parse_P2
    movf    POSTINC0, W, A
    bra     Angle_Skip_Spaces_2

Angle_Parse_P2:
    call    Parse_Integer_16
    movff   PARSE_TEMP_L, PARAM2_L
    movff   PARSE_TEMP_H, PARAM2_H
    
Angle_Skip_Spaces_3:
    movf    INDF0, W, A
    sublw   ' '
    btfss   STATUS, 2, A
    bra     Angle_Parse_P3
    movf    POSTINC0, W, A
    bra     Angle_Skip_Spaces_3

Angle_Parse_P3:
    call    Parse_Integer_16
    movff   PARSE_TEMP_L, PARAM3_L
    movff   PARSE_TEMP_H, PARAM3_H
    
Angle_Skip_Spaces_4:
    movf    INDF0, W, A
    sublw   ' '
    btfss   STATUS, 2, A
    bra     Angle_Parse_P4
    movf    POSTINC0, W, A
    bra     Angle_Skip_Spaces_4

Angle_Parse_P4:
    call    Parse_Integer_16
    movff   PARSE_TEMP_L, PARAM4_L
    movff   PARSE_TEMP_H, PARAM4_H
    return

Set_Cmd_Claw:
    ; Parse CLAW parameter: CLAW <steps> (signed 8-bit)
    movlw   CMD_CLAW
    movwf   CMD_TYPE, A
    
    ; Advance FSR0 past "CLAW" (C-L-A-W = 4 chars)
    movf    POSTINC0, W, A  ; Skip 'C'
    movf    POSTINC0, W, A  ; Skip 'L'
    movf    POSTINC0, W, A  ; Skip 'A'
    movf    POSTINC0, W, A  ; Skip 'W'
    
    ; Skip spaces
Claw_Skip_Spaces:
    movf    INDF0, W, A
    sublw   ' '
    btfss   STATUS, 2, A
    bra     Claw_Parse_Param
    movf    POSTINC0, W, A
    bra     Claw_Skip_Spaces

Claw_Parse_Param:
    call    Parse_Integer           ; Use 8-bit signed parse
    movff   PARSE_TEMP, PARAM1_L    ; Store in PARAM1
    clrf    PARAM1_H, A
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
    movff   PARSE_TEMP, 0x01 ; Save original value
    
    ; x * 10 = (x * 2) * 5 ?? No.
    ; x * 10 = (x << 3) + (x << 1) = x*8 + x*2
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
; Parse 16-bit Unsigned Integer (ASCII -> 16-bit Value)
; ==============================================================================
; Inputs: FSR0 points to string
; Outputs: PARSE_TEMP_L, PARSE_TEMP_H (16-bit unsigned value), FSR0 updated
; Trashes: W, STATUS, MATH_TEMP_0-3
; Max value: 65535 (but we expect 0-3600 for angles)
Parse_Integer_16:
    clrf    PARSE_TEMP_L, A
    clrf    PARSE_TEMP_H, A
    
Parse_16_Digit_Loop:
    movf    INDF0, W, A
    
    ; Check if digit (0-9)
    addlw   -0x30           ; W = char - '0'
    btfss   STATUS, 0, A    ; C=0 if char < '0' (not a digit)
    bra     Parse_16_End
    
    ; Check upper bound
    sublw   9               ; W = 9 - (char - '0')
    btfss   STATUS, 0, A    ; C=0 if digit > 9
    bra     Parse_16_End
    
    ; Valid digit - get its value
    movf    INDF0, W, A
    addlw   -0x30           ; W = digit value (0-9)
    movwf   MATH_TEMP_0, A  ; Save digit
    
    ; Multiply current result by 10: result = result * 10
    ; result * 10 = result * 8 + result * 2
    
    ; First, save original result
    movff   PARSE_TEMP_L, MATH_TEMP_1
    movff   PARSE_TEMP_H, MATH_TEMP_2
    
    ; result * 2
    bcf     STATUS, 0, A
    rlcf    PARSE_TEMP_L, F, A
    rlcf    PARSE_TEMP_H, F, A
    
    ; Save result * 2
    movff   PARSE_TEMP_L, MATH_TEMP_3
    movf    PARSE_TEMP_H, W, A
    movwf   0x38, A                     ; Use temp location for high byte of *2
    
    ; result * 4 (continue from *2)
    bcf     STATUS, 0, A
    rlcf    PARSE_TEMP_L, F, A
    rlcf    PARSE_TEMP_H, F, A
    
    ; result * 8 (continue from *4)
    bcf     STATUS, 0, A
    rlcf    PARSE_TEMP_L, F, A
    rlcf    PARSE_TEMP_H, F, A
    
    ; result = result * 8 + result * 2
    movf    MATH_TEMP_3, W, A
    addwf   PARSE_TEMP_L, F, A
    movf    0x38, W, A
    addwfc  PARSE_TEMP_H, F, A
    
    ; Add the new digit
    movf    MATH_TEMP_0, W, A
    addwf   PARSE_TEMP_L, F, A
    movlw   0
    addwfc  PARSE_TEMP_H, F, A
    
    ; Advance to next character
    movf    POSTINC0, W, A
    bra     Parse_16_Digit_Loop

Parse_16_End:
    return

; ==============================================================================
; Command Executors
; ==============================================================================
Execute_Home:
    ; Call Motor_Home (TODO)
    goto    Execute_Done

Execute_Status:
    call    UART_Send_Status
    goto    Exec_Clear_Flag

; ==============================================================================
; Execute ANGLE Command - Convert angles (tenths) to steps and move motors
; ==============================================================================
; PARAM1 = base angle (tenths), PARAM2 = shoulder, PARAM3 = elbow, PARAM4 = wrist
; Each angle is converted to steps using the gear ratios
Execute_Angle:
    ; --- Base Motor (PARAM1) ---
    ; steps = angle_tenths * 96 / 185
    movff   PARAM1_L, MATH_TEMP_0
    movff   PARAM1_H, MATH_TEMP_1
    movlw   RATIO_BASE_NUM          ; Numerator = 96
    movwf   MATH_TEMP_2, A
    movlw   RATIO_BASE_DEN          ; Denominator = 185
    movwf   MATH_TEMP_3, A
    call    Convert_Angle_To_Steps
    ; Result in STEPS_RESULT_L (only need low byte for reasonable angles)
    movf    STEPS_RESULT_L, W, A
    bz      Angle_Shoulder          ; Skip if zero steps
    call    Base_StepsForward
    
Angle_Shoulder:
    ; --- Shoulder Motor (PARAM2) ---
    ; steps = angle_tenths * 96 / 185
    movff   PARAM2_L, MATH_TEMP_0
    movff   PARAM2_H, MATH_TEMP_1
    movlw   RATIO_SHOULDER_NUM      ; Numerator = 96
    movwf   MATH_TEMP_2, A
    movlw   RATIO_SHOULDER_DEN      ; Denominator = 185
    movwf   MATH_TEMP_3, A
    call    Convert_Angle_To_Steps
    movf    STEPS_RESULT_L, W, A
    bz      Angle_Elbow
    call    Shoulder_StepsForward
    
Angle_Elbow:
    ; --- Elbow Motor (PARAM3) ---
    ; steps = angle_tenths * 96 / 185
    movff   PARAM3_L, MATH_TEMP_0
    movff   PARAM3_H, MATH_TEMP_1
    movlw   RATIO_ELBOW_NUM
    movwf   MATH_TEMP_2, A
    movlw   RATIO_ELBOW_DEN
    movwf   MATH_TEMP_3, A
    call    Convert_Angle_To_Steps
    movf    STEPS_RESULT_L, W, A
    bz      Angle_Wrist
    call    Elbow_StepsForward
    
Angle_Wrist:
    ; --- Wrist Motor (PARAM4) ---
    ; steps = angle_tenths * 96 / 185
    movff   PARAM4_L, MATH_TEMP_0
    movff   PARAM4_H, MATH_TEMP_1
    movlw   RATIO_WRIST_NUM
    movwf   MATH_TEMP_2, A
    movlw   RATIO_WRIST_DEN
    movwf   MATH_TEMP_3, A
    call    Convert_Angle_To_Steps
    movf    STEPS_RESULT_L, W, A
    bz      Angle_Hold_Motors
    call    Wrist_StepsForward
    
Angle_Hold_Motors:
    call    WritePortD
    call    WritePortE
    call    WritePortH
    goto    Execute_Done

; ==============================================================================
; Execute CLAW Command - Move claw motor by signed step count
; ==============================================================================
Execute_Claw:
    movf    PARAM1_L, W, A
    bz      Claw_Done               ; Skip if zero
    btfsc   WREG, 7, A              ; Check sign bit
    bra     Claw_Backward
    
    ; Positive - move forward
    call    Claw_StepsForward
    bra     Claw_Hold
    
Claw_Backward:
    ; Negative - negate and move backward
    movwf   PARSE_TEMP, A
    negf    PARSE_TEMP, A
    movf    PARSE_TEMP, W, A
    call    Claw_StepsBackward
    
Claw_Hold:
    call    WritePortD              ; Claw is on Port D
    
Claw_Done:
    goto    Execute_Done

; ==============================================================================
; Convert Angle (tenths) to Steps using gear ratio
; ==============================================================================
; Inputs:
;   MATH_TEMP_0:MATH_TEMP_1 = angle in tenths (16-bit)
;   MATH_TEMP_2 = numerator (8-bit)
;   MATH_TEMP_3 = denominator (8-bit)
; Output:
;   STEPS_RESULT_L:STEPS_RESULT_H = steps (16-bit)
;
; Formula: steps = (angle_tenths * numerator) / denominator
; For simplicity, we do: multiply, then divide
; Since angle max = 3600, numerator max = 96:
;   max product = 3600 * 96 = 345,600 (needs 19 bits... we'll use 24-bit intermediate)
; ==============================================================================
Convert_Angle_To_Steps:
    ; Multiply angle_tenths (16-bit) by numerator (8-bit)
    ; Result is 24-bit in 0x39:0x3A:0x3B (high:mid:low)
    
    clrf    0x39, A                 ; High byte of product
    clrf    0x3A, A                 ; Mid byte
    clrf    0x3B, A                 ; Low byte
    
    ; 16x8 multiply: angle * numerator
    ; Low byte * numerator
    movf    MATH_TEMP_0, W, A       ; angle low
    mulwf   MATH_TEMP_2, A          ; * numerator
    movff   PRODL, 0x3B             ; Store low
    movff   PRODH, 0x3A             ; Store mid
    
    ; High byte * numerator
    movf    MATH_TEMP_1, W, A       ; angle high
    mulwf   MATH_TEMP_2, A          ; * numerator
    ; Add to mid and high bytes
    movf    PRODL, W, A
    addwf   0x3A, F, A
    movf    PRODH, W, A
    addwfc  0x39, F, A
    
    ; Now divide 24-bit product by 8-bit denominator
    ; Simple repeated subtraction division (for small divisors like 75, 185)
    ; Result in STEPS_RESULT
    
    clrf    STEPS_RESULT_L, A
    clrf    STEPS_RESULT_H, A
    
    ; Check if denominator is 0 (shouldn't happen)
    movf    MATH_TEMP_3, W, A
    bz      Convert_Done
    
Divide_Loop:
    ; Check if product >= denominator
    ; Compare 24-bit product with 8-bit denominator (extended to 24-bit)
    ; If product high bytes are non-zero, definitely >= denominator
    movf    0x39, W, A
    bnz     Divide_Subtract
    movf    0x3A, W, A
    bnz     Divide_Subtract
    
    ; Only low byte remains - direct compare
    movf    MATH_TEMP_3, W, A       ; denominator
    subwf   0x3B, W, A              ; low - denom (don't store)
    btfss   STATUS, 0, A            ; C=0 if low < denom
    bra     Convert_Done            ; Done - remainder < divisor
    
Divide_Subtract:
    ; Subtract denominator from product
    movf    MATH_TEMP_3, W, A
    subwf   0x3B, F, A
    movlw   0
    subwfb  0x3A, F, A
    subwfb  0x39, F, A
    
    ; Increment result
    incf    STEPS_RESULT_L, F, A
    btfsc   STATUS, 2, A            ; Check for overflow to high byte
    incf    STEPS_RESULT_H, F, A
    
    ; Check for result overflow (shouldn't happen with valid inputs)
    movf    STEPS_RESULT_H, W, A
    andlw   0xF0                    ; Check if > 4095 steps
    bnz     Convert_Done            ; Overflow protection
    
    bra     Divide_Loop
    
Convert_Done:
    return

Execute_Step:
    ; DEBUG: Echo back parsed parameters before execution
    ; DISABLED - interferes with Python response detection
    ; call    UART_Send_Debug_Params
    
    ; Move motors based on params (signed 8-bit)
    ; Base (Param1)
    movf    PARAM1_L, W, A
    bz      Step_Shoulder   ; Skip if zero
    btfsc   WREG, 7, A      ; Check sign bit
    bra     Step_Base_Neg
    
    ; Positive
    call    Base_StepsForward
    bra     Step_Shoulder
Step_Base_Neg:
    ; Negate W using temp (negf WREG unreliable)
    movwf   PARSE_TEMP, A       ; Save to temp
    negf    PARSE_TEMP, A       ; Negate temp
    movf    PARSE_TEMP, W, A    ; Load back to W
    call    Base_StepsBackward

Step_Shoulder:
    movf    PARAM2_L, W, A
    bz      Step_Elbow      ; Skip if zero
    btfsc   WREG, 7, A
    bra     Step_Shoulder_Neg
    call    Shoulder_StepsForward
    bra     Step_Elbow
Step_Shoulder_Neg:
    ; Negate W using temp (negf WREG unreliable)
    movwf   PARSE_TEMP, A       ; Save to temp
    negf    PARSE_TEMP, A       ; Negate temp
    movf    PARSE_TEMP, W, A    ; Load back to W
    call    Shoulder_StepsBackward

Step_Elbow:
    movf    PARAM3_L, W, A
    bz      Step_Wrist      ; Skip if zero
    btfsc   WREG, 7, A
    bra     Step_Elbow_Neg
    call    Elbow_StepsForward
    bra     Step_Wrist
Step_Elbow_Neg:
    ; Negate W using temp (negf WREG unreliable)
    movwf   PARSE_TEMP, A       ; Save to temp
    negf    PARSE_TEMP, A       ; Negate temp
    movf    PARSE_TEMP, W, A    ; Load back to W
    call    Elbow_StepsBackward

Step_Wrist:
    movf    PARAM4_L, W, A
    bz      Step_Hold_Motors    ; Skip if zero, but still hold motors
    btfsc   WREG, 7, A
    bra     Step_Wrist_Neg
    call    Wrist_StepsForward
    goto    Step_Hold_Motors
Step_Wrist_Neg:
    ; Negate W using temp (negf WREG unreliable)
    movwf   PARSE_TEMP, A       ; Save to temp
    negf    PARSE_TEMP, A       ; Negate temp
    movf    PARSE_TEMP, W, A    ; Load back to W
    call    Wrist_StepsBackward
    goto    Step_Hold_Motors

; ==============================================================================
; Ensure motor patterns are written to hold position after stepping
; ==============================================================================
Step_Hold_Motors:
    ; Explicitly rewrite motor patterns to ports to ensure motors hold position
    call    WritePortD          ; Hold Base and Claw motors
    call    WritePortE          ; Hold Shoulder and Elbow motors
    call    WritePortH          ; Hold Wrist motors
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

; ==============================================================================
; Debug: Send byte as 2-digit hex
; ==============================================================================
; Input: W = byte to send as hex
; Output: Sends two ASCII hex characters
UART_Send_Hex_Byte:
    movwf   0x03, A             ; Save byte to temp
    
    ; Send high nibble
    swapf   0x03, W, A          ; Get high nibble in low position
    andlw   0x0F                ; Mask to 4 bits
    movwf   0x04, A             ; Save nibble value
    call    Nibble_To_Hex       ; Convert and send
    
    ; Send low nibble
    movf    0x03, W, A          ; Get original byte
    andlw   0x0F                ; Mask low nibble
    movwf   0x04, A             ; Save nibble value
    call    Nibble_To_Hex       ; Convert and send
    return

; Convert nibble (0-15) in 0x04 to ASCII hex char and send
; Input: 0x04 = nibble value (0-15)
; Trashes: W
Nibble_To_Hex:
    movf    0x04, W, A          ; Get nibble
    sublw   9                   ; W = 9 - nibble, C=0 if nibble > 9
    btfss   STATUS, 0, A        ; Skip if nibble <= 9
    bra     Nibble_Hex_Letter
    ; Nibble <= 9, use '0'-'9'
    movf    0x04, W, A          ; Get nibble again
    addlw   '0'                 ; Convert to ASCII '0'-'9'
    call    UART_TX_Byte_Fast
    return
Nibble_Hex_Letter:
    ; Nibble > 9, use 'A'-'F'
    movf    0x04, W, A          ; Get nibble
    addlw   -10                 ; Convert 10-15 to 0-5
    addlw   'A'                 ; Convert to ASCII 'A'-'F'
    call    UART_TX_Byte_Fast
    return

; ==============================================================================
; Debug: Send parsed parameters as hex string
; ==============================================================================
UART_Send_Debug_Params:
    ; Send "P:" prefix
    movlw   'P'
    call    UART_TX_Byte_Fast
    movlw   ':'
    call    UART_TX_Byte_Fast
    
    ; Send PARAM1_L
    movf    PARAM1_L, W, A
    call    UART_Send_Hex_Byte
    movlw   ' '
    call    UART_TX_Byte_Fast
    
    ; Send PARAM2_L
    movf    PARAM2_L, W, A
    call    UART_Send_Hex_Byte
    movlw   ' '
    call    UART_TX_Byte_Fast
    
    ; Send PARAM3_L
    movf    PARAM3_L, W, A
    call    UART_Send_Hex_Byte
    movlw   ' '
    call    UART_TX_Byte_Fast
    
    ; Send PARAM4_L
    movf    PARAM4_L, W, A
    call    UART_Send_Hex_Byte
    movlw   0x0A                ; Newline
    call    UART_TX_Byte_Fast
    return

    END
