bits 32
global start
extern exit, printf, scanf
import exit msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll

segment data use32 class=data public

N resd 1 ; max 10

sir resd 10 ; rezervam spatiu pentru a stoca cele N numere citite
rezultat resd 10 ; rezervam spatiu pentru a forma sirul rezultat

numar dd 0
index dd 0
suma dd 0

format_fara_semn db '%u',0 ; lucram cu numere fara semn
format_sir_de_caractere db '%s',0
mesaj_1 db 'Numarul N citit este : ',0
mesaj_0 db 'Dati o valoare pentru N : ',0
mesaj_2 db '>> ',0
linie db 10,0
spatiu db ' ',0




segment code use32 class=data public
start :

push dword mesaj_0
push format_sir_de_caractere
call [printf]
add esp, 4*2

push dword N
push dword format_fara_semn
call [scanf]
add esp, 4*2

push dword mesaj_1
push dword format_sir_de_caractere
call [printf]
add esp, 4*2

push dword [N]
push dword format_fara_semn
call [printf]
add esp, 4*2

push dword linie
push dword format_sir_de_caractere
call [printf]
add esp, 4*2


mov esi, 0
push esi

citeste :

push dword mesaj_2
push dword format_sir_de_caractere
call [printf]
add esp, 4*2

push dword numar
push dword format_fara_semn
call [scanf]
add esp, 4*2

pop esi

mov eax, dword[numar]
mov dword[sir+esi], eax

add esi, 4
push esi

add dword[index], 1
mov ebx, dword[N]
cmp dword[index], ebx
jne citeste


mov dword[index],0
mov esi, 0
push esi


afiseaza_1 :

pop esi
mov eax,[sir+esi]
add esi, 4
push esi

push eax
push format_fara_semn
call [printf]
add esp, 4*2

push dword spatiu
push dword format_sir_de_caractere
call [printf]
add esp, 4*2


add dword[index], 1
mov ebx, dword[N]
cmp dword[index], ebx
jne afiseaza_1


mov esi, sir
mov edi, 0
mov ecx, dword[N]
mov ebx,10

repeta :

lodsd

ciclu :
mov edx,0
div ebx

test edx,1
jnz impar

add dword[suma],edx

impar :

cmp eax,0
jne ciclu

mov eax, dword[suma]
mov [rezultat+edi], eax
add edi, 4
mov dword[suma], 0

loop repeta

push dword spatiu
push dword format_sir_de_caractere
call [printf]
add esp, 4*2


mov dword[index],0
mov esi, 0
push esi

afiseaza_2 :

pop esi
mov eax,[rezultat+esi]
add esi, 4
push esi

push eax
push format_fara_semn
call [printf]
add esp, 4*2

push dword spatiu
push dword format_sir_de_caractere
call [printf]
add esp, 4*2


add dword[index], 1
mov ebx, dword[N]
cmp dword[index], ebx
jne afiseaza_2


push dword 0
call [exit]
