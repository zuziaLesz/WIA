org 100h

;godziny

MOV AH,2CH    ; To get System Time
INT 21H
MOV AL,CH     ; Hour is in CH
AAM		;to robi cos w stylu "wszystkie liczby traktowac jako system dziesiętny
MOV BX,AX
CALL DISP

MOV DL,':'
MOV AH,02H    ; drukuj :
INT 21H

;MINUTES:
MOV AH,2CH    ; To get System Time
INT 21H
MOV AL,CL     ; Minutes is in CL
AAM
MOV BX,AX
CALL DISP

MOV DL,':'    ; :
MOV AH,02H
INT 21H

;Seconds Part
;Seconds:
MOV AH,2CH    ; To get System Time
INT 21H
MOV AL,DH     ; Seconds is in DH
AAM
MOV BX,AX
CALL DISP

; jesli np sekundy - wypisz imie

and dh, 1  ; jezeli w rejestrze jest nieparzysta bedzie 1
jnz wypisz






mov ah, 4ch
int 21h

wypisz:

MOV DX, imie    ; To Print : in DOS
MOV AH,09H
INT 21H

ret

DISP:
MOV DL,BH      ; Since the values are in BX, BH Part
ADD DL,30H     ; ASCII Adjustment
MOV AH,02H     ; To Print in DOS
INT 21H
MOV DL,BL      ; BL Part 
ADD DL,30H     ; ASCII Adjustment
MOV AH,02H     ; To Print in DOS
INT 21H
RET

imie db "  OLA "