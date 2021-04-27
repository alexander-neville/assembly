section .bss

    string resb 100             ; hold the string itself
    position resb 8             ; hold the current position along the string

section .text

    global _start

_start:

    mov r13, 1                  ; the current number
    mov r14, 0                  ; the last number
    mov r15, 0                  ; initialise a counter

_loop:

    mov r12, r13                ; backup the value in r13
    add r13, r14                ; add the previous number to this number
    mov r14, r12                     ; pop the value on the stack into r14, the previous number
    mov rax, r13                     ; move the current number into rax
    call _print                 ; call the print subroutine
    inc r15                     ; increment the counter
    cmp r15, 10
    jl _loop                    ; loop if iterations < 10
    call _exit                  ; call the exit subroutine

_print:                         ; define a subroutine which prints the value in rax.

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

    ret                         ; end of subroutine, value of rax has been printed.

_exit:

    mov rax, 60
    mov rdi, 0
    syscall                     ; exit the program with sys_exit
