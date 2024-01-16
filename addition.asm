org 100h


mov AX, [a]
mov CX, 2
mul CX

mov BX, AX

mov AX, [b]
mov CX, 3
mul CX

add BX, AX

mov [y], BX; liczba do wypisania

mov cx, 5
poczatek:	
	mov dx, 0
	mov ax, bx ;to dodalem
	mov bx, 10
	div bx
	;  l -  w ax jest wynik dzielenia
	push dx  ; r - reszta
	mov bx, ax ;to dodalem
loop poczatek

mov cx, 5
wypisz:
	pop DX
	add DX, '0'
	mov AH, 02h
	int 21h
loop wypisz

mov ax, 4c00h
int 21h

a dw 0x07
b dw 0x03
y dw 0x0