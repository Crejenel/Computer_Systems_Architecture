bits 32 
global start 
extern exit,printf,scanf
import exit msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll


segment data use32 class=data

message_intro db 'Given a sequence of bytes S (numbers), construct a sequence D1 that contains all positive numbers and a sequence D2 that contains all negative numbers from S.', 0
message_number db 10, 'Enter the number of bytes within the sequence (max 10): ', 0
message_byte db '. Enter the number -> ', 0
message_error_negative db 'Error: The number you have entered is either negative or above the limit!', 0
message_error_byte db 'Error: The number you have entered it cannot be written in a byte memory location!',0
message_result_D2 db 'The D2 sequence has the following numbers : ',0
message_result_D1 db 10,'The D1 sequence has the following numbers : ',0
coma db ', ',0
format db '%i', 0
format_string db '%s',0
number_sequence dd 0
number_byte dd 0
index dd 0
gap dd 0
S resb 10
result resd 10


segment code use32 class=code
start:

push dword message_intro
call [printf]
add esp, 4

push dword message_number
call [printf]
add esp,4

push dword number_sequence
push dword format
call [scanf]
add esp,4*2

cmp byte[number_sequence],0
jl final_1
cmp byte[number_sequence],10
jg final_1  

push dword[number_sequence]

;-----------------------------------citire cati octeti va avea sirul S si salveaza acest numar pe stiva

continue_1 :

push dword [index]
push dword format
call[printf]
add esp,4*2

push dword message_byte
call [printf]
add esp,4

push dword number_byte
push dword format
call[scanf]
add esp, 4*2

mov al,byte[number_byte]
cmp dword[number_byte],255
jg final_2
cmp dword[number_byte],-128
jl final_2

mov edx, dword[index]
mov byte[S+edx],al
add dword[index],1
sub dword[number_sequence],1
cmp dword[number_sequence],0

jne continue_1

;-----------------------------------------------citeste sirul S

pop eax
mov dword[number_sequence],eax
push dword[number_sequence]

mov edx,0
mov ecx,0
mov eax,0

continue_2 :

mov al,byte[S+ecx]
cmp al,0
jl negative

jmp jump
negative :

mov dword[result+edx],eax
inc edx

jump:

inc ecx
sub dword[number_sequence],1
cmp dword[number_sequence],0
jne continue_2

;-----------------------------------------------------------------formeaza sirul D2

pop eax
mov dword [number_sequence],eax
push edx
mov ecx,0
mov eax,0

continue_3 :

mov al,byte[S+ecx]
cmp al,0
jge pozitive

jmp jump_1
pozitive :

mov dword[result+edx],eax
inc edx

jump_1:

inc ecx
sub dword[number_sequence],1
cmp dword[number_sequence],0
jne continue_3

;--------------------------------------------------------formeaza sirul D1


jmp done
final_1 :

push dword message_error_negative
call[printf]
add esp,4

jmp final

final_2 :

push dword message_error_byte
call[printf]
add esp,4

jmp final

done:

;-----------------------------------------------tratarea erorilor

pop eax
mov dword[gap],eax
mov dword[index],0
mov dword[number_sequence],edx
sub dword[number_sequence],eax

cmp eax,0
je D1

push dword message_result_D2
call [printf]
add esp,4


continue_4 :

mov eax,dword[index]

push dword[result+eax*4]
push dword format
call [printf]
add esp, 4*2

push dword coma
push dword format_string
call [printf]
add esp, 4*2

add dword[index],1
sub dword[gap],1
cmp dword[gap],0
jne continue_4

D1 :

cmp dword[number_sequence],0
je  final

push dword message_result_D1
call [printf]
add esp,4

continue_5 :

mov eax,dword[index]

push dword[result+eax*4]
push dword format
call [printf]
add esp, 4*2

push dword coma
push dword format_string
call [printf]
add esp, 4*2

add dword[index],1
sub dword[number_sequence],1
cmp dword[number_sequence],0
jne continue_5

final:

push dword 0
call[exit]
