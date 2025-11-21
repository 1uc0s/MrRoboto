#include <xc.inc>

; ==============================================================================
; UART Module with Serial Command Handler for Robot Arm Control
; ==============================================================================
; This module combines UART communication with command parsing and execution.
; It receives commands from Python control software and controls the robot arm.
;
; Protocol Commands:
;   MOVE <theta1> <theta2> <theta3> <theta4>  - Move to joint angles (degrees)
;   STEP <steps1> <steps2> <steps3> <steps4>  - Move by step counts
;   HOME                                       - Move to home position
;   STOP                                       - Emergency stop
;   STATUS                                     - Report current angles
;   SPEED <value>                              - Set motor speed
;   CAL <joint> <steps>                        - Calibrate single joint
;
; Future ADC Support (for potentiometer inputs):
;   POT                                        - Read ADC values for r, phi, z
;   Response: ADC <r_val> <phi_val> <z_val>
;   Potentiometers connected to:
;     - r (radius): PORTA (e.g., RA0 via J5 jumper)
;     - phi (azimuth): PORTF (e.g., RF1 via J6 jumper)
;     - z (height): PORTA or PORTF remaining pin
;   ADC: 12-bit resolution (0-4095 range on PIC18F87K22)
;
; Responses:
;   OK        - Command completed successfully
;   ERROR     - Command failed
;   STATUS <theta1> <theta2> <theta3> <theta4>  - Current joint angles
; ==============================================================================

; ==============================================================================
; Exports - Functions available to other modules
; ==============================================================================
global  UART_Setup, UART_Transmit_Message, UART_Transmit_Byte
global  UART_Init, UART_RX_ISR, UART_Send_OK, UART_Send_Error
global  UART_Reset_Buffer

; ==============================================================================
; Imports - Functions from motor_control.s
; ==============================================================================
; extern  Base_StepsForward, Base_StepsBackward
; extern  Shoulder_StepsForward, Shoulder_StepsBackward
; extern  Elbow_StepsForward, Elbow_StepsBackward
; extern  Wrist_StepsForward, Wrist_StepsBackward
; Note: extern declarations commented out - not needed until functions are called

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

psect	udata_acs   ; reserve data space in access ram
UART_counter: ds    1	    ; reserve 1 byte for variable UART_counter

; ==============================================================================
; UART Setup and Initialization
; ==============================================================================
psect	uart_code,class=CODE

; UART_Setup: Original working setup routine (9600 baud, 8N1)
UART_Setup:
    bsf	    SPEN	; enable serial port
    bcf	    SYNC	; asynchronous mode
    bcf	    BRGH	; slow speed
    bsf	    TXEN	; enable transmit
    bcf	    BRG16	; 8-bit generator only
    movlw   103		; gives 9600 Baud rate (actually 9615)
    movwf   SPBRG1, A	; set baud rate
    bsf	    TRISC, PORTC_TX1_POSN, A	; TX1 pin is output on RC6 pin
    return

; UART_Init: Extended initialization with receive and interrupts
UART_Init:
    ; Configure UART1 for 9600 baud, 8N1
    ; Assumes FOSC = 16 MHz
    
    ; Disable UART first
    bcf	    SPEN	    ; Serial port disable
    
    ; Configure baud rate generator
    ; SPBRG = (FOSC / (64 * Baud)) - 1  for BRGH=0
    ; SPBRG = (16000000 / (64 * 9600)) - 1 = 25.04 ≈ 25
    ; Using 103 for better accuracy (from working UART_Setup)
    movlw   103
    movwf   SPBRG1, A
    
    bcf	    BRGH	    ; Low speed baud rate
    bcf	    BRG16	    ; 8-bit baud rate generator
    
    ; Configure TX
    bsf     TRISC, PORTC_TX1_POSN, A    ; RC6 = TX1 as output
    bsf	    TXEN	    ; Enable transmitter
    
    ; Configure RX
    bsf     TRISC, PORTC_RX1_POSN, A    ; RC7 = RX1 as input
    bsf	    CREN	    ; Enable receiver
    
    ; Enable UART
    bsf	    SPEN	    ; Serial port enable
    
    ; Enable RX interrupt
    bsf     PIE1, 5, A		    ; Enable UART1 receive interrupt (RC1IE = bit 5)
    bsf     INTCON, 6, A		    ; Enable peripheral interrupts (PEIE = bit 6)
    bsf     INTCON, 7, A		    ; Enable global interrupts (GIE = bit 7)
    
    ; Initialize buffer pointers
    clrf    UART_RX_IDX, A
    clrf    UART_RX_COUNT, A
    clrf    CMD_TYPE, A
    
    return

; ==============================================================================
; UART Transmit Functions
; ==============================================================================
UART_Transmit_Message:	    ; Message stored at FSR2, length stored in W
    movwf   UART_counter, A
UART_Loop_message:
    movf    POSTINC2, W, A
    call    UART_Transmit_Byte
    decfsz  UART_counter, A
    bra	    UART_Loop_message
    return

UART_Transmit_Byte:	    ; Transmits byte stored in W
    btfss   TX1IF	    ; TX1IF is set when TXREG1 is empty
    bra	    UART_Transmit_Byte
    movwf   TXREG1, A
    return

UART_TX_Byte:               ; Alias for compatibility
    ; Wait for TX buffer to be empty
    btfss   TRMT
    bra     $-2
    
    ; Send byte
    movwf   TXREG1, A
    return

; ==============================================================================
; UART Receive Interrupt Handler
; ==============================================================================
; Call this from main ISR when RC1IF is set
; ==============================================================================
UART_RX_ISR:
    ; Check for receive errors
    btfsc   OERR	    ; Overrun error?
    call    UART_Clear_Errors
    
    btfsc   FERR	    ; Framing error?
    call    UART_Clear_Errors
    
    ; Read received byte
    movf    RCREG1, W, A            ; Read from receive register (clears RC1IF)
    
    ; Check for newline (command terminator)
    sublw   0x0A                    ; Compare with '\n'
    btfsc   STATUS, 2, A
    goto    UART_Process_Command    ; Complete command received
    
    ; Check for carriage return (also treat as newline)
    movf    RCREG1, W, A
    sublw   0x0D                    ; Compare with '\r'
    btfsc   STATUS, 2, A
    goto    UART_Process_Command
    
    ; Store byte in buffer if not full
    movf    UART_RX_COUNT, W, A
    sublw   UART_RX_BUFFER_SIZE - 1 ; Check if buffer full
    btfsc   STATUS, 0, A            ; Carry clear = buffer full
    goto    UART_Store_Byte
    
    ; Buffer full, ignore byte
    return
    
UART_Store_Byte:
    ; Calculate buffer address
    movlw   HIGH UART_RX_BUFFER
    movwf   FSR0H, A
    movlw   LOW UART_RX_BUFFER
    addwf   UART_RX_IDX, W, A
    movwf   FSR0L, A
    
    ; Store byte
    movf    RCREG1, W, A
    movwf   INDF0, A
    
    ; Increment counters
    incf    UART_RX_IDX, F, A
    incf    UART_RX_COUNT, F, A
    
    return

UART_Clear_Errors:
    bcf	    CREN	    ; Disable receiver
    bsf	    CREN	    ; Re-enable receiver
    return

; ==============================================================================
; Process Received Command
; ==============================================================================
UART_Process_Command:
    ; Null-terminate buffer
    movlw   HIGH UART_RX_BUFFER
    movwf   FSR0H, A
    movlw   LOW UART_RX_BUFFER
    addwf   UART_RX_IDX, W, A
    movwf   FSR0L, A
    clrf    INDF0, A                ; Add null terminator
    
    ; Parse command
    call    Parse_Command
    
    ; Execute command based on type
    movf    CMD_TYPE, W, A
    
    sublw   CMD_MOVE
    btfsc   STATUS, 2, A
    goto    Execute_Move
    
    movf    CMD_TYPE, W, A
    sublw   CMD_STEP
    btfsc   STATUS, 2, A
    goto    Execute_Step
    
    movf    CMD_TYPE, W, A
    sublw   CMD_HOME
    btfsc   STATUS, 2, A
    goto    Execute_Home
    
    movf    CMD_TYPE, W, A
    sublw   CMD_STOP
    btfsc   STATUS, 2, A
    goto    Execute_Stop
    
    movf    CMD_TYPE, W, A
    sublw   CMD_STATUS
    btfsc   STATUS, 2, A
    goto    Execute_Status
    
    movf    CMD_TYPE, W, A
    sublw   CMD_SPEED
    btfsc   STATUS, 2, A
    goto    Execute_Speed
    
    movf    CMD_TYPE, W, A
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
    clrf    CMD_TYPE, A
    
    ; Check for "MOVE"
    movlw   HIGH UART_RX_BUFFER
    movwf   FSR0H, A
    movlw   LOW UART_RX_BUFFER
    movwf   FSR0L, A
    
    movf    INDF0, W, A
    sublw   'M'
    btfss   STATUS, 2, A
    goto    Parse_Check_Step
    
    ; Could be MOVE
    movf    POSTINC0, W, A
    sublw   'O'
    btfss   STATUS, 2, A
    goto    Parse_Failed
    
    movf    POSTINC0, W, A
    sublw   'V'
    btfss   STATUS, 2, A
    goto    Parse_Failed
    
    movf    POSTINC0, W, A
    sublw   'E'
    btfss   STATUS, 2, A
    goto    Parse_Failed
    
    ; It's MOVE command
    movlw   CMD_MOVE
    movwf   CMD_TYPE, A
    call    Parse_Four_Params       ; Parse 4 angle parameters
    return

Parse_Check_Step:
    ; Check for "STEP"
    movlw   HIGH UART_RX_BUFFER
    movwf   FSR0H, A
    movlw   LOW UART_RX_BUFFER
    movwf   FSR0L, A
    
    movf    INDF0, W, A
    sublw   'S'
    btfss   STATUS, 2, A
    goto    Parse_Check_Home
    
    movf    POSTINC0, W, A
    sublw   'T'
    btfss   STATUS, 2, A
    goto    Parse_Check_Status      ; Could be STATUS
    
    movf    POSTINC0, W, A
    sublw   'E'
    btfss   STATUS, 2, A
    goto    Parse_Failed
    
    movf    POSTINC0, W, A
    sublw   'P'
    btfss   STATUS, 2, A
    goto    Parse_Failed
    
    ; It's STEP command
    movlw   CMD_STEP
    movwf   CMD_TYPE, A
    call    Parse_Four_Params
    return

Parse_Check_Status:
    ; Already read "ST", check for "ATUS"
    movf    POSTINC0, W, A
    sublw   'A'
    btfss   STATUS, 2, A
    goto    Parse_Failed
    
    movf    POSTINC0, W, A
    sublw   'T'
    btfss   STATUS, 2, A
    goto    Parse_Failed
    
    movf    POSTINC0, W, A
    sublw   'U'
    btfss   STATUS, 2, A
    goto    Parse_Failed
    
    movf    POSTINC0, W, A
    sublw   'S'
    btfss   STATUS, 2, A
    goto    Parse_Failed
    
    ; It's STATUS command
    movlw   CMD_STATUS
    movwf   CMD_TYPE, A
    return

Parse_Check_Home:
    ; Check for "HOME"
    movlw   HIGH UART_RX_BUFFER
    movwf   FSR0H, A
    movlw   LOW UART_RX_BUFFER
    movwf   FSR0L, A
    
    movf    INDF0, W, A
    sublw   'H'
    btfss   STATUS, 2, A
    goto    Parse_Check_Stop
    
    movf    POSTINC0, W, A
    sublw   'O'
    btfss   STATUS, 2, A
    goto    Parse_Failed
    
    movf    POSTINC0, W, A
    sublw   'M'
    btfss   STATUS, 2, A
    goto    Parse_Failed
    
    movf    POSTINC0, W, A
    sublw   'E'
    btfss   STATUS, 2, A
    goto    Parse_Failed
    
    ; It's HOME command
    movlw   CMD_HOME
    movwf   CMD_TYPE, A
    return

Parse_Check_Stop:
    ; Check for "STOP"
    movlw   HIGH UART_RX_BUFFER
    movwf   FSR0H, A
    movlw   LOW UART_RX_BUFFER
    movwf   FSR0L, A
    
    movf    INDF0, W, A
    sublw   'S'
    btfss   STATUS, 2, A
    goto    Parse_Failed
    
    movf    POSTINC0, W, A
    sublw   'T'
    btfss   STATUS, 2, A
    goto    Parse_Failed
    
    movf    POSTINC0, W, A
    sublw   'O'
    btfss   STATUS, 2, A
    goto    Parse_Failed
    
    movf    POSTINC0, W, A
    sublw   'P'
    btfss   STATUS, 2, A
    goto    Parse_Failed
    
    ; It's STOP command
    movlw   CMD_STOP
    movwf   CMD_TYPE, A
    return

Parse_Failed:
    clrf    CMD_TYPE, A
    return

; ==============================================================================
; Parse Four Parameters (for MOVE, STEP commands)
; ==============================================================================
Parse_Four_Params:
    ; Simplified: assumes space-separated decimal integers
    ; Real implementation would need proper ASCII to integer conversion
    ; TODO: Implement proper parameter parsing
    ; For now, parameters should be parsed from command string
    ; and stored in CMD_PARAM1-4
    return

; ==============================================================================
; Command Execution Functions
; ==============================================================================
Execute_Move:
    ; Convert angles to steps and move motors
    ; Parameters in CMD_PARAM1-4 are joint angles (degrees)
    
    ; TODO: Call angle-to-steps conversion
    ; TODO: Call motor movement functions from motor_control.s
    ; For now, just acknowledge command
    
    call    UART_Send_OK
    goto    UART_Reset_Buffer

Execute_Step:
    ; Move motors by step counts
    ; Parameters in CMD_PARAM1-4 are step counts
    
    ; TODO: Parse step counts from parameters
    ; TODO: Call motor stepping functions:
    ;   - Base_StepsForward/Backward
    ;   - Shoulder_StepsForward/Backward
    ;   - Elbow_StepsForward/Backward
    ;   - Wrist_StepsForward/Backward
    
    call    UART_Send_OK
    goto    UART_Reset_Buffer

Execute_Home:
    ; Move all motors to home position
    
    ; TODO: Call homing routine
    ; Home position: all motors at mechanical limits
    ; - Base: center (0°)
    ; - Shoulder: up (0°, at limit)
    ; - Elbow: extended (0°, at limit)
    ; - Wrist: level (0°)
    
    call    UART_Send_OK
    goto    UART_Reset_Buffer

Execute_Stop:
    ; Emergency stop - halt all motors immediately
    
    ; TODO: Stop all motor outputs
    ; Clear all step patterns on PORTD, PORTE, PORTH
    
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
    ; Parse speed value from CMD_PARAM1
    
    call    UART_Send_OK
    goto    UART_Reset_Buffer

Execute_Calibrate:
    ; Move single joint for calibration
    
    ; TODO: Parse joint number (0-3) and steps from parameters
    ; joint 0 = base, 1 = shoulder, 2 = elbow, 3 = wrist
    ; TODO: Move specified joint by given step count
    
    call    UART_Send_OK
    goto    UART_Reset_Buffer

; ==============================================================================
; Reset RX Buffer
; ==============================================================================
UART_Reset_Buffer:
    clrf    UART_RX_IDX, A
    clrf    UART_RX_COUNT, A
    clrf    CMD_TYPE, A
    return

; ==============================================================================
; UART Transmit Response Functions
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
    ; For now, send placeholder values
    
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

; ==============================================================================
; Integration Notes
; ==============================================================================
; To integrate this into main.s:
;
; 1. Add to main initialization:
;    call UART_Init              ; or call UART_Setup for basic TX-only
;
; 2. Add to main ISR (interrupt service routine):
;    btfsc PIR1, RC1IF, A        ; UART receive interrupt?
;    call  UART_RX_ISR           ; Handle received byte
;
; 3. Link with motor_control.s functions:
;    - Implement TODO items in Execute_* functions
;    - Add angle-to-steps conversion
;    - Add current position tracking
;    - Integrate proper motor control calls
;
; 4. For full command support:
;    - Implement Parse_Four_Params for numeric parsing
;    - Add state tracking for current joint angles
;    - Implement homing sequence
;    - Add safety checks and limits
;
; 5. Future ADC support for potentiometers:
;    - Initialize ADC module (12-bit, refs to VDD/VSS)
;    - Add POT command parsing
;    - Read RA0 (or chosen pin) for r
;    - Read RF1 (or chosen pin) for phi
;    - Read remaining pin for z
;    - Format as "ADC <r_val> <phi_val> <z_val>\n"
; ==============================================================================

    end
