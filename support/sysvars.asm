;;
;; SYSVARS.ASM
;;   Defines the system variables 

MODE .equ 16390

;; Start of saved variables
	.org	16393
VERSN		.byte 0
E_PPC		LINE_NUMBER(10)   ; current cursor line
D_FILE		.word display     ; start of display RAM
DF_CC		.word display+1   ; PRINT position
VARS		.word variables   ; start of BASIC variables
DEST		.word 0           ; assignment variable address
E_LINE		.word variables+1 ; line editing buffer
CH_ADD		.word variables+5 ; peek/poke stuff
X_PTR		.word 0           ; address of character for S marker
STKBOT		.word variables+6 ; calculator stack
STKEND		.word variables+6
BERG		.byte 0           ; B register for calculator
MEM			.word MEMBOT      ; calculator memory
			.byte 0           ; unused
DF_SZ		.byte 2           ; lines at bottom of screen 
S_TOP		LINE_NUMBER(20)   ; top line of program listings
LAST_K		.word $fdbf       ; last keypress
DEBOUN		.byte 15          ; keyboard debounce status
MARGIN		.byte 55          ; PAL (55)/NTSC(31) blank lines
NXTLIN		.word AUTORUN     ; address of program line to execute
OLDPPC		.word 0           ; CONT next line
FLGX		.byte 0           ; undocumented flags
STRLEN		.word 0           ; BASIC string assignment length
T_ADDR		.word $0c8d       ; syntax table
SEED		.word 0           ; RAND dest (used by RND)
FRAMES		.word $f5a3       ; display frame counter (also PAUSE)
COORDS		.byte 0           ; PLOT x,y positions
			.byte 0
PR_CC		.byte $bc         ; LSB of next LPRINT position
S_POSN		.byte $1          ; PRINT column, line
			.byte $1
CDFLAG		.byte $40         ; more undocumented flags
PRBUFF		.fill 32,0        ; print buffer
			.byte _EOL
MEMBOT		.fill 30,0        ; memory calculation buffer
			.byte 0,0         ; unused

