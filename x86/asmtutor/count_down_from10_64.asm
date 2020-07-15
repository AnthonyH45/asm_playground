    %include 'functions64.asm'
    section .text
    global _start

_start:
    mov rax, msg1                           ; rax <- "Counting down from 10"
    call sprint                             ; print msg
    mov rax, newline
    call sprint
    ;call count_down
    jmp end

end:
    call quit

    section .data
msg1    db 'Counting down from 10',0x0
newline db '',0xa,0x0
