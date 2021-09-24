;; status.asm

STATUS_LINE_UPDATE
		CALL	STATUS_MODE_UPDATE
        CALL    STATUS_POS_UPDATE
        LD  HL,bottom_line
        LD  BC,status_line_format
STATUS_LINE_UPDATE_LOOP
        LD  A,(BC)
        CP  $ff
        JR  Z,STATUS_LINE_UPDATE_DONE
        LD  (HL),A
        INC HL
        INC BC
        JR  STATUS_LINE_UPDATE_LOOP
STATUS_LINE_UPDATE_DONE
        RET

STATUS_MODE_UPDATE
		GET_MODE
		LD		HL,status_line_mode  ; set HL so we can update the mode in each piece below
		CP		navmode
		JR		NZ,STATUS_MODE_UPDATE_NOTNAV
		LD		(HL),_N | $80
        RET
STATUS_MODE_UPDATE_NOTNAV
        CP		insmode
		JR		NZ,STATUS_MODE_UPDATE_NOTINS
		LD		(HL),_I | $80
		RET
STATUS_MODE_UPDATE_NOTINS	
        CP		exmode
		RET		NZ          ; this really shouldn't happen
		LD		(HL),_COLON
		RET

STATUS_POS_UPDATE
        LD      HL,status_line_location
        LD      A,(S_POSN)
        LD      
        RET