;; screen.asm
; Screen update routines

;**********************************
; SCREEN_UPDATE
;   Outputs a screen of Z80 code
;   with editing indicators.
;**********************************
; Inputs:
;   Global D_File
;   Global program_start
;   Global program_line
;
; Outputs:
;   None
;
; Side effects:
;   Updates screen
;**********************************
SCREEN_UPDATE
    PUSH    IX
    PUSH    HL
    PUSH    BC
    PUSH    AF
    LD      HL,(D_FILE)
    INC     HL
    LD      BC,(program_start)
SCREEN_UPDATE_LOOP
    LD      A,B
    CALL    ZASM_PRINT_HEX_BYTE
    LD      A,C
    CALL    ZASM_PRINT_HEX_BYTE
    ; Check for editing line
    LD      IX,(program_line)
    LD      A,B
    CP      (IX+1)
    JR      NZ,SCREEN_UPDATE_NOT_EDIT
    LD      A,C
    CP      (IX)
    JR      NZ,SCREEN_UPDATE_NOT_EDIT
    LD      A,_K | $80
    LD      (HL),A
    INC     HL
SCREEN_UPDATE_NOT_EDIT
    POP     AF
    POP     BC
    POP     HL
    POP     IX
    RET