org 100h

mov ah, 01h ;pobieram character
int 21h

sub ax, z ;usuwam '0' zeby zostala liczba chyba tak trzeba


and ax, 1 ; tak trzeba zeby ustawic flage nwm o co chodzi

;skoki sprawdzaja co jest w AX, nasza liczba jest zapisana w al ale to ok bo ax sie sklada z al i ah

jnz nparzyste
jz parzyste

parzyste:
    mov dx, p ;ustaw msg parzyste
jmp dalej

nparzyste:
    mov dx, np ;ustaw msg np
jmp dalej

dalej:
mov ah, 9 ;wypisz msg
int 21h

koniec:
mov ax, 4C00h
int 0x21

p db " parzyste ", 0Ah,0Dh, "$"
np db " np", 0Ah,0Dh, "$"
z db "0"