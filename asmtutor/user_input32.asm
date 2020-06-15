; https://asmtutor.com/#lesson9
; this takes in a reads in the name of 
; the user and prints the name
; nasm -f elf user_input32.asm && ld -m elf_i386 user_input32.o && ./a.out && rm -f a.out user_input32.o 

    %include 'functions32.asm'

    section .text
    global _start

_start:
    mov eax, msg1           ; put msg1 into eax
                            ; eax is our param to sprint
    call sprint             ; print msg1 

    mov edx, 255            ; edx = 255
    mov ecx, sinput         ; ecx* -> 255 bytes of memory
    mov ebx, 0              ; ebx = 0 (we want to write to stdin)
    mov eax, 3              ; eax = 3 (3 is sys_read)
    int 0x80                ; interrupt with sys_read

    mov eax, msg2           ; put mgs2 into eax
    call sprint             ; print msg2

    mov eax, sinput         ; move user input string to eax
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
