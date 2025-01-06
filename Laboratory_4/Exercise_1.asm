bits 32
global start
extern exit,printf,scanf
import exit msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll

segment data use32 class=data

message_intro db 'Given 4 bytes, obtain in AX the sum of the integers (unsinged) represented by bits 4-6 of the 4 bytes.',0
message_byte_1 db 10,'Give the first sequence of 8 bits:',0
message_byte_2 db 'Give the second sequence of 8 bits:',0
message_byte_3 db 'Give the third sequence of 8 bits:',0
message_byte_4 db 'Give the fourth sequence of 8 bits:',0
message_result db 'The result is:',0
format_string_max_8 db '%8s',0
format_decimal_unsigned db '%u',0
result dd 0
byte_1_string resb 9
byte_2_string resb 9
byte_3_string resb 9
byte_4_string resb 9
byte_1 db 0
byte_2 db 0
byte_3 db 0
byte_4 db 0

segment code use32 class=code
start:

push dword message_intro
call [printf]
add esp,4

push dword message_byte_1
call [printf]
add esp,4

push dword byte_1_string
push dword format_string_max_8
call [scanf]
add esp, 4*2

mov eax,0
mov edx,0
mov ecx,0

continue_1 :

mov dl, byte[byte_1_string+ecx]
cmp dl,0
je done_1

shl eax,1
sub dl,'0'
add eax,edx
inc ecx

jmp continue_1
done_1 :

mov [byte_1],al

push dword message_byte_2
call [printf]
add esp, 4

push dword byte_2_string
push dword format_string_max_8
call [scanf]
add esp,4*2

mov eax,0
mov edx,0
mov ecx,0

continue_2 :

mov dl, byte[byte_2_string+ecx]
cmp dl,0
je done_2

shl eax, 1
sub dl,'0'
add eax, edx
inc ecx

jmp continue_2
done_2:

mov [byte_2],al

push dword message_byte_3
call [printf]
add esp, 4

push dword byte_3_string
push dword format_string_max_8
call [scanf]
add esp, 4*2

xor eax,eax
and edx, 0
mov ecx,0

continue_3 :

mov dl, byte[byte_3_string+ecx]
cmp dl,0
je done_3

shl eax,1
sub dl,'0'
add eax, edx
inc ecx

jmp continue_3
done_3 :

mov [byte_3],al

push dword message_byte_4
call [printf]
add esp, 4

push dword byte_4_string
push dword format_string_max_8
call [scanf]
add esp, 4*2

xor eax,eax
and edx, 0
mov ecx,0

continue_4 :

mov dl, byte[byte_4_string+ecx]
cmp dl,0
je done_4

shl eax,1
sub dl,'0'
add eax, edx
inc ecx

jmp continue_4
done_4 :

mov [byte_4],al

mov ecx,4
xor edx,edx
and ebx,0
mov eax,0

continue :

mov dl,byte[byte_1+ebx]
shr dl , 2
and dl, 00000111b
add ax,dx
inc ebx

loop continue

mov [result],eax

push dword message_result
call [printf]
add esp, 4*2

push dword [result]
push dword format_decimal_unsigned
call [printf]
add esp,4*2


push dword 0
call[exit]
