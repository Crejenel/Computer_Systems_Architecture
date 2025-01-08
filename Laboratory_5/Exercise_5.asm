bits 32
global start
extern exit
import exit msvcrt.dll

segment data use32 class=data

;Two character strings S1 and S2 are given. 
;Construct the string D by concatenating the elements at positions multiple of 3 from string S1 
;with the elements of string S2 in reverse order.
S1 db '+', '4', '2', 'a', '8', '4', 'X', '5'
lenS1 equ $-S1
S2 db '3', '4', '5'
lenS2 equ $-S2
D times lenS1+lenS2 db 0


segment code use32 class=code
start:

mov esi,S1
mov edi,D
mov dx,0
mov ax, lenS1
mov bx,3
div bx
mov ecx,0
mov cx, ax
jecxz next

continue_1:

mov al,byte[esi]
mov byte[edi],al
add esi,3
inc edi

loop continue_1

next :

mov esi, S2
add esi, lenS2-1
mov ecx,lenS2

continue_2 :

std
lodsb

cld
stosb

loop continue_2


push dword 0
call[exit]
