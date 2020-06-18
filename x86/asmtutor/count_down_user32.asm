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

    mov eax, newline
    call sprint

    call count_to
    
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

count_to:
    push eax
    push ebx
    push ecx
    push edx

    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx

    mov al, [sinput+ecx]
    sub al, 0x30
    mov bl, 0xA
    
    first_digit:
        add bl, 0xa
        dec al
        cmp al, 0x1
        jne first_digit
    
    inc ecx
    mov al, [sinput+ecx]
    sub al, 0x30
    add dl, al
    add dl, bl

    xor ecx, ecx
    xor eax, eax
    xor ebx, ebx
    print_loop:
        inc ecx
        mov eax, ecx

        cmp eax, 0xA
        call two_digit_print

        add eax, 0x30
        push eax
        mov eax, esp
        call sprintLF

        pop eax
        cmp ecx, edx
        jne print_loop

    pop edx
    pop ecx
    pop ebx
    pop eax
    ret

two_digit_print:
    push eax
    push ebx
    push ecx
    push edx
    
    xor ecx, ecx
    ;xor ax, 0xF

    ten_x:
        inc ecx
        sub eax, 0xA
        cmp eax, 0x0
        jg ten_x

    add ecx, 0x30
    mov edx, 1
    mov ebx, 1
    mov eax, 4
    int 0x80

    pop edx
    pop ecx
    pop ebx
    pop eax
    ret

end:
    call quit

    section .data
msg1    db 'Please enter a two digit number (0x) if single digit: ',0x0
msg_err db 'You did not enter two digits, please try again',0xa
msg2    db 'Counting down from ',0x0
newline db '',0xa,0x0
sinput  db 1
