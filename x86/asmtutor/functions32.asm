; I DO NOT TAKE CREDIT FOR THIS FILE
; ALL CREDITS GO TO THE WRITER(S) AT 
; https://asmtutor.com/
; I only added comments describing each line

;-----------------------------------------
; int slen(String message)
; message is in eax
; String length calculation function
slen:
    push ebx            ; pushes ebx onto the stack
    mov ebx, eax        ; move the value of eax onto ebx
                        ; to save it for later

nextchar:
    cmp byte[eax], 0    ; if (eax == 0)
    jz finished         ; jump on zero to finished
    inc eax             ; eax += 1 (move over one char)
    jmp nextchar        ; check next step

finished:               
    sub eax, ebx        ; take the difference between the saved
                        ; value of eax, aka ebx, and where eax is rn
    pop ebx             ; pop ebx off the stack
    ret                 ; return, val in eax

;-----------------------------------------
; void sprint(String message)
; message is in eax
; String printing function
sprint:
    push edx            ; push edx onto the stack
    push ecx            ; push ecx onto the stack
    push ebx            ; push ebx onto the stack
    push eax            ; push eax onto the stack
    call slen           ; find the len of the string in eax

    mov edx, eax        ; move the value of eax into edx
    pop eax             ; pop the last value of the stack into eax

    mov ecx, eax        ; move the value of eax into ecx
    mov ebx, 1          ; set ebx to 1
    mov eax, 4          ; set eax to 4
    int 80h             ; now it 

    pop ebx             ; pop the top stack element into ebx
    pop ecx             ; pop the top stack element into ecx
    pop edx             ; pop the top stack element into edx
    ret                 ; return, val in eax

;-----------------------------------------
; void sprintLF(String message)
; String printing with line feed function
sprintLF:
    call sprint
    push eax            ; push eax onto stack
    mov eax, 0xa        ; move 0xa into eax
    push eax            ; push the linefeed onto the stack
    mov eax, esp        ; eax = stack pointer
    call sprint         ; print esp=>eax
    pop eax             ; pop top stack into eax
    pop eax             ; pop top into eax
    ret                 ; return
    

;-----------------------------------------
; void exit()
; Exit program and restore resources
quit:
    mov ebx, 0          ; ebx = 0
    mov eax, 1          ; eax = 1
    int 80h             ; interrupt to kernel
    ret                 ; return
