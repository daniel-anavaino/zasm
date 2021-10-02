;; ZASMVARS.ASM
; Variable defintions for ZASM

program_line    .word basic_end
program_start   .word basic_end
program_end     .word basic_end
keystate        .byte 0
cursortimer     .word blinktime
cursor_posn     .word 0

status_line_format
status_line_mode    ; Inverse N,I or regular :
            .byte _SPACE

;             .byte _SPACE,_L,_O,_C,_SPACE
; status_line_location
;             .fill 5,_SPACE

            .byte _SPACE,_A,_D,_D,_R,_SPACE
status_line_address
            .fill 4,_SPACE

            .byte $ff             ; end of string
