bits 32
global start
extern exit, printf, scanf
import exit msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll

segment data use32 class=data

message_intro db 'This program calculates the following expression: d-[3*(a+b+2)-5*(c+2)]',0
message_a db 10,'Enter the value for a - byte: ',0
message_b db 'Enter the value for b - byte: ',0
message_c db 'Enter the value for c - byte: ',0
message_d db 'Enter the value for d - word: ',0
message_result db 'The result is: ',0

a db 0
b db 0
c db 0
d dw 0
empty dw 0 ; IMPORTANT - for memory safety
result dd 0

format db '%d',0

segment code use32 class=code 
start :

push dword message_intro
call [printf]
add esp,4

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

mov al,byte [a]
add al,byte [b]
jo jump_1

add [result], al

jmp jump_2

jump_1:
mov al, byte[a]
cbw
mov bx, ax
mov al, byte[b]
cbw
add bx,ax
add [result],bx

jump_2 :

add word[result], 2


mov ax,[result]
mov bx,3
imul bx

mov word[result],ax


push message_c
call [printf]
add esp, 4

push dword c
push dword format
call [scanf]
add esp, 4*2

mov al, byte[c]
cbw
add ax, 2

mov bx,-5
imul bx

add word[result],ax

push dword message_d
call [printf]
add esp, 4

push dword d
push dword format
call [scanf]
add esp, 4*2

movsx eax, word[d]
movsx ebx, word[result]
sub eax, ebx
mov [result], eax

push message_result
call [printf]
add esp, 4

push dword[result]
push format
call [printf]
add esp, 4*2

push dword 0
call [exit]
