;; INSPROC.ASM
;   Handles insertion mode

;; key pressed is in A
INSPROC
		CP	_EDIT
		JR	Z,INSPROC_ENABLE_NAV
		CALL	PRINT
		RET
INSPROC_ENABLE_NAV
		SET_MODE(navmode)
		RET