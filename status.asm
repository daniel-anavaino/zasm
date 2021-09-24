;; status.asm

;**********************************
; STATUS_LINE_UPDATE
;   Updates the status line
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
STATUS_LINE_UPDATE
        PUSH    AF
        PUSH    BC
        PUSH    HL
	CALL	STATUS_MODE_UPDATE
        CALL    STATUS_POS_UPDATE
        LD      HL,bottom_line
        LD      BC,status_line_format
STATUS_LINE_UPDATE_LOOP
        LD      A,(BC)
        CP      $ff
        JR      Z,STATUS_LINE_UPDATE_DONE
        LD      (HL),A
        INC     HL
        INC     BC
        JR      STATUS_LINE_UPDATE_LOOP
STATUS_LINE_UPDATE_DONE
        POP     HL
        POP     BC
        POP     AF
        RET

;**********************************
; STATUS_MODE_UPDATE
;   Updates the current editing mode
;   in the status line
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
STATUS_MODE_UPDATE
        PUSH    HL
	CALL    GET_MODE
	LD	HL,status_line_mode  ; set HL so we can update the mode in each piece below
	CP	navmode
	JR	NZ,STATUS_MODE_UPDATE_NOTNAV
	LD	(HL),_N | $80
        POP     HL
        RET
STATUS_MODE_UPDATE_NOTNAV
        CP	insmode
	JR	NZ,STATUS_MODE_UPDATE_NOTINS
	LD	(HL),_I | $80
        POP     HL
	RET
STATUS_MODE_UPDATE_NOTINS
        CP	exmode
        JR      NZ,STATUS_MODE_UPDATE_UNKNOWN
	LD	(HL),_COLON
STATUS_MODE_UPDATE_UNKNOWN
        POP     HL
	RET

;**********************************
; STATUS_POS_UPDATE
;   Updates the line,column editing
;   position in the status line.
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
STATUS_POS_UPDATE
        PUSH    AF
        PUSH    HL
        LD      HL,status_line_location
        LD      A,(S_POSN)
        POP     HL
        POP     AF
        RET