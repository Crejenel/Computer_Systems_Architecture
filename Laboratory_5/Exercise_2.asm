bits 32
global start
extern exit
import exit msvcrt.dll


segment data use32 class=data

;REQUIREMENT :
;Given a sequence of bytes S of length l, construct a sequence D of length l-1 such that 
;the elements of D represent the quotient of each pair of consecutive elements S(i) and S(i+1) from S.

S db 7, -9, 0, -2, 5, 3 ; -> byte sequence
lenS equ $-S
D resb lenS-1

segment code use32 class=code
start:

mov ecx, lenS-1
mov edx,0

continue :

mov al, byte[S+edx]
sub al, byte[S+edx+1]

mov byte[D+edx],al
inc edx

loop continue


push dword 0
call[exit]
