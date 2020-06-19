    %include 'functions64.asm'
    section .text
    global _start

_start:
    mov rax, msg1                   ; rax <- msg1
    call sprint                     ; print msg1

    mov rdx, 2                      ; rdx <- 2
    mov rcx, sinput                 ; rcx <- sinput
    mov rbx, 0                      ; rbx <- 0
    mov rax, 3                      ; rax <- 3
    int 0x80                        ; interupt 80, ie go to kernel and sys call to print
                                    ; and get user input of upto 2 (value in rdx)

    call valid_input                ; check if both chars entered are valid numbers

    mov rax, msg2                   ; rax <- msg2
    call sprint                     ; print msg2

    mov rax, sinput                 ; rax <- user inputted 2 digits
    call sprint                     ; print it

    mov rax, newline                ; rax <- 0xA (newline var)
    call sprint                     ; print newline

    ;call count_to                   ; print the numbers from 1 to user_input

    jmp end                         ; after returning from count_to, we jmp to end

valid_input:
    push rcx                        ; save rcx
    push rax                        ; save rax

    xor rax, rax                    ; rax = 0
    xor rcx, rcx                    ; rcx = 0

    check_two_digits:
        mov al, [sinput+rcx]        ; al <- *(sinput+rcx)

        sub al, 0x2F                ; al = al - ascii value of one less than ascii '0'
        cmp al, 0x0                 ; if its 0 then its less than ascii 0
        jl no_num                   ; jump if less than to no_num

        mov al, [sinput+rcx]        ; al <- *(sinput+rcx)
        sub al, 0x3A                ; al = al - ascii val of one more than '9'
        cmp al, 0x0                 ; if its 0 then its 9
        jg no_num                   ; jump if greater than to no_num

        inc rcx                     ; rcx += 1
        cmp rcx, 0x2                ; if rcx == 2
        je valid                    ; jump if ==
        jmp check_two_digits        ; otherwise, jmp back to check_two_digits
    
    valid:
        pop rax                     ; restore rax from stack
        pop rcx                     ; restore rcx from stack
        ret                         ; return from call

no_num:
    mov rax, msg_err
    call sprint
    jmp end


end:
    call quit

    section .data
msg1    db  'Please enter a two digit number (0x) if single digit: ', 0x0
msg_err db  'You did not enter two digits, please try again',0xa,0x0
msg2    db 'Counting down from ',0x0
newline db '',0xa,0x0
sinput  db 1 ; db = define byte, we define 1 byte to hold a two digit number

