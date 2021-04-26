section .data

    greeting db "hello world",10
    length_of_greeting equ $ - greeting ; find the length of the string.

section .text

    global _start

_start:

    mov rax, 1                  ; The syscall ID is stored in the rax register
    mov rdi, 1                  ; In rdi, the second register involved, store the first arguement of the syscall
    mov rsi, greeting
    mov rdx, length_of_greeting
    syscall

    mov rax, 60
    mov rdi, 0
    syscall                     ; exit the program
