
org 100h

start:
    ; Calculate factorial of 5
    mov ax, 5
    call factorial

    mov ax, cx          ; Move the result to AX for printing
    call print_number   ; Print the result

    ; Terminate program
    mov ah, 4Ch
    int 21h

factorial:
    ; Input: ax (number for which factorial is to be calculated)
    ; Output: cx (result)
    mov cx, 1            ; Initialize result to 1

factorial_loop:
    cmp ax, 1
    jbe factorial_done   ; If ax <= 1, jump to the end

    ; Multiply result by current value of ax
    imul cx, ax

    ; Decrement ax
    dec ax

    jmp factorial_loop   ; Repeat the loop

factorial_done:
    ret

print_number:
    ; Input: ax (number to be printed)
    ; Output: (prints the number)
    mov cx, 10
    mov bx, 0

print_loop:
    xor dx, dx          ; Clear any previous remainder
    div cx
    add dl, '0'
    push dx
    inc bx
    cmp ax, 0
    jne print_loop

print_digits:
    pop dx
    mov ah, 02h
    int 21h
    dec bx
    jnz print_digits

    ret
