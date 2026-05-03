; Hello World Program
 
section .data
    msg db "Hello World!", 10    ; assign msg variable with your message string
 
section .text
    global  _start
 
_start:

    mov rax, 1      ; invoke SYS_WRITE (kernel opcode 1)
    mov rdi, 1      ; write to the STDOUT file
    mov rsi, msg    ; move the memory address of our message string into rsi
    mov rdx, 13     ; number of bytes to write - one for each letter plus 10 (line feed character)
    syscall
