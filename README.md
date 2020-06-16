# ASM playground
Just a little place for me to practice writing some x86, x86_64, ARM, and other assembly languages
The goal is to get a little more familiar with it so that reversing might be easier.
Also the exercise of using my brain when not in school :)

Also note that this will be using the

`opcode dest, src`

syntax unless stated otherwise (ie AT&T, GNU AS or other)

For 64 bit x86_64

`nasm -f elf64 <name>.asm && ld <name>.o && ./a.out && rm -f a.out <name>.o`

For 32 bit x86

`nasm -f elf <name>.asm && ld -m elf_i386 <name>.o && ./a.out && rm -f a.out <name>.o`

# Note for ARM
Since I am on x86_64 (shown when running `uname -m`), ARM will not work, so instead of using vagrant or VirtualBox, I'd rather have a lightweight solution, so I am using docker. Following this

- https://github.com/tonyOreglia/argument-counter/wiki/Using-Docker-to-Compile,-Link,-Run-and-Debug-Assembly-Language-Code
- # STILL WORKING ON GETTING IT TO RUN WITH USER INPUT
- currently, it runs but cannot take user input, so I will be experimenting more later

# following these for x86: 
- http://asm.sourceforge.net/intro/Assembly-Intro.html
- https://asmtutor.com/
- https://www.youtube.com/watch?v=rxsBghsrvpI&list=PLKK11Ligqitg9MOX3-0tFT1Rmh3uJp7kA
- https://stackoverflow.com/tags/x86/info (lots of links here!)
- https://cs.lmu.edu/~ray/notes/nasmtutorial/
- https://namesdir.com/mirrors/nongnu/pgubook/ProgrammingGroundUp-0-9.pdf

# following these for ARM:
- https://azeria-labs.com/writing-arm-assembly-part-1/
- https://www.cs.uaf.edu/courses/cs301/2014-fall/notes/arm-asm/
- http://apt.cs.manchester.ac.uk/ftp/pub/apt/peve/PEVE05/Slides/02_ARMassembly.pdf
- https://developer.arm.com/docs/dui0473/k/writing-arm-assembly-language
- https://developer.arm.com/common-tasks/writing-arm-assembly-code/single-page
- https://github.com/tonyOreglia/argument-counter/wiki/Using-Docker-to-Compile,-Link,-Run-and-Debug-Assembly-Language-Code


