;; zasmgnrl.asm
;   General support routines

; Inputs:
;   None
;
; Outputs:
;   None
;
; Side effects:
;   None
;
RESET_TIMER
    PUSH    HL
    LD      HL,blinktime
    LD      (cursortimer),HL
    POP     HL
    RET

; Inputs:
;   A   editing mode
;
; Outputs:
;   None
;
; Side effects:
;   None
;
SET_MODE
    LD      (MODE),A
    RET

; Inputs:
;   None
;
; Outputs:
;   A   editing mode
;
; Side effects:
;   None
;
GET_MODE
    LD      A,(MODE)
    RET
