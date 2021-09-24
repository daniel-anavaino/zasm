;; zasmprnt.asm

; TODO: Doesn't check for an EOL...

; Outputs the value in A in decimal starting at HL
; and returns with HL pointing to the next position
ZASM_DEC_PRINT
    LD      B,A     ; A gets nuked by ZASM_PRINT
    ; first check if it's zero
    CP      0
    JR      NZ,ZASM_DEC_PRINT_NOT_ZERO
    ADD     _0
    CALL    ZASM_PRINT
    RET
ZASM_DEC_PRINT_NOT_ZERO
    ; its only a byte, so it can't be larger than 255, so
    ; start at 100 and work out the number of each power of 10

    LD      
    CP      100
    JR      C,ZASM_DEC_PRINT_TENS   ; if carry, then jump to tens



ZASM_DEC_PRINT_TENS

    ; 80 128
    ; 40 64
    ; 20 32
    ; 10 16
    ; A 10

    RET

ZASM_BYTE_TO_BCD
;   Converts a byte to a word BCD value.
;   A   byte to convert
;   DE  BCD value
;   C   
; For example:
;   If A = 

; Outputs the character in A in decimal at HL and
; returns with HL pointing to the next position
ZASM_PRINT
    LD      (HL),A
    INC     HL
    RET