;; zasmgnrl.asm
;   General support routines

;**********************************
; RESET_TIMER
;   Resets cursor timer
;**********************************
; Inputs:
;   None
;
; Outputs:
;   None
;
; Side effects:
;   None
;**********************************
RESET_TIMER
    PUSH    HL
    LD      HL,blinktime
    LD      (cursortimer),HL
    POP     HL
    RET

;**********************************
; SET_MODE
;   Sets editing mode
;**********************************
; Inputs:
;   A   editing mode
;
; Outputs:
;   None
;
; Side effects:
;   None
;**********************************
SET_MODE
    LD      (MODE),A
    RET

;**********************************
; GET_MODE
;   Gets editing mode
;**********************************
; Inputs:
;   None
;
; Outputs:
;   A   editing mode
;
; Side effects:
;   None
;**********************************
GET_MODE
    LD      A,(MODE)
    RET


;**********************************
; NEXT_COLUMN
;   Increments column number, wraps
;   if necessary (and possible) and
;   sets cursor_posn appropriately
;**********************************
; Inputs:
;   None
;
; Outputs:
;   None
;
; Side effects:
;   cursor_posn,col_number,line_number
;**********************************
NEXT_COLUMN
    PUSH    HL
    PUSH    AF
    LD      HL,(cursor_posn)
    LD      A,(col_number)
    CP      31
    JR      Z,NEXT_COLUMN_WRAP
    INC     A
    LD      (col_number),A
    INC     HL
    CALL    UPDATE_CURSOR
    JR      NEXT_COLUMN_NO_WRAP
NEXT_COLUMN_WRAP
    LD      A,0
    LD      (col_number),A
    CALL    NEXT_LINE
NEXT_COLUMN_NO_WRAP
    POP     AF
    POP     HL
    RET

;**********************************
; NEXT_LINE
;   Increments liine number, wraps
;   if necessary (and possible) and
;   sets cursor_posn appropriately
;**********************************
; Inputs:
;   None
;
; Outputs:
;   None
;
; Side effects:
;   cursor_posn,col_number,line_number
;**********************************
NEXT_LINE
    PUSH    HL
    PUSH    BC
    PUSH    AF
    LD      A,(line_number)
    CP      22
    JR      Z,NEXT_LINE_LIMIT
    INC     A
    LD      (line_number),A
    CALL    CALCULATE_CURSOR_POSN
NEXT_LINE_LIMIT
    POP     AF
    POP     BC
    POP     HL
    RET

;**********************************
; PREVIOUS_COLUMN
;   Decrements column number, unwraps
;   if necessary (and possible) and
;   sets cursor_posn appropriately
;**********************************
; Inputs:
;   None
;
; Outputs:
;   None
;
; Side effects:
;   cursor_posn,col_number,line_number
;**********************************
PREVIOUS_COLUMN
    PUSH    HL
    PUSH    AF
    LD      HL,(cursor_posn)
    LD      A,(col_number)
    CP      0
    JR      Z,PREVIOUS_COLUMN_UNWRAP
    DEC     A
    LD      (col_number),A
    DEC     HL
    CALL    UPDATE_CURSOR
    JR      PREVIOUS_COLUMN_NO_UNWRAP
PREVIOUS_COLUMN_UNWRAP
    LD      A,31
    LD      (col_number),A
    CALL    PREVIOUS_LINE
PREVIOUS_COLUMN_NO_UNWRAP
    POP     AF
    POP     HL
    RET

;**********************************
; PREVIOUS_LINE
;   Decrements line number, unwraps
;   if necessary (and possible) and
;   sets cursor_posn appropriately
;**********************************
; Inputs:
;   None
;
; Outputs:
;   None
;
; Side effects:
;   cursor_posn,col_number,line_number
;**********************************
PREVIOUS_LINE
    PUSH    HL
    PUSH    BC
    PUSH    AF
    LD      A,(line_number)
    CP      0
    JR      Z,PREVIOUS_LINE_LIMIT
    DEC     A
    LD      (line_number),A
    CALL    CALCULATE_CURSOR_POSN
PREVIOUS_LINE_LIMIT
    POP     AF
    POP     BC
    POP     HL
    RET

;**********************************
; CALCULATE_CURSOR_POSN
;   Calculate cursors_posn from
;   col_number and line_number
;**********************************
; Inputs:
;   None
;
; Outputs:
;   None
;
; Side effects:
;   cursor_posn,col_number,line_number
;**********************************
CALCULATE_CURSOR_POSN
    PUSH    HL
    PUSH    BC
    PUSH    AF
    LD      HL,(D_FILE)
    INC     HL
    LD      A,(line_number)
    CP      0
    JR      Z,CCP_UPDATE_CURSOR
CCP_OUTER_LOOP
    LD      B,33    ; line length in memory
CCP_INNER_LOOP
    INC     HL
    DJNZ    CCP_INNER_LOOP
    DEC     A
    JR      NZ,CCP_OUTER_LOOP
CCP_UPDATE_CURSOR
    LD      BC,0
    LD      A,(col_number)
    LD      C,A
    ADD     HL,BC
    CALL    UPDATE_CURSOR
    POP     AF
    POP     BC
    POP     HL
    RET
;**********************************
; UPDATE_CURSOR
;   Clears current cursor and moves
;   to next cursor position passed
;   in HL
;**********************************
; Inputs:
;   HL
;
; Outputs:
;   None
;
; Side effects:
;   cursor_posn
;**********************************
UPDATE_CURSOR
    PUSH    AF
    PUSH    HL
    LD      HL,(cursor_posn)
    LD      A,(HL)
    AND     $7F
    LD      (HL),A
    POP     HL
    LD      (cursor_posn),HL
    POP     AF
    RET
