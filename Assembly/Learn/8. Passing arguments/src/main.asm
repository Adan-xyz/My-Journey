; Hello World Program (Passing arguments from the command line)

%include "src/functions.asm"

section .text
global _start

_start:

    pop rsi            ; first value on the stack is the number of arguments

nextArg:

    cmp  rsi, 0        ; check to see if we have any arguments left
    jz   noMoreArgs    ; if zero flag is set jump to noMoreArgs label (jumping over the end of the loop)
    pop  rax           ; pop the next argument off the stack
    call sprintLF      ; call our print with linefeed function
    dec  rsi           ; decrease rsi (number of arguments left) by 1
    jmp  nextArg       ; jump to nextArg label

noMoreArgs:
    call quit
