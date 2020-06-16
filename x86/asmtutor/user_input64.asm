; https://asmtutor.com/#lesson9
; this takes in a reads in the name of 
; the user and prints the name
; nasm -f elf64 user_input64.asm && ld user_input64.o && ./a.out && rm -f a.out user_input64.o

    %include 'functions64.asm'

    section .text
    global _start

_start:
    mov rax, msg1           ; put msg1 into eax
                            ; eax is our param to sprint
    call sprint             ; print msg1 

    mov rdx, 255            ; edx = 255
    mov rcx, sinput         ; ecx* -> 255 bytes of memory
    mov rbx, 0              ; ebx = 0 (we want to write to stdin)
    mov rax, 3              ; eax = 3 (3 is sys_read)
    int 0x80                ; interrupt with sys_read

    mov rax, msg2           ; put mgs2 into eax
    call sprint             ; print msg2

    mov rax, sinput         ; move user input string to eax
    call sprint             ; print user input string

    call quit               ; call quit
   
    section .data
msg1    db  'Please enter your name: ',0xa,0x0
msg2    db  'Hello ',0x0,
; db = define byte (8bits)
; dw = define word (usually 2 bytes on x86 32 bit)
; dd = define double word (usually 4 bytes on x86 32 bit)

    section .bss
sinput: RESB 255    ; reserve a 255 byte space in memory for user sting
; RESB = reserve for 1 byte
; RESW = reserve for 1 word
; RESD = reserve for 1 double word
; RESQ = reserve for 1 double precision float (quad word)
; REST = reserve for 1 extended precision float
