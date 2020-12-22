# Rizzo Island Game Code

## Synopsis
This is a git repository for all the QuakeC game code used in Rizzo Island. It contains 
modified Id Software and original code by Nahuel and David of Dreameater Games. The old code
used in earlier builds are in the "deprecated" folder. Since the move to NuQuake from Makaqu, the
codebase has been unified.

## Repository Structure

### Main Folder Descriptions

- cons  =   Contains the codebase for convention demo's. The code is usually a bit behind the "main"
            codebase
- depricated    =   Contains the old codebases for the win32 and Dreamcast game code. Not sure if it
                    still even builds
- main  =   Contains the latest in-use codebase for the game. Will be updated as new builds come out
- screenshots   =   Contains the codebase for the game builds meant for screenshots and promotional
                    material

## Building the Game Code
In order to build the code, you must have a QuakeC compiler. We prefer FTEQCC as our compiler.
Just put FTEQCC.exe inside "main/src/", run it, then compile it.

## Credits

### Id Software Quake Source:
John Carmack    - Id Software  
Michael Abrash  - Id Software  
John Cash       - Id Software  

### Dreameater Games Rizzo Source:
Nahuel A.   - Lead Programmer -   Dreameater Games  
David C.    - Lead Developer -   Dreameater Games  