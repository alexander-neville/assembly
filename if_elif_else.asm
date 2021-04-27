section .data

    equal db "equal",10
    length_equal equ $ - equal ; find the length of the string.
    less db "less",10
    length_less equ $ - less ; find the length of the string.
    more db "more",10
    length_more equ $ - more ; find the length of the string.

section .text

    global _start

_start:

    mov r15, 1
    mov r14, 1
    cmp r15, r14
    jl _less
    jg _more

    mov rax, 1
    mov rdi, 1
    mov rsi, equal
    mov rdx, length_equal
    syscall
    call _exit

_less:

    mov rax, 1
    mov rdi, 1
    mov rsi, less
    mov rdx, length_less
    syscall
    call _exit

_more:

    mov rax, 1
    mov rdi, 1
    mov rsi, more
    mov rdx, length_more
    syscall
    call _exit

_exit:

    mov rax, 60
    mov rdi, 0
    syscall
