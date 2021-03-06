;; charcode.asm
;     Definitions for the character codes since it's not ASCII

; Graphic block names are as follows:
; _GR_abcd
;   where a is position 0,0, b is 0,1, c is 1,0, and d is 1,1
;   and a 0 means white, 1 means black, and 2 means gray

_SPACE     .equ $00
_GR_1000   .equ $01
_GR_0100   .equ $02
_GR_1100   .equ $03
_GR_0010   .equ $04
_GR_1010   .equ $05
_GR_0110   .equ $06
_GR_1110   .equ $07
_GR_2222   .equ $08
_GR_0022   .equ $09
_GR_2200   .equ $0A
_QUOTE     .equ $0B
_POUND     .equ $0C
_DOLLAR    .equ $0D
_COLON     .equ $0E
_QUESTION  .equ $0F
_LPAREN    .equ $10
_RPAREN    .equ $11
_GREATER   .equ $12
_LESSER    .equ $13
_EQUAL     .equ $14
_PLUS      .equ $15
_MINUS     .equ $16
_ASTERISK  .equ $17
_SLASH     .equ $18
_SEMICOLON .equ $19
_COMMA     .equ $1A
_PERIOD    .equ $1B
_0         .equ $1C
_1         .equ $1D
_2         .equ $1E
_3         .equ $1F
_4         .equ $20
_5         .equ $21
_6         .equ $22
_7         .equ $23
_8         .equ $24
_9         .equ $25
_A         .equ $26
_B         .equ $27
_C         .equ $28
_D         .equ $29
_E         .equ $2A
_F         .equ $2B
_G         .equ $2C
_H         .equ $2D
_I         .equ $2E
_J         .equ $2F
_K         .equ $30
_L         .equ $31
_M         .equ $32
_N         .equ $33
_O         .equ $34
_P         .equ $35
_Q         .equ $36
_R         .equ $37
_S         .equ $38
_T         .equ $39
_U         .equ $3A
_V         .equ $3B
_W         .equ $3C
_X         .equ $3D
_Y         .equ $3E
_Z         .equ $3F
_RND       .equ $40
_INKEYS    .equ $41
_PI        .equ $42

; $43 - $6F unused

_UP        .equ $70
_DOWN      .equ $71
_LEFT      .equ $72
_RIGHT     .equ $73
_GRAPHICS  .equ $74
_EDIT      .equ $75
_NEWLINE   .equ $76
_EOL .equ _NEWLINE
_RUBOUT    .equ $77
_K_L_MODE  .equ $78
_FUNCTION  .equ $79

; $7A to $7E unused

_CURSOR    .equ $7F

; Every character after this is an inverse
; of the previous definition with the high bit
; set.
; This includes the graphics, so a solid block is
; _SPACE | $80, and _GR_0110 | $80 is equivalent to
; _GR_1001. Clive and his team were quite clever.
