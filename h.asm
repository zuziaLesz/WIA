org 100h

call readnum
push ax

call readnum
push ax

; wczytaj znak
mov ah, 1
int 21h

; ustaw kursor
pop cx
mov dh, cl
pop cx
mov dl, cl
mov ah, 2
mov bh, 0
int 10h

mov ah, 0Eh
mov bx, 0
int 10h

mov ah, 4ch
int 20h

ret

readnum:
; jako ze nie mamy zadnych argumentow, to nawet nie musimy robic tej preambuly z ustawianiem bp
push bx
push cx
push dx
mov bx, 0
.reading:
    mov ah, 1
    int 21h
    cmp al, 13
    je .koniec
    sub al, '0'
    mov ah, 0
    mov cx, ax
    ; w cx,  wczytana cyfra
    mov ax, 10
    mul bx
    mov bx, ax ; mnozymy bx przez 10
    ; DX:AX := AX ∗ r/m16)
    add ax, cx
    mov bx, ax ; w bx jest nasza cala liczba
    jmp .reading
.koniec:
mov ax, bx
pop dx
pop cx
pop bx
ret