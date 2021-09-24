;; zasmprnt.asm

; TODO: Doesn't check for an EOL...

; Outputs the value in A in decimal starting at HL
; and returns with HL pointing to the next position
; Inputs:
;   A   value to print
;   HL  address to print at
;
; Outputs:
;   None
;
; Side effects:
;   HL  points to next position
;
ZASM_DEC_PRINT
    PUSH    AF
    POP     AF
    RET



ZASM_BYTE_TO_BCD
;   Converts a byte to a word BCD value.
;   A   byte to convert
;   DE  BCD value
;   C   
; For example:
;   If A = 

; Outputs the character in A at HL and
; returns with HL pointing to the next position
;
; Inputs:
;   A   value to print
;   HL  address to print at
;
; Outputs:
;   None
;
; Side effects:
;   HL  points to next position
;
ZASM_PRINT
    LD      (HL),A
    INC     HL
    RET