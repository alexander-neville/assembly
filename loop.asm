;; 'Constants' are declared within the .data section
section.data
    ;; db is 'define butes'. it is used for assigning data to memory, with identifier: greeting
    greeting db "hello world",10
    ;; find the length of the stored string
    length_of_greeting equ $ - greeting

;; The code is wrapped within the .text section
section.text
    ;; This declaration is required to determine where the program begins
    global _start

    ;; This is the entry point for the program and is pointed to by the 'text' section
_start:
    ;; Set-up a syscall that can write our greeting to the standard out channel
    mov rax, 1                  ; The syscall ID is stored in the rax register
    mov rdi, 1                  ; In rdi, the second register involved, store the first arguement of the syscall
    mov rsi, greeting
    mov rdx, length_of_greeting
    syscall
    jmp _start                  ; Jump back to the start of the program.

    mov rax, 60
    mov rdi, 0
    syscall
