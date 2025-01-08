bits 32
global start
extern exit,printf
import exit msvcrt.dll
import printf msvcrt.dll

segment data use32 class=data

;TASK:
;A sequence of double words is given. 
;Sort the sequence in descending order based on the lower words of these double words. The upper words remain unchanged.
s dd 12345678h, 1256ABCDh, 12AB4344h, 0xAAAAAAAA
lens equ ($-s)/4
index dd 0

segment code use32 class=code
start:

mov ecx,lens
mov edi, s

continue_1 :

mov esi, s
push ecx
mov edx,dword[edi]
mov ecx, lens
sub ecx, dword[index]
cmp ecx,0
jle final

continue :

mov ebx,dword[index]
mov eax,dword[esi+ebx*4+4]
cmp eax, edx
jna no_swap

mov dword[edi],eax
mov dword[esi+ebx*4+4],edx
mov edx,eax

no_swap :

add esi,4
loop continue

add edi, 4
add dword[index],1
pop ecx

loop continue_1

final :


push dword 0
call[exit]
