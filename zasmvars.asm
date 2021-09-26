;; ZASMVARS.ASM
; Variable defintions for ZASM

program_line    .word program_start
program_start     .word   basic_end
keystate    .byte 0
cursortimer .word 0
cursor_posn .word   0
status_line_format
status_line_mode    ; Inverse N,I or regular :
            .byte _SPACE

            .byte _SPACE

            .byte _L,_O,_C,_SPACE
status_line_location
            .byte _SPACE,_SPACE   ; 2 bytes max for line (1-23)
            .byte _SPACE          ; 1 byte for command
            .byte _SPACE,_SPACE   ; 2 bytes max for column (1-36)

            .byte _SPACE,_A,_D,_D,_R,_SPACE
status_line_address
            .fill 4,_SPACE

            .byte $ff             ; end of string
