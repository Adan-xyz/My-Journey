;------------------------------------------
; int slen(String message)
; String length calculation function
slen:
    push rdi
    mov  rdi, rax

nextchar:
    cmp byte [rax], 0
    jz  finished
    inc rax
    jmp nextchar

finished:
    sub rax, rdi
    pop rdi
    ret


;------------------------------------------
; void sprint(String message)
; String printing function
sprint:
    push rdx
    push rsi
    push rdi
    push rax
    call slen

    mov rdx, rax
    pop rax

    mov rsi, rax
    mov rax, 1
    mov rdi, 1
    syscall

    pop rdi
    pop rsi
    pop rdx
    ret


;------------------------------------------
; void sprintLF(String message)
; String printing with line feed function
sprintLF:
    call sprint
 
    push rax         ; push rax onto the stack to preserve it while we use the rax register in this function
    mov  rax, 10     ; move 10 into rax - 10 is the ascii character for a linefeed
                     ; as rax is 4 bytes wide, it now contains 0000000Ah
    push rax         ; push the linefeed onto the stack so we can get the address
                     ; given that we have a little-endian architecture, rax register bytes are stored in reverse order,
                     ; this corresponds to stack memory contents of 10, 0, 0, 0,
                     ; giving us a linefeed followed by a NULL terminating byte
    mov  rax, rsp    ; move the address of the current stack pointer into rax for sprint
    call sprint      ; call our sprint function
    pop  rax         ; remove our linefeed character from the stack
    pop  rax         ; restore the original value of rax before our function was called
    ret              ; return to our program


;------------------------------------------
; void exit()
; Exit program and restore resources
quit:
    mov rax, 60
    xor rdi, rdi
    syscall
    ret
