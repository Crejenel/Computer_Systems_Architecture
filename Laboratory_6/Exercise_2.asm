bits 32
global start
extern exit, printf
import exit msvcrt.dll
import printf msvcrt.dll

segment data use32 class=data


sir db 2, 1, 13, 4, 7, 13, 12, 7, 7, 7
l db $-sir
rezultat resb 10
inceput dd 0
sfarsit dd 0
aux db 0
maxim dd 0
contor dd 0
format db '%d',0

segment code use32 class=code 
start :

movzx ecx, byte[l]
mov esi, sir
cld
jmp sari

e_prim? :

cmp al, 1
jle nu_e_prim
cmp al, 2
je back

mov byte [aux], al
mov ah, 0
mov bl, 2
idiv bl
cmp ah, 0
je nu_e_prim


mov bl, 3
repeta :   

mov al, byte[aux]
cmp al, bl
je back

mov ah, 0
idiv bl
cmp ah, 0
je nu_e_prim
add bl, 2

jmp repeta  


nu_e_prim :
mov bl, 1
jmp continue

sari :

repeta_1 :

lodsb
jmp e_prim?
back :
mov bl, 0
continue :
cmp bl, 0
je este_prim

mov edx, dword[contor]
cmp edx, dword[maxim]
jnge schimbare

mov dword[maxim], edx
sub esi, 2
mov dword[sfarsit], esi
add esi, 1
sub esi, dword[contor]
mov dword[inceput], esi
add esi, dword[contor]
add esi, 1
mov dword[contor], 0

schimbare :
jmp sari_peste
este_prim :
add dword[contor],1

sari_peste :
loop repeta_1

mov edx, dword[contor]
cmp edx, dword[maxim]
jnge schimbare_1

mov dword[maxim], edx
sub esi, 1
mov dword[sfarsit], esi
add esi, 1
sub esi, dword[contor]
mov dword[inceput], esi

schimbare_1 :

cmp byte[inceput],0
je final

mov esi, dword[inceput]
mov edi, rezultat
go :

lodsb
stosb
movzx eax, byte[esi - 1]

push dword eax
push dword format
call [printf]
add esp, 4*2

cmp esi, dword[sfarsit]
jg final

jmp go


final :
push dword 0
call [exit]
