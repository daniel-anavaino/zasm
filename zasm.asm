;;
;; ZASM.ASM
;;   Interactive assembler and debugger for ZX81

;; Passing conventions:
;
;	SETS/PRINTS/similar
;		A	byte input 1	preserved
;		B	byte input 2	preserved
;		BC	word input 1	preserved
;		D	byte output
;		DE	word output
;		HL	pointer input	points to next address upon return if relevant
;		
;	GETS/FUNCTIONS/similar
;		A	byte input 1	not preserved
;		B	byte input 2	not preserved
;		BC	word input 1	not preserved
;		A	byte output
;		BC	word output
;		HL	pointer input	points to next address upon return if relevant
;		
;; While it will be more memory efficient to hijack parts of the ROMs editing
;; and listing routines, to start with we'll just write it from scratch.

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
;;	 B - BREAK
;;   S - SAVE
;;   enter - STEP
;;   J - LOAD
;;   shift-1 exit exmode

#define AUTORUN 0
#include "support/zx81strt.asm"

#include "zasmmacs.asm"
#include "zasmequs.asm"

		CALL	RESET_TIMER
		; set print position to display file + 1
;		LD		HL,(D_FILE)	; get current start of display file
;		INC		HL
;		LD		(DF_CC),HL
		LD		A,_EOL
		CALL	PRINT
		LD		A,navmode
		CALL	SET_MODE
		LD		A,$FF      ; make the first keystroke ff
		                   ; we do this because GETKEY is blocking
						   ; and we want the first entry into the 
						   ; loop to setup the status line
MAIN_LOOP
		LD		B,A		; save A because GET_MODE is destructive
		CALL	GET_MODE
		LD		HL,status_line_mode  ; set HL so we can update the mode in each piece below
		CP		navmode
		JR		NZ,NOTNAV
		LD		(HL),_N | $80
		LD		A,B
		CALL	NAVPROC
		JR		MAIN_UPDATE
NOTNAV	CP		insmode
		JR		NZ,NOTINS
		LD		(HL),_I | $80
		LD		A,B
		CALL	INSPROC
		JR		MAIN_UPDATE
NOTINS	CP		exmode
		JR		NZ,MAIN_LOOP
		LD		(HL),_COLON
		LD		A,B
		CALL	EXPROC
MAIN_UPDATE
		CALL 	STATUS_LINE_UPDATE
		CALL 	GETKEY  ; GETKEY handles the cursor blinking since it's blocking
		JR		MAIN_LOOP

#include "status.asm"
#include "getkey.asm"
#include "navproc.asm"
#include "insproc.asm"
#include "exproc.asm"
#include "zasmgnrl.asm"
#include "zasmprnt.asm"
#include "zasmvars.asm"

#include "support/zx81end.asm"

