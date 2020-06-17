    %include 'functions32.asm'
    section .text
    global _start

_start:
    mov eax, msg1
    call sprint

    mov edx, 255
    mov ecx, sinput
    mov ebx, 0
    mov eax, 3
    int 0x80

    mov eax, msg2
    call sprint

    mov eax, sinput
    call sprint

valid_input:
    

;loop:
    ;xor ecx, ecx



    call quit

    section .data
msg1 db 'Please enter a two digit number: ',0x0
msg2 db 'You entered ',0x0

    section .bss
sinput: RESB 1
