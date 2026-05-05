slen:
    push rdi
    mov  rdi, rax

nextchar:
    cmp byte [rax], 0
    jz  finished
    inc rax
    jmp nextchar

finished:
    sub rax, rdi
    pop rdi
    ret


sprint:
    push rdx
    push rsi
    push rdi
    push rax
    call slen

    mov rdx, rax
    pop rax

    mov rsi, rax
    mov rax, 1
    mov rdi, 1
    syscall

    pop rdi
    pop rsi
    pop rdx
    ret


quit:
    mov rax, 60
    xor rdi, rdi
    syscall
    ret
