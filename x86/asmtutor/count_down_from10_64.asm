    section .text
    global _start

_start:
    mov rdx, len
    mov rcx, msg1
    mov rbx, 1
    mov rax, 4
    int 0x80

    mov rdx, 1
    mov rcx, newline
    mov rbx, 1
    mov rax, 4
    int 0x80
    
    call count_down
    jmp quit


count_down:
    push rax
    push rbx
    push rcx
    push rdx

    xor rax, rax
    xor rbx, rbx
    xor rcx, rcx
    xor rdx, rdx

    add rcx, 0x09
    print_loop:
        push rcx
        ones_print:
            push rcx
            mov rdx, 1
            mov rcx, one
            mov rbx, 1
            mov rax, 4
            int 0x80
            
            dec rcx
            cmp rcx, 0x0
            jle done_ones
            mov rdx, 1
            mov rcx, plus
            mov rbx, 1
            mov rax, 4
            int 0x80
            pop rcx
            jmp ones_print

        done_ones:
            pop rcx

        ;add rcx, 0x30
        ;mov rdx, 1
        ;mov rbx, 1
        ;mov rax, 4
        ;int 0x80

        mov rdx, 1
        mov rcx, newline
        mov rbx, 1
        mov rax, 4
        int 0x80

        pop rcx
        dec rcx
        cmp rcx, 0x0
        jge print_loop

    pop rdx
    pop rcx
    pop rbx
    pop rax
    ret

quit:
    mov rax, 1
    int 0x80

    section .data
msg1    db 'Counting down from 9',0x0
len     equ $ - msg1
newline db '',0xa,0x0
one     db '1',0x0
plus    db '+',0x0
