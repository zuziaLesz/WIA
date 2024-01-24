org 100h
call read_int
mov bx, ax
mov ah, 0Ah
mov dx, buffer
int 21h
mov cx, bx
loop:
    mov ah, 09h
    mov dx, buffer.data
    int 21h
    call print_newline
loop loop
print_newline:
    mov ah, 2
    mov dl, 13
    int 21h
    mov dl, 10
    int 21h
    ret

mov ax, 4c00h
int 21h
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
buffer:
.max db 10
.len db 0
.data db '$$$$$$$$$$'
