# x86_64 ASM playground
Just a little place for me to practice writing some x86 assembly.
The goal is to get a little more familiar with it so that reversing might be easier.
Also the exercise of using my brain when not in school :)

For 64 bit

`nasm -f elf64 <name>.asm && ld <name>.o && ./a.out`

For 32 bit

`nasm -f elf <name>.asm && ld -m elf_i386 -s <name>.o && ./a.out`

# following these: 
- http://asm.sourceforge.net/intro/Assembly-Intro.html
- https://www.youtube.com/watch?v=rxsBghsrvpI&list=PLKK11Ligqitg9MOX3-0tFT1Rmh3uJp7kA
- https://stackoverflow.com/tags/x86/info (lots of links here!)
