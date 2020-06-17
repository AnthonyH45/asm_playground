    %include 'functions32.asm'
    section .text
    global _start

_start:
    mov eax, msg1
    call sprint

    mov edx, 2
    mov ecx, sinput
    mov ebx, 0
    mov eax, 3
    int 0x80

    call valid_input

    mov eax, msg2
    call sprint

    mov eax, sinput
    call sprint
    
    jmp end

valid_input:
    push ecx
    push eax

    xor eax, eax
    xor ecx, ecx

    check_two_digits:
        mov al, [sinput+ecx]

        sub al, 0x2F
        cmp al, 0x0
        jle no_num

        mov al, [sinput+ecx]
        sub al, 0x3A
        cmp al, 0x0
        jge no_num

        inc ecx
        cmp ecx, 0x2
        je valid
        jmp check_two_digits
   
    valid:
    pop eax
    pop ecx
    ret

no_num:
    mov eax, msg_err
    call sprint
    jmp end

end:
    call quit

    section .data
msg1    db 'Please enter a two digit number (0x) if single digit: ',0x0
msg_err db 'You did not enter two digits, please try again',0xa
msg2    db 'You entered ',0x0
sinput  db 1

;    section .bss
;sinput: RESB 255
