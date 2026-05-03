; Hello World Program (Calculating string length)
 
section .data
    msg db "Hello, brave new world!", 10    ; we can modify this now without having to update anywhere else in the program
 
section .text
    global  _start
 
_start:
 
    mov     rdi, msg     ; move the address of our message string into RDI
    mov     rax, rdi     ; move the address in RDI into RAX as well (Both now point to the same segment in memory)
 
nextchar:
    cmp byte [rax], 0    ; compare the byte pointed to by RAX at this address against zero (Zero is an end of string delimiter)
    jz  finished         ; jump (if the zero flagged has been set) to the point in the code labeled 'finished'
    inc rax              ; increment the address in RAX by one byte (if the zero flagged has NOT been set)
    jmp nextchar         ; jump to the point in the code labeled 'nextchar'

finished:
    sub rax, rdi         ; subtract the address in RDI from the address in RAX
                         ; remember both registers started pointing to the same address (see line 15)
                         ; but RAX has been incremented one byte for each character in the message string
                         ; when you subtract one memory address from another of the same type
                         ; the result is number of segments between them - in this case the number of bytes
 
    mov rdx, rax         ; RAX now equals the number of bytes in our string
    mov rsi, msg         ; the rest of the code should be familiar now
    mov rax, 1
    mov rdi, 1
    syscall
 
    mov rax, 60
    xor rdi, rdi
    syscall
