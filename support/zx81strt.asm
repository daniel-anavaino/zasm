;;
;; LINE0.ASM
;; The REM statement that the main code will be embedded in.
;;                10                  REM
#include "support/rom.asm"
#include "support/tokens.asm"
#include "support/charcode.asm"
#include "support/keycode.asm"
#include "support/sysvars.asm"

;; 10 REM 
;;
line0	LINE_NUMBER(10)
		LINE_LENGTH(line0, line0end) ; length of line 
		.byte _REM

