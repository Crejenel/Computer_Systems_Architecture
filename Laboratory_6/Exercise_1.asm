bits 32
global start
extern exit,printf
import exit msvcrt.dll
import printf msvcrt.dll

segment data use32 class=data

;TASK:
;Given a sequence of numbers written as double words, 
;form the sequence d by extracting the least significant byte from the least significant word 
;of the double words that are divisible by 7 in the sequence.
s dd 000007F4h, 12345678h, 00008738h, 0xABCDEF01, 0000D9CBh, 0xDEADBEEF
lens equ ($-s)/4
d resb lens

segment code use32 class=code
start:

mov ecx,lens
mov esi,s
mov edi,d

continue :

mov eax,dword[esi]
mov edx,0
mov ebx,7
div ebx
cmp edx,0
jne not_divisible_by_7

lodsb
stosb
add esi,3

jmp jump
not_divisible_by_7 :

add esi,4
jump:
loop continue


push dword 0
call[exit]
