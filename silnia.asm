org 100h

mov cx, 5  ; <-- wartość przekazywana do funkcji  

mov ax, cx        
call factorial  


mov ah, 4Ch       
int 21h           

factorial:
    cmp ax, 1      
    je  end_factorial 
    
    push ax        
    dec ax         
    call factorial 
    
    pop cx         
    mul cx         
    
end_factorial:
    ret     