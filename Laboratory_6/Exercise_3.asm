bits 32
global start
extern exit, printf
import exit msvcrt.dll
import printf msvcrt.dll

segment data use32 class=data public

S dd 01150017h,  1025000Bh, 000BA006h, 00321025h, 0014001Ah
ls equ ($-S)/4  ; lungimea lui S
D1 resw ls   
D2 resw ls*2 
format db '%c',0
format_2 db '%x',10,0
oprire db 0
numar dw 0
auxiliar dd 0
tabela db '0123456789ABCDEF',0
maxim dw 0
contor db 0

segment code use32 class=data public
start :

mov ecx, ls
mov esi, S
mov edi, D1

repeta :

mov edx, 0 
mov dx, [esi+2] 
push edx    

mov eax,[esp]
cmp ax,1
jbe nu_e_prim
cmp ax, 2
je e_prim
mov ebx,eax
and ebx, 00000001b
cmp ebx,0
je nu_e_prim

mov word[numar],3

repeta_prim :

mov dx, 0
cmp ax, word[numar]
je e_prim
mov dword[auxiliar],eax
div word[numar]
cmp dx, 0
je nu_e_prim
mov eax, dword[auxiliar]
add word[numar],2

jmp repeta_prim

e_prim :
mov ebx, 1
jmp peste
nu_e_prim :
mov ebx, 0
peste :

pop edx

cmp ebx,0
je mai_departe

mov word[edi],dx
add edi, 2

mai_departe :
add esi,4
loop repeta

mov esi, D1
mov ebx, tabela

afisare_1 :
mov edx,0
mov eax,0
mov dx, word[esi] 

mov al, dh   
shr al, 4    
xlat

push eax
push dword format
call [printf]
add esp, 4*2

mov eax,0
mov dx, word[esi] 
mov al, dh
and al,0Fh  
xlat  

push eax
push dword format
call [printf]
add esp, 4*2


mov eax,0
mov dx, word[esi]
mov al, dl
shr al, 4
xlat  

push eax
push dword format
call [printf]
add esp, 4*2 

mov eax, 0
mov dx, word[esi] 
mov al, dl
and al,0Fh
xlat

push eax
push dword format
call [printf]
add esp, 4*2 

push dword 10
push dword format
call [printf]
add esp, 4*2

add esi,2
inc byte[oprire]
cmp byte[oprire],ls
je iesi

jmp afisare_1
iesi :

mov esi, S
mov edi, D2
mov ecx, ls*2

repeta_1 :


mov ax, word[esi]

mov dl, al
shr dl, 4
cmp dl,10
jae nu_hexa
mov dl, al
and dl, 0Fh
cmp dl,10
jae nu_hexa

mov dl, ah
shr dl, 4
cmp dl,10
jae nu_hexa
mov dl, ah
and dl, 0Fh
cmp dl,10
jae nu_hexa

mov word[edi],ax
add edi, 2

nu_hexa :
add esi, 2

loop repeta_1

mov ecx, ls*2
mov esi, D2
afisare_2 :

push ecx

mov eax, 0
mov ax, word[esi]
push dword eax
push dword format_2
call [printf]
add esp, 4*2

add esi, 2

pop ecx
loop afisare_2

mov ecx, ls
mov esi, D1
repeta_la_infinit :

mov ax, word[esi]
cmp ax, word[maxim]
jna nu_schimba

mov word[maxim],ax

nu_schimba :
add esi, 2

loop repeta_la_infinit

mov eax, 0
mov ax, word[maxim]
push eax
push dword format_2
call [printf]
add esp, 4*2

mov ecx, ls*2
mov esi, D2

peste_infint :

mov ax, word[esi]
cmp ax, word[maxim]
jne nu_creste

inc byte[contor]

nu_creste :
add esi, 2
loop peste_infint

mov eax, 0
mov al, byte[contor]
push eax
push dword format_2
call [printf]
add esp, 4*2

push dword 0
call [exit]
