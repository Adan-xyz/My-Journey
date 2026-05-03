; Hello World Program (Subroutines)
 
section .data
    msg db "Hello, brave new world!", 10
 
section .text
    global  _start
 
_start:
 
    mov  rax, msg        ; move the address of our message string into RAX
    call strlen          ; call our function to calculate the length of the string
 
    mov rdx, rax         ; our function leaves the result in RAX
    mov rsi, msg         ; this is all the same as before
    mov rax, 1
    mov rdi, 1
    syscall

    mov rax, 60
    xor rdi, rdi
    syscall
 
strlen:                  ; this is our first function declaration
    push rdi             ; push the value in RDI onto the stack to preserve it while we use RDI in this function
    mov  rdi, rax        ; move the address in RAX into RDI (Both point to the same segment in memory)
 
nextchar:                ; this is the same as 3. Calculate string length
    cmp byte [rax], 0    
    jz  finished
    inc rax
    jmp nextchar
 
finished:
    sub rax, rdi
    pop rdi              ; pop the value on the stack back into RDI
    ret                  ; return to where the function was called
