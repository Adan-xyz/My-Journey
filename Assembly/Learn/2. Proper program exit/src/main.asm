; Hello World Program
 
section .data
    msg db "Hello World!", 10
 
section .text
    global  _start
 
_start:

    mov rax, 1
    mov rdi, 1
    mov rsi, msg
    mov rdx, 13
    syscall

    mov rax, 60     ; invoke SYS_EXIT (kernel opcode 60)
    xor rdi, rdi    ; return 0 status on exit - 'No Errors'
    syscall
