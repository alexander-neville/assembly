section .bss

    string resb 100             ; hold the string itself
    position resb 8             ; hold the current position along the string

section .text

    global _start

_start:

    mov rax, 37                 ; put the number to print in rax
    call _print                 ; call the print subroutine
    call _exit                  ; call the exit subroutine

_print:

    mov rcx, string
    mov rbx, 10                 ; newline character
    mov [rcx], rbx              ; put the newline at the beginning of the string
    inc rcx                     ; increment the position along the string
    mov [position], rcx         ; distance along string

_reverse_number:

    mov rdx, 0                  ; zero the rdx register before div/mod operation
    mov rbx, 10                 ; converting from base 10, so divide by 10 each iteration.
    div rbx                     ; divide value in rax by rbx (10) remainder is stored in rdx
    add rdx, 48                 ; to get the ascii value of the character add 48

    mov rcx, [position]
    mov [rcx], dl               ; move least significant bytes of of rdx to address held by rcx
    inc rcx                     ; increment the position along the string.
    mov [position], rcx         ; store the position back in memory

    cmp rax, 0                  ; if there are whole parts left after division, call the function again.
    jne _reverse_number

_display:

    mov rcx, [position]

    mov rax, 1
    mov rdi, 1
    mov rsi, rcx
    mov rdx, 1
    syscall

    mov rcx, [position]
    dec rcx                     ; starting with the end of the address, iterate backward.
    mov [position], rcx

    cmp rcx, string
    jge _display                ; if the position is not yet back at the start, print the next character.

    ret

_exit:

    mov rax, 60
    mov rdi, 0
    syscall                     ; exit the program with sys_exit
