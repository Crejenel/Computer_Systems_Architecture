bits 32 
global start        
extern exit,printf,scanf              
import exit msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll
 
segment data use32 class=data
   
a dd 0
b dd 0
c dd 0
d dd 0
result resd 1
format db '%d', 0
message db 'This program calculates the following expression : (d-c)+(b+b-c-a)+d | a,b,c,d - word ',0
message_a db 10,'Choose a value for a : ',0
message_b db 'Choose a value for b : ',0
message_c db 'Choose a value for c : ',0
message_d db 'Choose a value for d : ',0
messgae_result db 'The result is : ',0
   
segment code use32 class=code
start:

push dword message
call [printf]
add esp, 4

push dword message_a
call [printf]
add esp, 4

push dword a
push dword format
call [scanf]
add esp, 4*2

push dword message_b
call [printf]
add esp, 4

push dword b
push dword format
call [scanf]
add esp, 4*2

push dword message_c
call [printf]
add esp, 4

push dword c
push dword format
call [scanf]
add esp, 4*2

push dword message_d
call [printf]
add esp, 4

push dword d
push dword format
call [scanf]
add esp, 4*2

mov ax, [d]
sub ax, [c]
cwde

add [result],eax

movsx eax, word[b]
mov ebx, eax
add eax, ebx
movsx ebx, word[c]
sub eax, ebx
movsx ebx, word[a]
sub eax,ebx

add [result],eax

movsx eax, word[d]

add [result],eax


push messgae_result
call [printf]
add esp, 4

mov ax, [result]
cwde

push dword eax
push dword format
call [printf]
add esp, 4*2

        
push dword 0      
call [exit]       
