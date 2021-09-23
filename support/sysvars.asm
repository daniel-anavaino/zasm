;;
;; SYSVARS.ASM
;;   Defines the system variables 

;; Start of saved variables
	.org	16393
VERSN		.byte 0
E_PPC		LINE_NUMBER(10)
D_FILE		.word display
DF_CC		.word display+1
VARS		.word variables
DEST		.word 0
E_LINE		.word variables+1
CH_ADD		.word variables+5
X_PTR		.word 0
STKBOT		.word variables+6
STKEND		.word variables+6
BERG		.byte 0
MEM			.word MEMBOT
			.byte 0
DF_SZ		.byte 2
S_TOP		.word 2
LAST_K		.word $fdbf
DEBOUN		.byte 15
MARGIN		.byte 55
NXTLIN		.word AUTORUN
OLDPPC		.word 0
FLGX		.byte 0
STRLEN		.word 0
T_ADDR		.word $0c8d
SEED		.word 0
FRAMES		.word $f5a3
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

