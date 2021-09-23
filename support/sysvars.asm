;;
;; SYSVARS.ASM
;;   Defines the system variables 

;; Start of saved variables
	.org	16393
VERSN		.byte 0
E_PPC		.byte 10,0
D_FILE		.word display-1
DF_CC		.word display
VARS		.word variables
DEST		.byte 0,0
E_LINE		.word variables+1
CH_ADD		.word variables+9
X_PTR		.word 0
STKBOT		.word variables+10
STKEND		.word variables+10
BERG		.byte 0
MEM			.word MEMBOT
			.byte 0
DF_SZ		.byte 2
S_TOP		.word 0
LAST_K		.word $ffff
			.byte $ff
MARGIN		.byte 55
NXTLIN		.word AUTORUN
OLDPPC		.word 0
FLGX		.byte 0
STRLEN		.word 0
T_ADDR		.word $0c8d
SEED		.word 0
FRAMES		.word $f617
COORDS		.byte 0
			.byte 0
PR_CC		.byte $bc
S_POSN		.byte $1
			.byte $1
CDFLAG		.byte $40
PRBUFF		.fill 32,0
			.byte _EOL
MEMBOT		.fill 30,0
			.byte 0,0

