org 100h 
mov ah, 0Ah
mov dx, tekst
int 21h

mov ah, 02h
mov dh, 22
mov dl, 22
int 10h

mov ah, 09h
mov dx, tekst+2 
int 21h
mov ax, 4c00h
int 21h

tekst db 20
db 0
times 22 db "$"
