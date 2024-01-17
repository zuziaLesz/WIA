org 100h
call readnum
mov cx, ax
petla:
    mov ah, 2
    mov dl, '#'
    int 21h
loop petla


mov ax, 4c00h ; program requested to terminate
int 21h

readnum:
; jako ze nie mamy zadnych argumentow, to nawet nie musimy robic tej preambuly z ustawianiem bp
push bx
push cx
push dx
mov bx, 0
.reading:
    mov ah, 1
    int 21h
    cmp al, 13   ;13- enter - w al przechowywany przycis?
    je .koniec
    sub al, '0'  ; '0' - zmiana znaku na liczbe
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