; Hello World Program (NULL terminating bytes)

%include "src/functions.asm"

section .data
    msg1 db "Hello, brave new world!", 10, 0            ; NOTE the null terminating byte
    msg2 db "This is how we recycle in NASM.", 10, 0    ; NOTE the null terminating byte

section .text
    global  _start

_start:

    mov  rax, msg1
    call sprint 

    mov  rax, msg2
    call sprint

    call quit
