;; zasmprnt.asm

; TODO: Doesn't check for an EOL...

;

;**********************************
; ZASM_PRINT
;   Outputs the character code in A
;   to the display file at the appropriate
;   position, increments, and wraps as necessary
;**********************************
; Inputs:
;   A   character code to print
;
; Outputs:
;   None
;
; Side effects:
;   None
;**********************************
ZASM_PRINT
    PUSH    HL
    CP      _EOL
    JR      Z,ZASM_PRINT_CR
    LD      HL,(cursor_posn)
    LD      (HL),A
    CALL    NEXT_COLUMN
    JR      ZASM_PRINT_END
ZASM_PRINT_CR
    CALL    NEXT_LINE
ZASM_PRINT_END
    POP     HL
    RET

;**********************************
; ZASM_PRINT_DEC
;   Outputs the value in A in decimal starting at HL
;   and returns with HL pointing to the next position
;**********************************
; Inputs:
;   A   value to print
;   HL  address to print at
;
; Outputs:
;   None
;
; Side effects:
;   HL  points to next position
;**********************************
ZASM_PRINT_DEC
    PUSH    AF
    PUSH    BC
    CALL    ZASM_BYTE_TO_BCD
    LD      A,B
    AND     $0F
    JR      Z,ZASM_PRINT_DEC_TENS
    ADD     A,_0
    CALL    ZASM_PRINT_RAW
ZASM_PRINT_DEC_TENS
    LD      A,C
    AND     $F0
    JR      Z,ZASM_PRINT_DEC_ONES
    RRA     ; move to lower nibble
    RRA
    RRA
    RRA
    ADD     A,_0
    CALL    ZASM_PRINT_RAW
ZASM_PRINT_DEC_ONES
    LD      A,C
    AND     $0F
    ADD     A,_0
    CALL    ZASM_PRINT_RAW
    POP     BC
    POP     AF
    RET

;**********************************
; ZASM_BYTE_TO_BCD
;   Converts a byte to a word BCD value.
;   For example:
;       If A = 217d then BC = 0217h
;**********************************
; Inputs:
;   A   value to convert to BCD
;
; Outputs:
;   BC  BCD value
;
; Side effects:
;   None
;**********************************
; Pseudocode:
;   BC = 0
;   divisor = 100
;   count the 100s
;   OR the count to lower nibble of B
;   count the 10s
;   OR the count to lower nibble C
;   shift left 4
;   OR the remainder
;**********************************
ZASM_BYTE_TO_BCD
    PUSH    AF
    PUSH    HL
    LD      D,A     ; keep a copy of A in D so stack saves aren't necessary
    LD      HL,0
    LD      B,100   ; count 100s column of A
    CALL    ZASM_COUNT_DIGITS
    LD      A,H         ; H = H | B
    OR      B
    LD      H,A         ; lower nibble of H = 100s digit
    LD      A,D         ; restore A
    LD      B,10        ; count 10s column of A
    CALL    ZASM_COUNT_DIGITS
    LD      A,B
    RLA      ; RL A,4 - shift 10s digit into upper nibble of A
    RLA
    RLA
    RLA
    OR      C           ; lower nibble of A = 1s digits
    LD      L,A        ; lower nibble of L = 10s and 1s digits
    LD      B,H
    LD      C,L
    POP     HL
    POP     AF
    RET

;**********************************
; ZASM_COUNT_DIGITS
;   Counts how many times the passed
;   in positional value B occurs in A.
;
;   It's assumed that you'll never
;   count the base^0 position.
;
;   For example:
;       If A = 217d and B = 100d,
;           then A = 2
;       If A = 217d and B = 10d,
;           then A = 1
;**********************************
; Inputs:
;   A   value to check
;   B   positional value
;
; Outputs:
;   B   digits
;   C   remainder
;
; Side effects:
;   None
;**********************************
; Pseudocode: The letter after the tic (')
;   indicates which register is assigned to 
;   that variable.
;
; ZASM_COUNT_DIGIT(value=A, position=B, &digit=B, &remainder=C)
;   digit'D = 0
;   // count the number of 'position' values
;   while(value'A > position'B)
;       digit'D++
;       value'A -= position'B
;   // restore it to a positive value if needed
;   if(value'A < 0)
;       value'A += position'B
;   remainder'C = value'A
;   digit'B = digit'D
;**********************************
ZASM_COUNT_DIGITS
    PUSH    AF
    PUSH    DE
    LD      D,0     ; use D for digit count and return in B
ZASM_COUNT_DIGITS_WHILE
    CP      B
    JR      C,ZASM_COUNT_DIGITS_WHILE_DONE
    INC     D
    SUB      B      ; subtract column from value
    JR      ZASM_COUNT_DIGITS_WHILE
ZASM_COUNT_DIGITS_WHILE_DONE
    CP      0
    JR      NC,ZASM_COUNT_DIGITS_POSITIVE
    ADD     A,B
ZASM_COUNT_DIGITS_POSITIVE
    LD      C,A
    LD      B,D
    POP     DE
    POP     AF
    RET

;**********************************
; ZASM_PRINT
;   Outputs the character in A at HL and
;   returns with HL pointing to the next position
;**********************************
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
;**********************************
ZASM_PRINT_RAW
    LD      (HL),A
    INC     HL
    RET

;**********************************
; ZASM_FILL_PRINT
;   Fills the area pointed at in HL
;   with B values of A
;**********************************
; Inputs:
;   A   value to fill
;   B   number of values to fill
;   HL  address to start fill at
;
; Outputs:
;   None
;
; Side effects:
;   None
;**********************************
ZASM_FILL_PRINT
    PUSH    AF
    PUSH    BC
    PUSH    HL
    ; guard to make sure B isn't zero
    PUSH    AF
    LD      A,B
    CP      0
    JR      Z,ZASM_FILL_PRINT_EXIT
    POP     AF  ; restore A
ZASM_FILL_PRINT_LOOP
    LD      (HL),A
    INC     HL
    DJNZ    ZASM_FILL_PRINT_LOOP
ZASM_FILL_PRINT_EXIT
    POP     HL
    POP     BC
    POP     AF
    RET

;**********************************
; ZASM_PRINT_HEX_BYTE
;   Outputs the value in A at HL
;**********************************
; Inputs:
;   A   value to print
;   HL  address to start print at
;
; Outputs:
;   HL
;
; Side effects:
;   None
;**********************************
ZASM_PRINT_HEX_BYTE
    PUSH    BC
    LD      B,A
    ; upper nibble
    RRA
    RRA
    RRA
    RRA
    CALL    ZASM_PRINT_HEX_NIBBLE
    ; lower nibble
    LD      A,B
    CALL    ZASM_PRINT_HEX_NIBBLE
    LD      A,B
    POP     BC
    RET

;**********************************
; ZASM_PRINT_HEX_NIBBLE
;   Outputs the value in A at HL
;**********************************
; Inputs:
;   A   nibble to print
;   HL  address to start print at
;
; Outputs:
;   HL
;
; Side effects:
;   (HL)
;   A has the upper nibble stripped
;**********************************
ZASM_PRINT_HEX_NIBBLE
    AND     $0F
    ADD     A,_0
    LD      (HL),A
    INC     HL
    RET

