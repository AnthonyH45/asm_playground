    %include 'functions64.asm'
    section .text
    global _start

_start:
    mov rax, msg1                           ; rax <- "Counting down from 10"
    call sprint                             ; print msg
    mov rax, newline
    call sprint
    call count_down
    jmp end

count_down:
    push rax
    push rcx

    xor rax, rax
    xor rcx, rcx

    add rcx, 0x09
    print_loop:
        mov rax, rcx
        add rax, 0x30
        push rax
        mov rax, rsp
        call sprintLF
        pop rax

        dec rcx
        cmp rcx, 0x0
        jne print_loop

    pop rcx
    pop rax
    ret

end:
    call quit

    section .data
msg1    db 'Counting down from 9',0x0
newline db '',0xa,0x0
