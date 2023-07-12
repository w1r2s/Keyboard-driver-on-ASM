    Assume  CS: Code, DS: Code
    Code    SEGMENT
org     100h
frequency1 equ     500    
frequency2 equ     800    
duration1  equ     500    
duration2  equ     500     
sysPort    equ     61h    
.286

    Start proc near
mov ax,cs ; CS = DS
mov ds,ax 

    Main: 
mov ah,0
int 16h
mov dh,ah  
mov dl,al 
 
mov ah,02h 
int 21h

cmp al,' ' ; space button
je exit
cmp dh,52h ; 0  
je buttonSound
cmp dh,4Fh ; 1  
je buttonSound
cmp dh,50h ; 2 
je buttonSound
cmp dh,51h ; 3
je buttonSound
cmp dh,4Bh ; 4
je buttonSound
cmp dh,4Ch ; 5
je buttonSound
cmp dh,4Dh ; 6
je buttonSound
cmp dh,47h ; 7
je buttonSound
cmp dh,48h ; 8
je buttonSound
cmp dh,49h ; 9
je buttonSound
jmp Main

    exit: ; exit function
mov ah,4ch
int 21h
    buttonSound:
call firstSound
call secondSound
jmp Main
    Start endp

    firstSound proc
mov dx,duration1
mov di,frequency1
cli 
in al,sysPort
and al,11111110b

    do_firstSound:
or   al,00000010b    
out     sysPort,al       
mov     cx,di           
loop    $   
and     al,11111101b   
out     sysPort,al       
mov     cx,di           
loop    $          
dec     dx          
jnz     do_firstSound       
sti        
ret
    firstSound endp

    secondSound proc
mov dx,duration2
mov di,frequency2
cli 
in al,sysPort
and al,11111110b

    do_secondSound:
or   al,00000010b   
out     sysPort,al      
mov     cx,di         
loop    $    
and     al,11111101b   
out     sysPort,al   
mov     cx,di          
loop    $         
dec     dx        
jnz     do_secondSound    
sti       
ret
    secondSound endp
  
    Code ENDS
        END Start