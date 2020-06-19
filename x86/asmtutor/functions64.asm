; I DO NOT TAKE CREDIT FOR THIS FILE
; ALL CREDITS GO TO THE WRITER(S) AT 
; https://asmtutor.com/
; I only added comments describing each line

;-----------------------------------------
; int slen(String message)
; message is in eax
; String length calculation function
slen:
    push rbx            ; pushes ebx onto the stack
    mov rbx, rax        ; move the value of eax onto ebx
                        ; to save it for later

nextchar:
    cmp byte[rax], 0    ; if (eax == 0)
    jz finished         ; jump on zero to finished
    inc rax             ; eax += 1 (move over one char)
    jmp nextchar        ; check next step

finished:               
    sub rax, rbx        ; take the difference between the saved
                        ; value of eax, aka ebx, and where eax is rn
    pop rbx             ; pop ebx off the stack
    ret                 ; return, val in eax

;-----------------------------------------
; void sprint(String message)
; message is in eax
; String printing function
sprint:
    push rdx            ; push edx onto the stack
    push rcx            ; push ecx onto the stack
    push rbx            ; push ebx onto the stack
    push rax            ; push eax onto the stack
    call slen           ; find the len of the string in eax

    mov rdx, rax        ; move the value of eax into edx
    pop rax             ; pop the last value of the stack into eax

    mov rcx, rax        ; move the value of eax into ecx
    mov rbx, 1          ; set ebx to 1
    mov rax, 4          ; set eax to 4
    int 80h             ; now it 

    pop rbx             ; pop the top stack element into ebx
    pop rcx             ; pop the top stack element into ebx
    pop rdx             ; pop the top stack element into ebx
    ret                 ; return, val in eax

;-----------------------------------------
; void sprintLF(String message)
; String printing with line feed function
sprintLF:
    call sprint
    push rax            ; push eax onto stack
    mov rax, 0xa        ; move 0xa into eax
    push rax            ; push the linefeed onto the stack
    mov rax, rsp        ; eax = stack pointer
    call sprint         ; print esp=>eax
    pop rax             ; pop top stack into eax
    pop rax             ; pop top into eax
    ret                 ; return

;-----------------------------------------
; void exit()
; Exit program and restore resources
quit:
    mov rbx, 0          ; ebx = 0
    mov rax, 1          ; eax = 1
    int 80h             ; interrupt to kernel
    ret                 ; return