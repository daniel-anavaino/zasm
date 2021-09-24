;; getkey.asm
; Reads a key and returns it in A

GETKEY
        ;; check for expired timer
        ; load timer into HL
		LD      HL,cursortimer
        ; decrement timer
        DEC     (HL)
        JR      Z,GETKEY_TIMER_EXPIRED
        ; if timer isn't expired, set A = 0
        LD      A,0
        JR      GETKEY_UPDATE_TIMER
GETKEY_TIMER_EXPIRED
        ; if timer expired, set A = 1
        LD      A,1
GETKEY_UPDATE_TIMER
        ; check for expired timer
        CP      1
		JR		NZ,NO_BLINK
        ; invert character to current display position
        LD      HL,(DF_CC)
		LD		A,(HL) ; currently hardcoded to start of display
		XOR		$80
		LD		(HL),A
		RESET_TIMER
NO_BLINK
        CALL	KEYBOARD ; get keypress - 2 bytes
		LD		B,H
		LD		C,L
		LD		D,C
		INC		D		; if L == $ff, no key pressed
		JR		Z,KEYUP
		JP		KEYDOWN
KEYUP	LD		HL,keystate
		LD		A,nokeypressed
		LD		(HL),A
		JP		GETKEY
KEYDOWN	CALL	DECODE	; decode to character
		LD		A,(HL)
		LD		B,A
		LD		HL,keystate
		LD		A,(HL)
		CP		keypressed	; if key was already down, don't process it
		JR		Z,GETKEY
		LD		A,keypressed
		LD		(HL),A
        LD      A,B
        RET