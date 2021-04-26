section .data

    test_string_1 db "test_string_1",10,0 ; define a test string
    test_string_2 db "test_string_2",10,0 ; define a test string

section .text

    global _start

_start:

    mov r15, test_string_1      ; load the address of a string into r15
    call _print                 ; call the _print subroutine
    mov r15, test_string_2      ; load the address of a string into r15
    call _print                 ; call the _print subroutine
    jmp _exit                   ; exit the program

_print:

    push r15                    ; put the beginning of the string on the stack
    mov rbx, 0                  ; keep track of the length

_iteration:

    inc r15
    inc rbx
    mov cl, [r15]               ; copy the character at r15 into cl
    cmp cl, 0
    jne _iteration              ; if the current character != 0, increment again.

    mov rax, 1                  ; put together a sys_write call
    mov rdi, 1
    pop rsi                     ; retrieve the start of the string from the stack
    mov rdx, rbx                ; copy the final length of the string into the rdx register
    syscall

    ret                         ; return to the function call

_exit:

    mov rax, 60
    mov rdi, 0
    syscall                     ; exit the program with sys_exit
