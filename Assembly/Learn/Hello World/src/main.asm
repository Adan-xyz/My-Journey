; hello world program

section .data
    msg db "Hello World!", 10  ; 10 is the newline character

section .text
    global _start

_start:
    ; write a message to the screen (sys_write)
    mov rax, 1          ; syscall number for write
    mov rdi, 1          ; file descriptor 1 (stdout)
    mov rsi, msg        ; message address
    mov rdx, 20         ; message length
    syscall             ; call the kernel

    ; exit the program (sys_exit)
    mov rax, 60         ; syscall number for exit
    xor rdi, rdi        ; return code 0
    syscall
