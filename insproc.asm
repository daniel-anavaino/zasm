;; INSPROC.ASM

;**********************************
; INSPROC
;   Insert mode processing
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
INSPROC
		CP	    _EDIT       ; exit mode when EDIT key is pressed
		JR	    Z,INSPROC_ENABLE_NAV
		CALL	PRINT
		RET
INSPROC_ENABLE_NAV  ; enable navigation mode when exiting insert mode
        PUSH    AF
        LD      A,navmode
		CALL    SET_MODE
        POP     AF
		RET