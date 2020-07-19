    section .text
    global _start

_start:                                             ; entry point
    mov rdx, len                                    ; rdx <- len(msg)
    mov rcx, msg1                                   ; rcx <- msg1
    mov rbx, 1                                      ; rbx <- 1
    mov rax, 4                                      ; rax <- 4, interupt to call
    int 0x80                                        ; int 80, trap to kernel

    mov rdx, 1                                      ; set the length to print 1
    mov rcx, newline                                ; load the newline into rcx
    mov rbx, 1                                      ; set file descriptor to 1, aka stdout
    mov rax, 4                                      ; set rax = 4, aka write to rbx, aka write to stdout
    int 0x80                                        ; interupt to kernel and let it write rcx, with len rdx, to rbx, stdout
    
    call count_down                                 ; call fcn count_down
    jmp quit                                        ; when we return, goto quit


count_down:
    push rax                                        ; save rax to the stack
    push rbx                                        ; save rbx to the stack
    push rcx                                        ; save rcx to the stack
    push rdx                                        ; save rdx to the stack

    xor rax, rax                                    ; set rax = 0
    xor rbx, rbx                                    ; set rbx = 0
    xor rcx, rcx                                    ; set rcx = 0
    xor rdx, rdx                                    ; set rdx = 0

    add rcx, 0x09                                   ; set rcx = 9
    print_loop:
        push rcx                                    ; save rcx to the stack
        ones_print:
            push rcx                                ; save rcx to the stack
            mov rdx, 1                              ; load the length of the msg to print, it is one char
            mov rcx, one                            ; move '1' into rcx
            mov rbx, 1                              ; set fd to 1, aka stdout
            mov rax, 4                              ; 4 = write syscall
            int 0x80                                ; interupt to kernel
            pop rcx                                 ; pop off stack into rcx
            
            dec rcx                                 ; decrement rcx
            cmp rcx, 0x0                            ; check if its 0, set flags
            jle done_ones                           ; if rcx <= 0, jump to done_ones
            mov rdx, 1                              ; set the length to write to 1
            mov rcx, plus                           ; load the plus sign into rcx to print
            mov rbx, 1                              ; write to stdout
            mov rax, 4                              ; set syscall to write
            int 0x80                                ; interupt to kernel
            pop rcx                                 ; pop off stack into rcx
            jmp ones_print                          ; jmp back to ones_print

        done_ones:  
            pop rcx                                 ; pop off stack into rcx

        ;add rcx, 0x30
        ;mov rdx, 1
        ;mov rbx, 1
        ;mov rax, 4
        ;int 0x80

        mov rdx, 1                                  ; length to print 1
        mov rcx, newline                            ; newline to print rcx
        mov rbx, 1                                  ; rbx is stdout
        mov rax, 4                                  ; rax is syscall, write=4
        int 0x80                                    ; interupt to kernel

        pop rcx                                     ; pop stack off into rcx
        dec rcx                                     ; decrement rcx
        cmp rcx, 0x0                                ; check if rcx is 0
        jge print_loop                              ; if its greater then jump to print loop

    pop rdx                                         ; pop off stack into rdx
    pop rcx                                         ; pop off stack into rcx
    pop rbx                                         ; pop off stack into rbx
    pop rax                                         ; pop off stack into rax
    ret                                             ; return from call 

quit:
    mov rax, 1                                      
    int 0x80

    section .data
msg1    db 'Counting down from 9',0x0
len     equ $ - msg1
newline db '',0xa,0x0
one     db '1',0x0
plus    db '+',0x0
