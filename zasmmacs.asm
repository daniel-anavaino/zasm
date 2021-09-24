;; ZASMMACS.ASM
;  Macros for ZASM

#define GET_MODE            LD HL,MODE\ LD A,(HL)
#define SET_MODE(m)	        LD HL,MODE\ LD A,m\ LD (HL),A
#define RESET_TIMER         LD HL,blinktime\ LD (cursortimer),HL
