    %include 'functions64.asm'
    section .text
    global _start

_start:
    ;mov rax, msg1                   ; rax <- msg1
    ;call sprint                     ; print msg1

    mov rdx, 2                      ; rdx <- 2
    mov rcx, sinput                 ; rcx <- sinput
    mov rbx, 0                      ; rbx <- 0
    mov rax, 3                      ; rax <- 3
    int 0x80                        ; interupt 80, ie go to kernel and sys call to print
                                    ; and get user input of upto 2 (value in rdx)

    call valid_input                ; check if both chars entered are valid numbers

    ;mov rax, msg2                   ; rax <- msg2
    ;call sprint                     ; print msg2

    mov rax, sinput                 ; rax <- user inputted 2 digits
    call sprint                     ; print it

    ;mov rax, newline                ; rax <- 0xA (newline var)
    ;call sprint                     ; print newline

    call count_to                   ; print the numbers from 1 to user_input

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

count_to:
    push rax                        ; save rax onto the stack
    push rbx                        ; save rbx onto the stack
    push rcx                        ; save rcx onto the stack
    push rdx                        ; save rdx onto the stack

    xor rax, rax                    ; rax = 0
    xor rbx, rbx                    ; rbx = 0
    xor rcx, rcx                    ; rcx = 0
    xor rdx, rdx                    ; rdx = 0

    mov al, [sinput+rcx]            ; al = *(sinput+rcx), grab first digit
    sub al, 0x30                    ; al = al - 0x30 (get the numerical val of ascii char)
    mov bl, 0xA                     ; bl = 0xA

    first_digit:
        add bl, 0xA                 ; bl = bl + 0xA
        dec al                      ; al -= 1
        cmp al, 0x1                 ; if al == 1
        jne first_digit             ; jump if not equal, to first_digit

    inc rcx
    mov al, [sinput+rcx]            ; al = *(sinput+rcx), grab second digit
    sub al, 0x30                    ; get numerical val of ascii char
    add dl, al                      ; dl = dl + al
    add dl, bl                      ; dl = dl + bl
                                    ; al + bl stored in dl
    
    xor rax, rax                    ; rax = 0
    xor rbx, rbx                    ; rbx = 0
    xor rcx, rcx                    ; rcx = 0
    
    print_loop:
        inc rcx                     ; rcx += 1
        mov rax, rcx                ; rax = rcx

        cmp rax, 0xA                ; if rax == 0xA
        jge two_digit_print         ; if rax >= 0xA, its two digits and we need to print it

        ; we get here if rax is NOT two digits
        add rax, 0x30               ; rax = rax + 0x30, ie make it ascii
        push rax                    ; save rax onto the stack
        mov rax, rsp                 ; rax = rsp, (move stack pointer into rax)
        call sprintLF               ; sprint + newline

        pop rax                     ; restore val of rax
        cmp rax, rdx                ; if rax == rdx (total to count to)
        jne print_loop             ; jump if not equal, to print_loop
    
    pop rdx                         ; restore rdx from stack
    pop rcx                         ; restore rcx from stack
    pop rbx                         ; restore rbx from stack
    pop rax                         ; restore rax from stack
    ret                             ; return

two_digit_print:
    push rax                        ; save rax onto stack
    push rbx                        ; save rbx onto stack
    push rcx                        ; save rcx onto stack
    push rdx                        ; save rdx onto stack

    xor rcx, rcx                    ; rcx = 0

    ten_x:
        inc rcx                     ; rcx += 1
        sub rax, 0xA                ; rax = rax - 0xA
        cmp rax, 0x0                ; if rax == 0x0
        jg ten_x                    ; jump if greater, to ten_x

    add rcx, 0x30                   ; turn rcx into printable ascii char
    mov rdx, 1                      ; forgot why
    mov rbx, 1                      ; forgot why
    mov rax, 4                      ; forgot why 
    int 0x80                        ; interupt 0x80, go to kernel for sys_call

    pop rdx                         ; restore rdx from stack
    pop rcx                         ; restore rcx from stack
    pop rbx                         ; restore rbx from stack
    pop rax                         ; restore rax from stack
    ret

end:
    call quit

    section .data
msg1    db  'Please enter a two digit number (0x) if single digit: ', 0x0
msg_err db  'You did not enter two digits, please try again',0xa,0x0
msg2    db 'Counting down from ',0x0
newline db '',0xa,0x0
sinput  db 1 ; db = define byte, we define 1 byte to hold a two digit number

