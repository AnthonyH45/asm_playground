; nasm -f elf64 hello64.asm && ld hello64.o && ./a.out
    global _start               ; like main(), needed for linker (ld)
    
    section .text
_start:                     ; begin procedure, tells teh linker this is the entry point
    mov rdx, len            ; msg length is moved into the edx register
    mov rcx, msg            ; move the message into ecx to write
    mov rbx, 1              ; file descriptor (stdout), we are using sys_write and need to tell it to write to stdout
    mov rax, 4              ; sys_write call number
    int 0x80                ; call the kernel to write for us

    mov rax, 1              ; now we call exit, call number is 1
    int 0x80                ; once again, we then call the kernel to handle the sys call of exit

    section .data
msg db 'Hello, World!',0xa  ; "Hello, World!\n" is our msg to print
len equ $ - msg             ; length of msg