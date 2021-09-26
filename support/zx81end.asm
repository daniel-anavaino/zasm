;;
;; LINE1.ASM
;; The end of REM statement and the USR command to execute
;; the code embedded in the rem statement
	.byte	_EOL	; ends line0 (the REM statement)
line0end

;; 20 RAND USR(16514)
line1	LINE_NUMBER(20)
		LINE_LENGTH(line1, line1end)
		.byte _RAND,_USR,_LPAREN,_1,_6,_5,_1,_4,126,143,1,4,0,0,_RPAREN,_EOL
line1end

display
	.byte _EOL	; end of program
	.fill 32,_SPACE
	.byte _EOL
	.fill 32,_SPACE
	.byte _EOL
	.fill 32,_SPACE
	.byte _EOL
	.fill 32,_SPACE
	.byte _EOL
	.fill 32,_SPACE
	.byte _EOL
	.fill 32,_SPACE
	.byte _EOL
	.fill 32,_SPACE
	.byte _EOL
	.fill 32,_SPACE
	.byte _EOL
	.fill 32,_SPACE
	.byte _EOL
	.fill 32,_SPACE
	.byte _EOL
	.fill 32,_SPACE
	.byte _EOL
	.fill 32,_SPACE
	.byte _EOL
	.fill 32,_SPACE
	.byte _EOL
	.fill 32,_SPACE
	.byte _EOL
	.fill 32,_SPACE
	.byte _EOL
	.fill 32,_SPACE
	.byte _EOL
	.fill 32,_SPACE
	.byte _EOL
	.fill 32,_SPACE
	.byte _EOL
	.fill 32,_SPACE
	.byte _EOL
	.fill 32,_SPACE
	.byte _EOL
	.fill 32,_SPACE
	.byte _EOL
	.fill 32,_SPACE
	.byte _EOL
	.fill 32,_SPACE
	.byte _EOL
bottom_line
	.fill 32,_SPACE
	.byte _EOL
variables	.byte $80
basic_end
	.end