
org 100h

start:
    ; Calculate factorial of 5
    mov ax, 5
    call factorial

    mov ax, cx          ; Move the result to AX for printing
    call print_number   ; Print the result

    mov ah, 4Ch
    int 21h

factorial:
    mov cx, 1           

factorial_loop:
    cmp ax, 1    ; cmp - porownuje
    jbe factorial_done   ; If ax <= 1, jump to the end

    ; Multiply result by current value of ax
    imul cx, ax

    ; Decrement ax
    dec ax

    jmp factorial_loop   ; Repeat the loop

factorial_done:
    ret

print_number:
    mov cx, 10
    mov bx, 0

print_loop:
    xor dx, dx          ; Clear any previous remainder
    div cx
    add dl, '0'
    push dx
    inc bx ; add 1
    cmp ax, 0
    jne print_loop  ; jump if not equal

print_digits:
    pop dx
    mov ah, 02h
    int 21h
    dec bx
    jnz print_digits

    ret
