;;
;; TOKENS.ASM
;;    ZX81 BASIC tokens

#define LINE_NUMBER(n) .msfirst\ .word n\ .lsfirst
#define LINE_LENGTH(start,end) .word end - start - 4
_PRINT 	.equ $F5
_RAND	.equ $F9
_REM	.equ $EA
_USR	.equ $D4
