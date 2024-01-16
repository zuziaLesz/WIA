org 100h

MOV AH,2CH    ; To get System Time
INT 21H

and dh, 1
jz write

MOV ah, 4ch
int 21h

ret

write:
    MOV DX, imie    ; To Print : in DOS
    MOV AH,09H
    INT 21H 

mov ah, 4ch
int 21h

ret

imie db "  JAS", 0Ah,0Dh, "$"