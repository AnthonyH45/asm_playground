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
    push rbx
    push rcx
    push rdx

    xor rax, rax
    xor rbx, rbx
    xor rcx, rcx
    xor rdx, rdx

    add rbx, 0x09
    print_loop:
        add rax, rbx
        add rax, 0x30
        call sprint
        dec rbx
        cmp rbx, 0x0
        jne print_loop
    
    pop rdx
    pop rcx
    pop rbx
    pop rax
    ret

end:
    call quit

    section .data
msg1    db 'Counting down from 9',0x0
newline db '',0xa,0x0
