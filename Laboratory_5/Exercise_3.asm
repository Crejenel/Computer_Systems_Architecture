bits 32
global start
extern exit
import exit msvcrt.dll

segment data use32 class=data

;TASK :
;Given a squence of characters S, construct a string D that contains all the digit characters from S.
S db '1','#','+','2','*','a','3' 
lenS equ $-S
D resb lenS


segment code use32 class=code
start:

mov ecx,lenS
mov esi,S
mov edi,D

continue :

mov al,byte[esi]
sub al, '0'
cmp al, 10
jge jump
cmp al, 0
jl jump

mov [edi],al
inc edi

jump:

inc esi

loop continue


push dword 0
call[exit]
