org 100h
call read_int
push ax

loop:
	call get_char
	cmp ax, '='
	je end_loop
    mov si, ax

	mov dl, 13   ;nowa linie
    mov ah, 02h
    int 21h   
    mov dl, 10
    int 21h

	call read_int
	pop bx

	cmp si, '+'
	je dodawanie

	cmp si, '-'
	je odejmowanie
	fin:
	push bx
loop loop

end_loop:
    mov dl, 13
    mov ah, 02h
    int 21h   

    mov dl, 10
    int 21h 
    pop ax
    push word ax

    call write_int

    mov ax, 4c00h
    int 21h
ret
odejmowanie:
	sub bx, ax
jmp fin
dodawanie:
	add bx, ax
jmp fin

get_char:
	mov ah, 01h     
    int 21h    
    mov ah, 0
    movzx ax, al
ret

read_int:
	push bp
	mov bp, sp
	add bp, 4
	push bx
	push cx
	push dx
	push word 0	; [bp-12] ; local variable to store result. Initially 0
	push word 1 ; [bp-14]
	.l:
		mov ah, 1
		int 21h
		cmp AL, 13
		je .finish
		cmp al, '-'
		jne .forward
		mov word [bp-14], -1
		jmp .l
		.forward:
		sub al, '0'
		mov ah, 0
		mov bx, ax
		mov ax, 10
		imul word [bp-12]
		add ax, bx
		mov [bp-12], ax
	jmp .l
	.finish:
	mov ax, word [bp-12]
	mov bx, word [bp-14]
	imul bx
	mov [bp-12], ax
	pop ax
	pop ax
	pop dx
	pop cx
	pop bx
	pop bp
ret


; print signed decimal number
; input: signed 16 bit int
; no output
write_int:
	push bp
	mov bp, sp
	add bp, 4
	mov cx, 0
	mov ax, [bp]
	shr ax, 15
	cmp ax, 1
	je .sign
	mov ax, [bp]
	jmp .nosign
	.sign:
	mov AH, 2
	mov DL,'-'
	int 21h
	mov ax, [bp]
	not ax
	inc ax
	.nosign:
		mov dx, 0
		mov bx, 10
		div bx
		push dx
		inc cx
		cmp ax, 0
		je .printing
	jmp .nosign
	.printing:
		pop dx
		add dl, '0'
		mov ah, 2
		int 21h
	loop .printing
	pop bp
ret
