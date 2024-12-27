bits 32
global start
extern exit, scanf, printf
import exit msvcrt.dll
import scanf msvcrt.dll
import printf msvcrt.dll

segment data use32 class=data

a dd 0
b dd 0
result resd 1

format db "%d", 0
message_result db "The sub of this two numbers is : ",0
message_write_a db "Enter the value of a : ", 0
message_write_b db "Enter the value of b : ", 0


segment code use32 class=code
start:

push dword message_write_a
call [printf]
add esp, 4

push dword a
push dword format
call [scanf]
add esp, 4*2

push dword message_write_b
call [printf]
add esp, 4

push dword b
push dword format
call [scanf]
add esp, 4*2

mov eax, dword[a]
mov ebx, dword[b]
sub eax, ebx

mov [result],eax

push dword message_result
call [printf]
add esp, 4

push dword [result]
push dword format
call [printf]
add esp, 4*2


push dword 0
call [exit]
