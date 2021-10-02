# Developer Notes 
A running list of things that need to be addressed but don't qualify for issue status.

## Editing
* Uses the arrow keys and EDIT to move around and to enter/exit edit mode (respectively) but the comments haven't been updated to reflect that.
* Doesn't ignore "bad" keys.

## Test
At the point that unit testing needs to be added. Would be nice to have a scripted way of regressing these on the emulator.

## Current Work
* Opcode diassembler
* Z80 emulator

## TODO
* Rename the outliers like screen.asm, status.asm \*proc.asm. Holding off in part because some of these may end up being refactored as the editor progresses.
* Improve the build.bat file. I'd prefer to use make but it doesn't come stock with Git Bash and I don't want to add more dependencies. Windows is such a pathetic development environment.