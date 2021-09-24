;; ZASMVARS.ASM
; Variable defintions for ZASM

keystate .byte 0
cursortimer .word 0

status_line_format
status_line_mode    ; Inverse N,I or regular :
            .byte _SPACE

            .byte _SPACE

            .byte _L,_O,_C,_SPACE
status_line_location
            .byte _SPACE,_SPACE   ; 2 bytes max for line (1-23)
            .byte _SPACE          ; 1 byte for command
            .byte _SPACE,_SPACE   ; 2 bytes max for column (1-36)

            .byte $ff             ; end of string
