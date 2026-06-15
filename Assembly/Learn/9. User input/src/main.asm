; Hello World Program (Getting input)

%include "src/functions.asm"
 
section .data
msg1 db "Please enter your name: ", 0      ; message string asking user for input
msg2 db "Hello, ", 0                       ; message string to use after user has entered their name
 
section .bss
sinput: resb 255                           ; reserve a 255 byte space in memory for the users input string
 
section .text
global _start
 
_start:

    mov     rax, msg1
    call    sprint
 
    mov     rdx, 255        ; number of bytes to read
    mov     rsi, sinput     ; reserved space to store our input (known as a buffer)
    mov     rdi, 0          ; read from the STDIN file
    mov     rax, 0          ; invoke SYS_READ (kernel opcode 0)
    syscall
 
    mov     rax, msg2
    call    sprint
 
    mov     rax, sinput     ; move our buffer into rax (Note: input contains a linefeed)
    call    sprint          ; call our print function
 
    call    quit
