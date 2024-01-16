org 100h

section .data
    buffer db 7          ; Buffer to store the input (6 digits + null terminator)
    newline db 0x0A, 0x0D, '$'   ; Newline characters for printing

section .text
    global _start

_start:

    ; Read a 6-digit number from the user
    mov ah, 0Ah         ; DOS function to read string
    lea dx, [buffer]    ; Address of the buffer
    int 21h             ; Call DOS

    ; Convert ASCII to binary (assuming a valid 6-digit number)
    movzx ax, word [buffer+2] ; Starting from the second character in the buffer
    sub ax, '0'         ; Convert ASCII to integer

    ; Print the number
    mov cx, 10000       ; Set divisor for the first digit
    mov bx, 10          ; Set divisor for the next digits

print_loop:
    ; Divide AX by CX, result in DX, quotient in AX
    div cx

    add dl, '0'         ; Convert remainder to ASCII

    ; Print the digit using DOS interrupt 21h
    mov ah, 02h         ; DOS function to print character
    int 21h             ; Invoke DOS interrupt to print the character

    cmp cx, 1           ; Check if CX is 1, which means the last digit
    jne print_loop      ; Repeat if there are more digits

    ; Print newline characters
    mov ah, 02h
    lea dx, [newline]
    int 21h

    ; Terminate the program
    mov ah, 4Ch          ; DOS function to exit program
    int 21h              ; Call DOS
