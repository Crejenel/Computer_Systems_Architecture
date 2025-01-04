bits 32
global start
extern exit, printf, scanf
import exit msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll

segment data use32 class=data

message_intro db 'This program calculates the following expression: a + b + c + d ',0
message_a db 10,'Enter a positive value for a - byte:',0
message_b db 'Enter a positive value for b - word:',0
message_c db 'Enter a positive value for c - dword:',0
message_d_low db 'Enter a positive value for d - qword (part low):',0
message_d_high db 'Enter a positive value for d - qword (part high):',0
message_result db 'The result is:',0
message_infinite_result db 'ERROR: The result is too great for this program to show!',0
format_unsinged db '%u',0
format_qword db "%lld", 0  

a db 0
b dw 0
c dd 0
d_low dd 0
d_high dd 0
result resq 0

segment code use32 class=code
start:

push dword message_intro
call[printf]
add esp, 4

push dword message_a
call[printf]
add esp, 4

push dword a
push dword format_unsinged
call[scanf]
add esp,2*4

push dword message_b
call[printf]
add esp, 4

push dword b
push dword format_unsinged
call[scanf]
add esp,2*4

push dword message_c
call[printf]
add esp, 4

push dword c
push dword format_unsinged
call[scanf]
add esp,2*4

mov eax,0
mov edx,0
add al, byte[a]
add ax, word[b]
jnc continue

add eax,10000h

continue :
add eax, dword[c]
adc edx,0

mov [result+4],edx
mov [result],eax

push dword message_d_low
call[printf]
add esp, 4

push dword d_low
push dword format_unsinged
call[scanf]
add esp, 4*2

push dword message_d_high
call[printf]
add esp, 4

push dword d_high
push dword format_unsinged
call[scanf]
add esp, 4*2

mov eax,[d_low]
mov edx,[d_high]

add [result],eax
adc [result+4],edx

jc NOTdisplay_result

push dword message_result
call [printf]
add esp, 4

push dword [result+4]
push dword [result]
push dword format_qword
call[printf]
add esp, 4*2

jmp final

NOTdisplay_result :

push dword message_infinite_result
call[printf]
add esp,4

final :

push dword 0
call[exit]
