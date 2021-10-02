;; z80emu.asm
; Z80 Emulator
; Single step and run emulates a Z80 processor.
; Since TASM isn't a linking assembler (i.e., everything
; is inlined), the editor and diassembler are also included here
; since they both rely on z80opcodes.asm

#include "z80opcodes.asm"
#include "z80dis.asm"
#include "z80edit.asm"

; CPU registers
_Z80_EMU_AF     .word 0
_Z80_EMU_BC     .word 0
_Z80_EMU_DE     .word 0
_Z80_EMU_HL     .word 0
_Z80_EMU_SP     .word 0
_Z80_EMU_PC     .word 0
_Z80_EMU_IX     .word 0
_Z80_EMU_IY     .word 0
_Z80_EMU_I      .byte 0     ; interrupt vector base register
_Z80_EMU_R      .byte 0     ; DRAM refresh counter
_Z80_EMU_AFS    .word 0     ; shadow registers - denoted AF'
_Z80_EMU_BCS    .word 0
_Z80_EMU_DES    .word 0
_Z80_EMU_HLS    .word 0
_Z80_EMU_STAT   .byte 0     ; status register
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
