;;
;; ZASM.ASM
;;   Interactive assembler and debugger for ZX81

#define AUTORUN line1
#include "support/zx81strt.asm"

		LD		HL,line		;load HL with address of line
PLINE	LD		A,(HL)		;load A with a character at HL
		CP		$FF			;is this $FF
		JP		Z,END		;if so, then jump to end
		CALL	PRINT			;print character
		INC		HL			;increment HL to get to next character
		JP		PLINE		;jump to beginning of loop
END		RET					;exit 

line:		.byte  _H,_E,_L,_L,_O,_SPACE,_W,_O,_R,_L,_D,$76,$ff

#include "support/zx81end.asm"

