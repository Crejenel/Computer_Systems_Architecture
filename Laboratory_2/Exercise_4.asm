bits 32
global start
extern exit, scanf, printf
import exit msvcrt.dll
import scanf msvcrt.dll
import printf msvcrt.dll

segment data use32 class=data

a_high dd 0
a_low dd 0
b dd 0
quotient resd 1
remainder resd 1

format db "%d", 0
message_quotient db "The quotient of the division of these 2 numbers is : ",0
message_remainder db 10,"The remainder of the division of these 2 numbers is : ",0
message_write_a_low db "Enter the value of a ( low ): ", 0
message_write_a_high db "Enter the value of a ( high ): ", 0
message_write_b db "Enter the value of b : ", 0

segment code use32 class=code
start:

push dword message_write_a_low
call [printf]
add esp, 4

push dword a_low
push dword format
call [scanf]
add esp, 4*3

push dword message_write_a_high
call [printf]
add esp, 4

push dword a_high
push dword format
call [scanf]
add esp, 4*3

push dword message_write_b
call [printf]
add esp, 4

push dword b
push dword format
call [scanf]
add esp, 4*2

mov eax, dword[a_low]
mov edx, dword[a_high]
mov ebx, dword[b]
idiv ebx 
         
mov [quotient],eax
mov [remainder],edx

push dword message_quotient
call [printf]
add esp, 4

push dword [quotient]
push dword format
call [printf]
add esp, 4*2

push dword message_remainder
call [printf]
add esp, 4

push dword [remainder]
push dword format
call [printf]
add esp, 4*2

final:

push dword 0
call [exit]
