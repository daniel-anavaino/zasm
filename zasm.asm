;;
;; ZASM.ASM
;;   Interactive assembler and debugger for ZX81

;; While it will be more memory efficient to hijack parts of the ROMs editing
;; and listing routines, to start with we'll just right it from scratch.

;; Using vi commands for editing with a navigation, insert, and :run mode
;;
;; navmode:
;;  H/shift-5 LEFT
;;	J/shift-6 DOWN
;;  K/shift-7 UP
;;  L/shift-8 RIGHT
;;  I INSERT
;;  A APPEND
;;  $(SHIFT-U) EOL
;;  0 BOL
;;  DD DELETE LINE
;;  P  PUT
;;
;; insmode:
;;  SHIFT-1 exit insmode
;;
;; exmode:
;;   R - RUN
;;   S - SAVE
;;   enter - STEP
;;   J - LOAD
;;   shift-1 exit exmode

#define AUTORUN 0
#include "support/zx81strt.asm"

#define GET_MODE	LD HL,mode\ LD	A,(HL)
#define SET_MODE(m)	LD HL,mode\ LD A,m\ LD (HL),A

;; modes
navmode		 .equ 0
insmode 	 .equ 1
exmode		 .equ 2

nokeypressed .equ 0
keypressed 	 .equ 1


		LD		HL,D_FILE	; get current start of display file
		LD		C,(HL)
		INC		HL
		LD		B,(HL)
		LD		HL,DF_CC	; get address of print position
		LD		(HL),C		; set print position to start of display file
		INC		HL
		LD		(HL),B
		LD		A,_EOL
		CALL	PRINT
INLOOP	CALL	KEYBOARD ; get keypress - 2 bytes
		LD		B,H
		LD		C,L
		LD		D,C
		INC		D		; if L == $ff, no key pressed
		JR		Z,KEYUP
		JP		KEYDOWN
KEYUP	LD		HL,keystate
		LD		A,nokeypressed
		LD		(HL),A
		JP		INLOOP
KEYDOWN	CALL	DECODE	; decode to character
		LD		A,(HL)
		LD		B,A
		LD		HL,keystate
		LD		A,(HL)
		CP		keypressed	; if key was already down, don't process it
		JR		Z,INLOOP
		LD		A,keypressed
		LD		(HL),A
		GET_MODE
		CP		navmode
		JR		Z,NAVPROC
		CP		insmode
		JR		Z,INSPROC
		CP		exmode
		JR		Z,EXPROC
		JP		INLOOP

;; key pressed is in B
NAVPROC	
		LD	A,B
		CP	_I
		JR	Z,ENABLE_INSMODE
		JP	INLOOP

ENABLE_INSMODE
		SET_MODE(insmode)
		JP	INLOOP
		
INSPROC
		LD	A,B
		CP	_EDIT
		JR	Z,ENABLE_NAVMODE
		CALL	PRINT
		JP	INLOOP
ENABLE_NAVMODE
		SET_MODE(navmode)
		JP INLOOP
		
EXPROC
		JP	INLOOP
mode		 .byte navmode
keystate	 .byte 0
#include "support/zx81end.asm"

