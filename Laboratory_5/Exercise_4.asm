bits 32
global start
extern exit
import exit msvcrt.dll

segment data use32 class=data

;Two byte sequences S1 and S2 of the same length are given. 
;Construct the sequence D such that each element of D represents the sum of the elements at corresponding positions in S1 and S2.
S1 db 1,2,3,4,5,6
lenS equ $-S1
S2 db 6,5,4,3,2,1
D resb lenS


segment code use32 class=code
start:

mov ecx,lenS
mov esi,S1
mov edi,D

continue :

mov al,byte[esi]
add al,byte[esi+lenS]
mov byte[edi],al
inc edi
inc esi

loop continue


push dword 0
call[exit]
