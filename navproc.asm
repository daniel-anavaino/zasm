;; navproc.asm

;**********************************
; NAVPROC
;   Process keys in navigation mode
;
; navmode:
;  H/shift-5 LEFT
;  J/shift-6 DOWN
;  K/shift-7 UP
;  L/shift-8 RIGHT
;  I INSERT
;  A APPEND
;  $(SHIFT-U) EOL
;  0 BOL
;  DD DELETE LINE
;  P  PUT
;**********************************
; Inputs:
;   A   decoded keypress
;
; Outputs:
;   None
;
; Side effects:
;   None
;**********************************
NAVPROC
        CP      _H
        JR      Z,NAVPROC_LEFT
        CP	_I
        JR	Z,NAVPROC_ENABLE_INS
        CP      _J
        JR      Z,NAVPROC_DOWN
        CP      _K
        JR      Z,NAVPROC_UP
        CP      _L
        JR      Z,NAVPROC_RIGHT
        RET

NAVPROC_ENABLE_INS
        PUSH    AF
        LD      A,insmode
	CALL    SET_MODE
        POP     AF
	RET

NAVPROC_LEFT
        RET

NAVPROC_DOWN
        RET

NAVPROC_UP
        RET

NAVPROC_RIGHT
        RET