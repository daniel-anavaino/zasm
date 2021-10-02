;; z80emu.asm
; Z80 Emulator
; Single step and run emulates a Z80 processor.
; Since TASM isn't a linking assembler (i.e., everything
; is inlined), the editor and diassembler are also included here
; since they both rely on z80opcodes.asm

#include "z80opcodes.asm"
#include "z80dis.asm"
#include "z80edit.asm"

;**********************************
; 
;   
;**********************************
; Inputs:
;   None
;
; Outputs:
;   None
;
; Side effects:
;   None
;**********************************
