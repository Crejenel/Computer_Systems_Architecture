bits 32
global start
extern exit,printf
import exit msvcrt.dll
import printf msvcrt.dll

segment data use32 class=data

;Given a byte sequence S, determine the maximum of the elements at even positions 
;and the minimum of the elements at odd positions in S.
S db 1, 4, 2, 3, 8, 4, 9, -5
lenS equ $-S
message_maxim db 'The maxim is : ',0
message_minim db 10,'The minim is : ',0
format db '%d',0
maxim db 0
null_max times 3 db 0
minim db 127
null_min times 3 db 0

segment code use32 class=code
start:

mov ax,lenS
mov bl,2
div bl
cmp ah,0
je even_
movzx ecx,al
sub ecx,1
jmp done
even_:
movzx ecx,al
done:

mov esi,S
cld
continue_1 :

lodsb
cmp al, byte[maxim]
jng no_swap

mov byte[maxim],al

no_swap:
add esi,1

loop continue_1


mov ax, lenS
mov bl, 2
div bl
cmp ah,1
jmp odd_

movzx ecx,al
sub ecx,1
jmp done_1

odd_:
movzx ecx,al

done_1:

mov esi,S
add esi,1
cld

continue_2 :

lodsb
cmp al,byte[minim]
jnl no_swap_1

mov byte[minim],al

no_swap_1 :
add esi,1

loop continue_2

push dword message_maxim
call [printf]
add esp,4

push dword [maxim]
push dword format
call [printf]
add esp,4*2

push dword message_minim
call [printf]
add esp,4

movsx eax, byte[minim]

push eax
push dword format
call [printf]
add esp,4*2

push dword 0
call[exit]
