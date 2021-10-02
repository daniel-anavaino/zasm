
# ZASM
Z80 Interpeter/Assembler for the Sinclair ZX81 + 16K RAM Pack

ZX81 Emulator Tape File: [zasm.p](zasm.p)

```
This repo is under a lot of change right now by me. If you have changes you'd like to make,
please create an issue and then coordinate with me rather than making changes and requesting
a pull - we will all be a lot happier.
```
The goal for this is a Z80 editor/emulator that feels like the ZX81 BASIC editor with single step
debugging, and the ability to save both the source as well as save a separate loadable program
that implements the source.

## Nota Bene
This is a work in progress. I only published this because my friend JCQ wanted to see
what I was up to. Current development is under Windows 10 via the Parallels environment under
MacOS with the EightyOne emulator as target.

The source is compatible with the Telemark Assembler (TASM). It's shareware but seems to be
abandoned at this point. I've included a copy in the tools/ directory that I grabbed from
Ye Olde Géomann Searu (The Wayback Machine). A manual, which may or may not match the version
of the .exe I downloaded, is available [here](http://www.cpcalive.com/docs/TASMMAN.HTM). To date,
I haven't found the manual to be inaccurate.

## Building
Execute the `build.bat` DOS batch file from a command (CMD) shell. It's trival - just one line
that calls TASM with appropriate parameters. The output is zasm.p which is a tape file that is
loadable using the [EightyOne ZX81 emulator](https://docs.libretro.com/library/eightyone/).
At this point (2021-10-1) it hasn't been tested on actual hardware.

## Parameter Passing
This is still a bit in flux. The initial idea (although most certianly not religiously followed at this point) is documented
in [zasm.asm](zasm.asm) in the header:

### Passing conventions:

#### SETS/PRINTS/similar
* A	 - byte input 1	 (preserved)
* B	 - byte input 2	 (preserved)
* AF -	word input 1 (preserved)
* BC -	word input 2 (preserved)
* D	 - byte output
* DE - word output
* HL - pointer input	points to next address upon return if relevant

#### GETS/FUNCTIONS/similar
* A	 - byte input 1 (not preserved)
* B	 - byte input 2 (not preserved)
* BC - word input 1 (not preserved)
* A	 - byte output
* BC - word output
* HL - pointer input	points to next address upon return if relevant

Also, don't be shy with PUSH and POP to preserve registers. Just note that Z80 only allows
16-bit stack PUSH/POPs, so:
```
    PUSH AF   ; valid
    PUSH A    ; invalid
```

## Coding Standards
**Imporant! Spaces only. Indents (tabs) are 4 spaces.**

Each subroutine should have the following header:
  ```
  ;**********************************
  ; <routine name>
  ;   <description>
  ;**********************************
  ; Inputs:
  ;   <register list> or None
  ;
  ; Outputs:
  ;   <register list> or None
  ;
  ; Side effects:
  ;   <global memory changed, registers changed> or None
  ;**********************************
  ```
  
As emphasied above: **No tabs! Just spaces.** That said, the "tab stops" should be 4 characters.
Always indent before any unlabled opcode (required by TASM as well as
gentlemanly behavior). 

Opcodes should have enough space after them that the opcode parameters
line up. To date, that seems to be two (2) "tabs" after an LD instruction.

## Adding Modules
TASM isn't a linking assembler, so it ends up being a set of includes
starting with zasm.asm as the parent. Imagine a EE writing software -
that's what this looks like. So when you add a file, you need to include
it somewhere in the chain - either in zasm.asm or in something included
in zasm.asm. Just be sure that it doesn't get doubly included (see z80emu.asm
for an example of an overarching include).

## Naming Conventions
### File Names
You can see by looking at the file names that it's still pretty *ad hoc*. I've tried
to organize the names by function, but it's horribly inconsistent at this point (screen.asm is
a fine example as well as the \*proc.asm files). Happy to have issues and pull requests along those lines. That said,
I've tried to make the things that are very ZASM specific be prefixed by "zasm" and the
things I might try to reuse be prefixed by something else descriptive (the "z80" files
being an example). The files that are reusable when writing loadable ZX81 assembly code are in
the [support/](support/) directory. Note that I've also tried to follow 8.3 file naming conventions, although
I've failed along those lines with no issues from TASM (e.g. [z80opcodes.asm](z80opcodes.asm).

### Subroutine and Label Names

**Note: TASM label names are limited to 32 characters**

1. Label names should be on a separate line.

2. Subroutine names are intended to be descriptive. Don't make them
too long if you need branch target labels.

3. Branch target labels should all be preceded by the subroutine name and
an underscore. Make them descriptive.

For example:

  ```
   ;**********************************
   ; ISALPHA
   ;   Equivalent to the C isalpha
   ;   macro/function.
   ;**********************************
   ; Inputs:
   ;   A - character to check
   ;
   ; Outputs:
   ;   A - false/true
   ;       0 - is not alphabetic character
   ;       1 - is alphabetic character
   ;
   ; Side effects:
   ;   F - flags changed
   ;**********************************
   ; ISALPHA
   ISALPHA
      AND   $7F   ; strip the 'inverse' bit
      CP    _A
      JR    C,ISALPHA_NOT_ALPHA ; < 'A'
      CP    _Z+1
      JR    NC,ISALPHA_NOT_ALPHA ; > 'Z'
      LD    A,1
      JR    ISALPHA_IS_ALPHA
   ISALPHA_NOT_ALPHA
      LD    A,0
   ISALPHA_IS_ALPHA
      RET
```
