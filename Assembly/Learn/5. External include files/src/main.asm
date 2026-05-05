; Hello World Program (External file include)

%include "src/functions.asm"    ; include our external file

section .data
    msg1 db "Hello, brave new world!", 10            ; our first message string
    msg2 db "This is how we recycle in NASM.", 10    ; our second message string

section .text
    global  _start

_start:

    mov  rax, msg1    ; move the address of our first message string into RAX
    call sprint       ; call our string printing function

    mov  rax, msg2    ; move the address of our second message string into RAX
    call sprint       ; call our string printing function

    call quit         ; call our quit function
