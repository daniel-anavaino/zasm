;; Z80 Opcodes 
; A compact format of Z80 opcodes
; 
; Taken from http://www.z80.info/decoding.htm
;
; Opcode Format
;
;  |  7  |  6  |  5  |  4  |  3  |  2  |  1  |  0  |
;  -------------------------------------------------
;  |     x     |        y        |        z        |
;  -------------------------------------------------
;              |     p     |  q  |
;  -------------------------------------------------
;
; Definitions
;
; d      - displacement (8-bit signed)
; n      - immediate    (8-bit unsigned)
; nn     - immediate    (16-bit unsigned)
; tab[x] - table lookups - these are registers
;

; Opcode and register strings

; 8-bit registers
_Z80_REG_A       .byte _A,$ff
_Z80_REG_B       .byte _B,$ff
_Z80_REG_C       .byte _C,$ff
_Z80_REG_D       .byte _D,$ff
_Z80_REG_E       .byte _E,$ff
_Z80_REG_F       .byte _F,$ff
_Z80_REG_H       .byte _H,$ff
_Z80_REG_L       .byte _L,$ff
; plus the (HL) byte at address
_Z80_REG_IND_HL  .byte _LPAREN,_H,_L,_RPAREN,$ff

; 16-bit registers
_Z80_REG_AF      .byte _A,_F,$ff
_Z80_REG_BC      .byte _B,_C,$ff
_Z80_REG_DE      .byte _D,_E,$ff
_Z80_REG_HL      .byte _H,_L,$ff
_Z80_REG_SP      .byte _S,_P,$ff

; condition codes
_Z80_CC_Z        .byte _Z,$ff
_Z80_CC_NZ       .byte _N,_Z,$ff
_Z80_CC_C        .byte _C,$ff
_Z80_CC_NC       .byte _N,_C,$ff
_Z80_CC_PO       .byte _P,_O,$ff
_Z80_CC_PE       .byte _P,_E,$ff
_Z80_CC_P        .byte _P,$ff
_Z80_CC_M        .byte _M,$ff

; ALU instructions
_Z80_ALU_ADD_A   .byte _A,_D,_D,_SPACE,_A,_COMMA,$ff
_Z80_ALU_ADC_A   .byte _A,_D,_D,_SPACE,_C,_COMMA,$ff
_Z80_ALU_SUB     .byte _S,_U,_B,$ff
_Z80_ALU_SBC_A   .byte _S,_B,_C,_SPACE,_A,_COMMA,$ff
_Z80_ALU_AND     .byte _A,_N,_D,$ff
_Z80_ALU_XOR     .byte _X,_O,_R,$ff
_Z80_ALU_OR      .byte _O,_R,$ff
_Z80_ALU_CP      .byte _C,_P,$ff

; rotate instructions
_Z80_ROT_RLC     .byte _R,_L,_C,$ff
_Z80_ROT_RRC     .byte _R,_R,_C,$ff
_Z80_ROT_RL      .byte _R,_L,$ff
_Z80_ROT_RR      .byte _R,_R,$ff
_Z80_ROT_SLA     .byte _S,_L,_A,$ff
_Z80_ROT_SRA     .byte _S,_R,_A,$ff
_Z80_ROT_SLL     .byte _S,_L,_L,$ff
_Z80_ROT_SRL     .byte _S,_R,_L,$ff

; do immediates go here? I don't understand this table ("im") yet
; they're all 0, 1, 2, and 0/1

; block instructions
_Z80_BLI_LDI     .byte _L,_D,_I,$ff
_Z80_BLI_LDD     .byte _L,_D,_D,$ff
_Z80_BLI_LDIR    .byte _L,_D,_I,_R,$ff
_Z80_BLI_LDDR    .byte _L,_D,_D,_R,$ff
_Z80_BLI_CPI     .byte _C,_P,_I,$ff
_Z80_BLI_CPD     .byte _C,_P,_D,$ff
_Z80_BLI_CPIR    .byte _C,_P,_I,_R,$ff
_Z80_BLI_CPDR    .byte _C,_P,_D,_R,$ff
_Z80_BLI_INI     .byte _I,_N,_I,$ff
_Z80_BLI_IND     .byte _I,_N,_D,$ff
_Z80_BLI_INIR    .byte _I,_N,_I,_R,$ff
_Z80_BLI_INDR    .byte _I,_N,_D,_R,$ff
_Z80_BLI_OUTI    .byte _O,_U,_T,_I,$ff
_Z80_BLI_OUTD    .byte _O,_U,_T,_D,$ff
_Z80_BLI_OTIR    .byte _O,_T,_I,_R,$ff
_Z80_BLI_OTDR    .byte _O,_T,_D,_R,$ff

; Unprefixed Opcodes
; I. x = 0
;
;   A. z = 0
;       i) y=0..7
_Z80_OP_NOP      .byte _N,_O,_P,$ff
_Z80_OP_EXAFAF   .byte _E,_X,_SPACE,_A,_F,_COMMA,_A,_F,_GR_1000,$ff ; no apostrophe so using a graphic block
_Z80_OP_DJNZ     .byte _D,_J,_N,_Z,$ff
_Z80_OP_JR       .byte _J,_R,,$ff
;   B. z = 1
;       i) q = 0,1
_Z80_OP_LD       .byte _L,_D,$ff
_Z80_OP_ADD_HL   .byte _A,_D,_D,_SPACE,_H,_L,_COMMA,$ff
;   C. z = 2
;       i) q = 0
;           a) p = 0..3
_Z80_OP_LD_IND_BC_A      .byte _L,_D,_SPACE,_LPAREN,_B,_C,_RPAREN,_COMMA,_A,$ff
_Z80_OP_LD_IND_DE_A      .byte _L,_D,_SPACE,_LPAREN,_D,_E,_RPAREN,_COMMA,_A,$ff
_Z80_OP_LD_IND_nn_HL     .byte _L,_D,_SPACE,_LPAREN|$80,_RPAREN,_COMMA,_H,_L,$ff ; inverse '(' flags a fill location
_Z80_OP_LD_IND_nn_A      .byte _L,_D,_SPACE,_LPAREN|$80,_RPAREN,_COMMA,_A,$ff ; inverse '(' flags a fill location
;       ii) q = 1
;           a) p = 0..3
_Z80_OP_LD_A_IND_BC      .byte _L,_D,_SPACE,_A,_COMMA,_LPAREN,_B,_C,_RPAREN,$ff
_Z80_OP_LD_A_IND_DE      .byte _L,_D,_SPACE,_A,_COMMA,_LPAREN,_D,_E,_RPAREN,$ff
_Z80_OP_LD_IND_HL_nn     .byte _L,_D,_SPACE,_H,_L,_COMMA,_LPAREN|$80,_RPAREN,$ff ; inverse '(' flags a fill location
_Z80_OP_LD_A_IND_nn      .byte _L,_D,_SPACE,_A,_COMMA,_LPAREN|$80,_RPAREN,,$ff ; inverse '(' flags a fill location
;   D,E,F. z = 3,4,5
;       i) q = 0,1 (for z=3)
;
_Z80_OP_INC              .byte _I,_N,_C,$ff
_Z80_OP_DEC              .byte _D,_E,_C,$ff
;   G. z = 6
;       defined in B.i.
;   H. z = 7
;       i) y = 0..7
_Z80_OP_RLCA             .byte _R,_L,_C,_A,$ff
_Z80_OP_RRCA             .byte _R,_R,_C,_A,$ff
_Z80_OP_RLA              .byte _R,_L,_A,$ff
_Z80_OP_RRA              .byte _R,_R,_A,$ff
_Z80_OP_DAA              .byte _D,_A,_A,$ff
_Z80_OP_CPL              .byte _C,_P,_L,$ff
_Z80_OP_SCF              .byte _S,_C,_F,$ff
_Z80_OP_CCF              .byte _C,_C,_F,$ff
; II. x = 1
;   These are all 8-bit LD instructions except for
;     z = 6
_Z80_OP_HALT             .byte _H,_A,_L,_T,$ff
; III. x = 2
;   These are all of the ALU  instructions
;
; IV. x = 3
;   A. z = 0
_Z80_OP_RET              .byte _R,_E,_T,$ff ; conditional return
;   B. z = 1
;       a) q = 0
_Z80_OP_POP              .byte _P,_O,_P,$ff
;       b) q = 1
;           i) p = 0..3
;
; p = 0 RET is already defined
_Z80_OP_EXX              .byte _E,_X,_X,$ff
_Z80_OP_JP_HL            .byte _J,_P,_SPACE,_H,_L$ff
_Z80_OP_LD_SP_HL         .byte _L,_D,_SPACE,_S,_P,_COMMA,_H,_L,$ff
;   C. z = 2
_Z80_OP_JP               .byte _J,_P,$ff
;   D. z = 3
;       a) y = 0..7
;
; y = 0 JP is already defined, y = 1 is the CB prefix
_Z80_OP_OUT_IND_nn_A     .byte _O,_U,_T,_SPACE,_LPAREN|$80,_RPAREN,_COMMA,_A,$ff ; inverse '(' flags a fill location
_Z80_OP_IN_A_IND_nn      .byte _I,_N,_SPACE,_A,_COMMA,_LPAREN|$80,_RPAREN,$ff ; inverse '(' flags a fill location
_Z80_OP_EX_IND_SP_HL     .byte _E,_X,_SPACE,_LPAREN,_S,_P,_RPAREN,_COMMA,_H,_L,$ff
_Z80_OP_EX_DE_HL         .byte _E,_X,_SPACE,_D,_E,_RPAREN,_COMMA,_H,_L,$ff
_Z80_OP_DI               .byte _D,_I,$ff
_Z80_OP_EI               .byte _E,_I,$ff
;   E. z = 4
_Z80_OP_CALL             .byte _C,_A,_L,_L,$ff
;   F. z = 5
;       a) q = 0
_Z80_OP_PUSH             .byte _P,_U,_S,_H,$ff
;       b) q = 1
;           i) p = 0
; CALL is already defined
;
;           ii) p = 1 .. 3
; DD, ED, FD prefixes
;
;   G. z = 6
; ALU opcodes
;
;   H. z = 7
_Z80_OP_RST              .byte _R,_S,_T,$ff

;
; Tables are arrays of pointers to strings
;
_TABLE_R
    .word _Z80_REG_B
    .word _Z80_REG_C
    .word _Z80_REG_D
    .word _Z80_REG_E
    .word _Z80_REG_H
    .word _Z80_REG_L
    .word _Z80_REG_IND_HL
    .word _Z80_REG_A

_TABLE_RP
    .word _Z80_REG_BC
    .word _Z80_REG_DE
    .word _Z80_REG_HL
    .word _Z80_REG_SP

; this can probably be compressed since rp2[3] is the only difference
; from rp
_TABLE_RP2
    .word _Z80_REG_BC
    .word _Z80_REG_DE
    .word _Z80_REG_HL
    .word _Z80_REG_AF

_TABLE_CC
    .word _Z80_CC_NZ
    .word _Z80_CC_Z
    .word _Z80_CC_NC
    .word _Z80_CC_C
    .word _Z80_CC_PO
    .word _Z80_CC_PE
    .word _Z80_CC_P
    .word _Z80_CC_M

_TABLE_ALU
    .word _Z80_ALU_ADD_A
    .word _Z80_ALU_ADC_A
    .word _Z80_ALU_SUB
    .word _Z80_ALU_SBC_A
    .word _Z80_ALU_AND
    .word _Z80_ALU_XOR
    .word _Z80_ALU_OR
    .word _Z80_ALU_CP

_TABLE_ROT
    .word _Z80_ROT_RLC
    .word _Z80_ROT_RRC
    .word _Z80_ROT_RL
    .word _Z80_ROT_RR
    .word _Z80_ROT_SLA
    .word _Z80_ROT_SRA
    .word _Z80_ROT_SLL
    .word _Z80_ROT_SRL

_TABLE_IM
; no idea

; 4x4 table
_TABLE_BLI
; [0][0..3]
    .word _Z80_BLI_LDI
    .word _Z80_BLI_CPI
    .word _Z80_BLI_INI
    .word _Z80_BLI_OUTI
; [1][0..3]
    .word _Z80_BLI_LDD
    .word _Z80_BLI_CPD
    .word _Z80_BLI_IND
    .word _Z80_BLI_OUTD
; [2][0..3]
    .word _Z80_BLI_LDIR
    .word _Z80_BLI_CPIR
    .word _Z80_BLI_INIR
    .word _Z80_BLI_OTIR
; [3][0..3]
    .word _Z80_BLI_LDDR
    .word _Z80_BLI_CPDR
    .word _Z80_BLI_INDR
    .word _Z80_BLI_OTDR


;**********************************
; Z80_DECODE_OPCODE_BITS
;   
;**********************************
; Inputs:
;   HL  Pointer to opcode
;
; Outputs:
;   A - x
;   B - y
;   C - z
;
; Side effects:
;   HL - points to opcode parameters
;        handles extended opcodes
;**********************************
Z80_DECODE_OPCODE_BITS
    PUSH    DE
    LD      A,(HL)
    LD      D,A     ; save A
    ; calculate lowest octal and store in z (C)
    AND     $07
    LD      C,A
    ; calculate 2nd octal and store in y (B)
    LD      A,D     ; restore A
    RRA             ; shift down 3 bits and mask
    RRA
    RRA
    AND     $07
    LD      B,A
    ; calculate 3rd octal and store in x (A, so nothing needed)
    LD      A,D     ; restore A
    RRA             ; shift down 6 bits and mask
    RRA
    RRA
    RRA
    RRA
    RRA
    AND     $03     ; it's really only 2 bits of the octal
    POP     DE
    RET

