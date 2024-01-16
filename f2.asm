section .data
    result_msg db 'Factorial of 5: $'

section .text
    org 100h

start:
    ; Calculate factorial of 5
    mov ax, 5
    call factorial

    ; Display result
    mov ah, 09h
    lea dx, [result_msg]
    int 21h

    ; Convert result to ASCII and print
    mov cx, 10       ; Set divisor for ASCII conversion
    mov bx, 0        ; Initialize counter for number of digits

convert_loop:
    xor dx, dx       ; Clear any previous remainder
    div cx           ; Divide AX by CX, result in AX, remainder in DX
    add dl, '0'      ; Convert remainder to ASCII
    push dx          ; Push ASCII digit onto the stack
    inc bx           ; Increment digit counter
    cmp ax, 0
    jne convert_loop ; Repeat if there are more digits

print_digits:
    pop dx           ; Pop ASCII digit from the stack
    mov ah, 02h      ; DOS function to print character
    int 21h          ; Invoke DOS interrupt to print the character
    dec bx           ; Decrement digit counter
    jnz print_digits ; Repeat if there are more digits

    ; Terminate program
    mov ah, 4Ch
    int 21h

factorial:
    ; Input: ax (number for which factorial is to be calculated)
    ; Output: ax (result)
    cmp ax, 1
    jbe factorial_done   ; If ax <= 1, jump to the end

    ; Recursive call to factorial function
    push ax
    dec ax
    call factorial
    pop bx

    ; Multiply result by current value of ax
    imul ax, bx
    ret

factorial_done:
    ret
