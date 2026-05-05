; Hello World Program (Print with line feed)

%include "src/functions.asm"

section .data
    msg1 db "Hello, brave new world!", 0            ; NOTE we have removed the line feed character 10
    msg2 db "This is how we recycle in NASM.", 0    ; NOTE we have removed the line feed character 10

section .text
    global  _start

_start:

    mov  rax, msg1    
    call sprintLF     ; NOTE we are calling our new print with linefeed function

    mov  rax, msg2    
    call sprintLF     ; NOTE we are calling our new print with linefeed function

    call quit
