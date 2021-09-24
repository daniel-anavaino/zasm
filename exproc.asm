;; exproc.asm
;  Processes keys in execution mode

;**********************************
; EXPROC
;   Processes execute mode
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
EXPROC
    PUSH    AF
    POP     AF
    RET
