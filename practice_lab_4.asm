Q1:
	
section .text
	msg1 db "Enter the number of elements in the first array",0Ah
	len1 equ $-msg1
	msg2 db "Enter the number of elements in the second array:",0Ah
	len2 equ $-msg2
	msg3 db "Enter the eelemnts of array 1 serially:",0Ah
	len3 equ $-msg3
	msg4 db "Enter the elemnts of array 2 serially:",0Ah
	len4 equ $-msg4
	msg5 db "The elements of the array are:",0Ah
	len5 equ $-msg5
	newline db 10
	
section .bss
	num1: resw 10
	num2: resw 10
	num: resw 10
	sum: resw 10
	count: resb 10
	temp: resb 10
	;arr: resw 100
	n: resd 1
	m: resd 1
	i: resw 1
	j: resw 1
	k: resd 1
	;k: resb 10
	;m: resw 1
	;n: resw 1
	arr1: resw 100
	arr2: resw 100
	arr: resw 200
	
section .text
	global _start
	
_start:
	mov eax,4
	mov ebx,1
	mov ecx,msg1
	mov edx,len1
	
	int 80h
	
	call read_num
	mov cx,word[num]
	mov word[m],cx
	
	mov eax,4
	mov ebx,1
	mov ecx,msg2
	mov edx,len2
	
	int 80h
	
	call read_num
	mov cx,word[num]
	mov word[n],cx
	
	mov eax,4
	mov ebx,1
	mov ecx,msg3
	mov edx,len3
	int 80h
	
	mov ebx,arr1
	mov eax,0
	call read_array1
	
	mov eax,4
	mov ebx,1
	mov ecx,msg4
	mov edx,len4
	int 80h
	
	mov ebx,arr2
	mov eax,0
	call read_array2
	
	mov word[i],0
	mov word[j],0
	mov dword[k],0
	
	mov eax,arr1
	mov ebx,arr2
	mov edx,arr
	
	merge:
		mov cx,0
		mov cx,word[i]
		cmp cx,word[m]
		je arr2_only
		
		mov cx,0
		mov cx,word[j]
		cmp cx,word[n]
		je arr1_only
		
		inc dword[k]
		
		mov cx,word[eax]
		cmp cx,word[ebx]
		jle merge_arr1
		merge_arr2:
			mov cx,word[ebx]
			mov word[edx],cx
			add edx,2
			add ebx,2
			inc word[j]
			jmp merge
		merge_arr1:
			mov cx,word[eax]
			mov word[edx],cx
			add edx,2
			add eax,2
			inc word[i]
			jmp merge
		arr1_only:
			mov cx,word[i]
			cmp cx,word[m]
			je res
			mov cx,word[eax]
			mov word[edx],cx
			add edx,2
			add eax,2
			inc word[i]
			jmp arr1_only
		arr2_only:
			mov cx,word[j]
			cmp cx,word[n]
			je res
			mov cx,word[ebx]
			mov word[edx],cx
			add edx,2
			add ebx,2
			inc word[j]
			jmp arr2_only
		res:
			mov eax,4
			mov ebx,1
			mov ecx,msg5
			mov edx,len5
			int 80h
			
			inc dword[k]
			mov ebx,arr
			mov eax,0
			call print_array
	exit:
		mov eax,1
		mov ebx,0
		int 80h
		
read_num:
pusha
mov word[num], 0
loop_read:
mov eax, 3
mov ebx, 0
mov ecx, temp
mov edx, 1
int 80h

cmp byte[temp], 10
je end_read
mov ax, word[num]
mov bx, 10
mul bx
mov bl, byte[temp]
sub bl, 30h
mov bh, 0
add ax, bx
mov word[num], ax
jmp loop_read

end_read:
popa
ret

print_num:
mov byte[count],0
pusha
extract_no:
cmp word[num], 0
je print_no
inc byte[count]
mov dx, 0
mov ax, word[num]
mov bx, 10
div bx
push dx
mov word[num], ax
jmp extract_no
print_no:
cmp byte[count], 0
je end_print
dec byte[count]
pop dx
mov byte[temp], dl
add byte[temp], 30h
mov eax, 4
mov ebx, 1
mov ecx, temp
mov edx, 1
int 80h
jmp print_no
end_print:
mov eax,4
mov ebx,1
mov ecx,newline
mov edx,1
int 80h
popa
ret

read_array1:
pusha
read_loop1:
cmp eax,dword[m]
je endread11
call read_num
mov cx,word[num]
mov word[ebx+2*eax],cx
inc eax
jmp read_loop1

endread11:
popa
ret

read_array2:
pusha
read_loop2:
cmp eax,dword[n]
je endread12
call read_num
mov cx,word[num]
mov word[ebx+2*eax],cx
inc eax
jmp read_loop2

endread12:
popa
ret

print_array:
pusha
printloop:
cmp eax,dword[k]
je end_print1
mov cx,word[ebx+2*eax]
mov word[num],cx
call print_num
inc eax
jmp printloop

end_print1:
popa
ret



Q2:


section .bss
num: resw 1 ;For storing a number, to be read of printed....
nod: resb 1 ;For storing the number of digits....
temp: resb 2
matrix1: resw 200
m: resw 1
n: resw 1
i: resd 1
j: resd 1
k: resw 1


section .data
msg1: db "Enter the number of rows in the matrix : "
msg_size1: equ $-msg1
msg2: db "Enter the elements one by one(row by row) for matrix 1: ",0Ah
msg_size2: equ $-msg2
msg: db "Enter the elements one by one(row by row) for matrix 2: ",0Ah
msg_size: equ $-msg
msg3: db "Enter the number of columns in the matrix : "
msg_size3: equ $-msg3
msg4: db "The transpose of the matrix is:",0Ah
len4: equ $-msg4
tab: db 9 ;ASCII for vertical tab
new_line: db 10 ;ASCII for new line
z: db "0"
lenz: equ $-z


section .text
global _start


_start:
mov eax, 4
mov ebx, 1
mov ecx, msg1
mov edx, msg_size1
int 80h
mov ecx, 0
;calling sub function read num to read a number
call read_num
mov cx, word[num]


mov word[m], cx
mov eax, 4
mov ebx, 1
mov ecx, msg3
mov edx, msg_size3
int 80h
mov ecx, 0
call read_num
mov cx, word[num]
mov word[n], cx

mov eax, 4
mov ebx, 1
mov ecx, msg2
mov edx, msg_size2
int 80h
;Reading each element of the matrix........


mov eax, 0
mov ebx, matrix1
mov word[i], 0
mov word[j], 0
i_loop:
mov word[j], 0
j_loop:
call read_num
mov dx , word[num]
;eax will contain the array index and each element is 2 bytes(1 word) long
mov word[ebx + 2 * eax], dx
inc eax ;Incrementing array index by one....
inc word[j]
mov cx, word[j]
cmp cx, word[n]
jb j_loop
inc word[i]
mov cx, word[i]
cmp cx, word[m]
jb i_loop



mov eax, 4
mov ebx, 1
mov ecx, msg4
mov edx, len4
int 80h


mov eax,0
mov ebx, matrix1
mov word[i], 0
mov word[j], 0

i_loop2:
mov word[j], 0
mov ax,word[i]

j_loop2:

mov dx, word[ebx + 2 * eax] ;
mov word[num] , dx
add ax,word[n]
dec ax
cmp word[num],0
jne cnt

p_z:
pusha
mov eax,4
mov ebx,1
mov ecx,z
mov edx,lenz
int 80h
popa

cnt:
call print_num
;Printing a space after each element.....

pusha
mov eax, 4
mov ebx, 1
mov ecx, tab
mov edx, 1
int 80h

popa

inc eax
inc word[j]
mov cx, word[j]
cmp cx, word[m]
jb j_loop2

pusha

mov eax, 4
mov ebx, 1
mov ecx, new_line
mov edx, 1
int 80h

popa

inc word[i]
mov cx, word[i]
cmp cx, word[n]
jb i_loop2

;Exit System Call.....
exit:
mov eax, 1
mov ebx, 0
int 80h
;Function to read a number from console and to store that in num


read_num:
pusha
mov word[num], 0
loop_read:
mov eax, 3
mov ebx, 0
mov ecx, temp
mov edx, 1
int 80h
cmp byte[temp], 10
je end_read
mov ax, word[num]
mov bx, 10
mul bx
mov bl, byte[temp]
sub bl, 30h
mov bh, 0
add ax, bx
mov word[num], ax
jmp loop_read
end_read:
popa
ret
;Function to print any number stored in num...


print_num:
pusha
extract_no:
cmp word[num], 0
je print_no
inc byte[nod]
mov dx, 0
mov ax, word[num]
mov bx, 10
div bx
push dx
mov word[num], ax
jmp extract_no
print_no:
cmp byte[nod], 0
je end_print
dec byte[nod]
pop dx
mov byte[temp], dl
add byte[temp], 30h
mov eax, 4
mov ebx, 1
mov ecx, temp
mov edx, 1
int 80h
jmp print_no

end_print:
popa
ret


Q3:

section .bss
num: resw 1 ;For storing a number, to be read of printed....
nod: resb 1 ;For storing the number of digits....
temp: resb 2
matrix1: resw 200
m: resw 1
n: resw 1
i: resd 1
j: resd 1
k: resw 1
sum: resw 10

section .data
msg1: db "Enter the number of rows in the matrix : "
msg_size1: equ $-msg1
msg2: db "Enter the elements one by one(row by row) for matrix 1: ",0Ah
msg_size2: equ $-msg2
msg: db "Enter the elements one by one(row by row) for matrix 2: ",0Ah
msg_size: equ $-msg
msg3: db "Enter the number of columns in the matrix : "
msg_size3: equ $-msg3
msg4: db "The sum of squares of the elemnts in the principle diagonal is:",0Ah
len4: equ $-msg4
tab: db 9 ;ASCII for vertical tab
new_line: db 10 ;ASCII for new line
z: db "0"
lenz: equ $-z
newline db 10

section .text
global _start


_start:
mov eax, 4
mov ebx, 1
mov ecx, msg1
mov edx, msg_size1
int 80h
mov ecx, 0
;calling sub function read num to read a number
call read_num
mov cx, word[num]


mov word[m], cx
mov eax, 4
mov ebx, 1
mov ecx, msg3
mov edx, msg_size3
int 80h
mov ecx, 0
call read_num
mov cx, word[num]
mov word[n], cx

mov eax, 4
mov ebx, 1
mov ecx, msg2
mov edx, msg_size2
int 80h
;Reading each element of the matrix........


mov eax, 0
mov ebx, matrix1
mov word[i], 0
mov word[j], 0

i_loop:
mov word[j], 0

j_loop:
call read_num
mov dx , word[num]

mov word[ebx + 2 * eax], dx

inc eax ;Incrementing array index by one....
inc word[j]
mov cx, word[j]
cmp cx, word[n]
jb j_loop

inc word[i]
mov cx, word[i]
cmp cx, word[m]
jb i_loop

mov ax,word[n]
mul ax
mov dx,ax

mov ebx,matrix1
mov eax,0
mov word[sum],0
solve:
	cmp ax,dx
	jge res
	pusha
	mov ax,word[ebx+2*eax]
	mul ax
	add ax,word[sum]
	mov word[sum],ax
	mov word[num],ax
	call print_num
	pusha
	mov eax,4
	mov ebx,1
	mov ecx,newline
	mov edx,1
	int 80h
	popa
	popa
	add ax,word[n]
	inc ax
	jmp solve
	
res:
	mov eax,4
	mov ebx,1
	mov ecx,msg4
	mov edx,len4
	int 80h
	
	mov cx,word[sum]
	mov word[num],cx
	
	call print_num


;Exit System Call.....
exit:
mov eax, 1
mov ebx, 0
int 80h
;Function to read a number from console and to store that in num


read_num:
pusha
mov word[num], 0
loop_read:
mov eax, 3
mov ebx, 0
mov ecx, temp
mov edx, 1
int 80h
cmp byte[temp], 10
je end_read
mov ax, word[num]
mov bx, 10
mul bx
mov bl, byte[temp]
sub bl, 30h
mov bh, 0
add ax, bx
mov word[num], ax
jmp loop_read
end_read:
popa
ret
;Function to print any number stored in num...


print_num:
pusha
extract_no:
cmp word[num], 0
je print_no
inc byte[nod]
mov dx, 0
mov ax, word[num]
mov bx, 10
div bx
push dx
mov word[num], ax
jmp extract_no
print_no:
cmp byte[nod], 0
je end_print
dec byte[nod]
pop dx
mov byte[temp], dl
add byte[temp], 30h
mov eax, 4
mov ebx, 1
mov ecx, temp
mov edx, 1
int 80h
jmp print_no

end_print:
popa
ret


Q4:
	
	
section .data
	msg1 db "Enter the string:",0Ah
	len1 equ $-msg1
	msg2 db "Enter the word:",0Ah
	len2 equ $-msg2
	msg3 db "The frequency of the word is: ",0Ah
	len3 equ $-msg3
	msg4 db "Sorry, the word was not found in the given sentenc",0Ah
	len4 equ $-msg4
	newline db 10
	
section .bss
	count: resb 10
	num: resw 1
	str: resw 100
	len: resw 10
	lenw: resw 10
	temp: resb 10
	c: resb 50
	char: resb 10
	x: resw 1
	n: resw 2
	n1: resw 2
	n2: resw 2
	gc: resb 2
	nod: resw 2
	chr: resb 1
	wrd: resw 10
	rs: resw 1
	i: resd 1
section .text
	global _start
	
_start:
	mov eax,4
	mov ebx,1
	mov ecx,msg1
	mov edx,len1
	int 80h
	
	call read_string
	
	mov eax,4
	mov ebx,1
	mov ecx,msg2
	mov edx,len2
	int 80h
	
	call read_word
	
	mov word[rs],0
	call solve
	
	cmp word[rs],0
	je not_found
	
	mov eax,4
	mov ebx,1
	mov ecx,msg3
	mov edx,len3
	int 80h
	
	mov cx,word[rs]
	mov word[num],cx
	call print_num
	jmp exit
	
	not_found:
		mov eax,4
		mov ebx,1
		mov ecx,msg4
		mov edx,len4
		int 80h
	
	
	
	
	exit:
		mov eax,1
		mov ebx,0
		int 80h
	
	
	
	
	
	
	
read_num:
pusha
mov word[num], 0
loop_read:
mov eax, 3
mov ebx, 0
mov ecx, temp
mov edx, 1
int 80h
cmp byte[temp], 10
je end_read
mov ax, word[num]
mov bx, 10
mul bx
mov bl, byte[temp]
sub bl, 30h
mov bh, 0
add ax, bx
mov word[num], ax
jmp loop_read
end_read:
popa
ret
;Function to print any number stored in num...


print_num:
pusha
extract_no:
cmp word[num], 0
je print_no
inc byte[nod]
mov dx, 0
mov ax, word[num]
mov bx, 10
div bx
push dx
mov word[num], ax
jmp extract_no
print_no:
cmp byte[nod], 0
je end_print
dec byte[nod]
pop dx
mov byte[temp], dl
add byte[temp], 30h
mov eax, 4
mov ebx, 1
mov ecx, temp
mov edx, 1
int 80h
jmp print_no

end_print:
popa
ret
			
	;len=0
	;while(temp!='\n')
	;	read(temp)
	;	*(arr+len)=temp	
	;	len++
	
	read_string:	
		pusha
		mov word[len],0
		mov ebx,str
		loop4:
			push ebx
			mov eax,3
			mov ebx,0
			mov ecx,temp
			mov edx,1
			int 80h
			
			pop ebx
			
			cmp byte[temp],10
			je end_r
			
			mov al,byte[temp]
			mov byte[ebx],al
			inc ebx
			
			inc word[len]
			jmp loop4
			
		end_r:
			mov byte[ebx],0
			mov ebx,str
			popa
			ret
			
	read_word:	
		pusha
		mov word[lenw],0
		mov ebx,wrd
		loop4w:
			push ebx
			mov eax,3
			mov ebx,0
			mov ecx,temp
			mov edx,1
			int 80h
			
			pop ebx
			
			cmp byte[temp],10
			je end_rw
			
			mov al,byte[temp]
			mov byte[ebx],al
			inc ebx
			
			inc word[len]
			jmp loop4w
			
		end_rw:
			mov byte[ebx],0
			mov ebx,wrd
			popa
			ret
			
	;while(*(arr+i)!='\n')
	;	print(*(arr+i))
	;	i++
			
	print_string:
		pusha
		mov ebx,str
		loop5:
			mov al,byte[ebx]
			cmp word[len],0
			je end_p
			mov byte[temp],al
			
			push ebx
			mov eax,4
			mov ebx,1
			mov ecx,temp
			mov edx,1
			int 80h
			
			pop ebx
			inc ebx
			dec word[len]
			jmp loop5
			
		end_p:
			mov eax,4
			mov ebx,1
			mov ecx,newline
			mov edx,1
			int 80h
			
			popa
			ret
			
			
	solve:
		pusha
		mov eax,str
		mov dword[i],eax

		word_cmp:			
			mov ebx,dword[i]
			cmp byte[ebx],0
			je cmp_ret
			call str_cmp		
			jmp word_cmp

		cmp_ret:
			popa
			ret


		str_cmp:			
			pusha
			mov ebx,wrd
			mov ecx,0

			loop_cmp:
				mov eax,dword[i]
				cmp byte[ebx+ecx],0
				je end_str_cmp
				mov dl,byte[eax]
				cmp dl,byte[ebx+ecx]
				jne ret_str_cmp
				inc dword[i]
				inc ecx
				jmp loop_cmp
	
		end_str_cmp:
			cmp byte[eax],32
			je rs_inc
			cmp byte[eax],0
			je rs_inc

		ret_str_cmp:
			call move_i
			popa
			ret

		rs_inc:			
			inc word[rs]
			jmp ret_str_cmp


		move_i:			
			pusha
		
		loop_move:
			mov ebx,dword[i]
			cmp byte[ebx],32
			je end_move_i	  
			cmp byte[ebx],0
			je ret_move_i	  
			inc dword[i]
			jmp loop_move

		end_move_i:
			inc dword[i]

		ret_move_i:
			popa
			ret
			
			
Q5:


section .text
 
startnew:
 
mov ecx,newline
mov edx,1
mov eax,4
mov ebx,1
int 0x80
ret
 
convert:
mov ecx,[inp]
mov bl,10
mov al,cl
sub al,30h
 
cmp ch,10
je converted
mul bl
sub ch,30h
add al,ch
converted:
mov byte[inp],al
ret
 
takeinput:
mov ecx,msgele
mov edx,lmsgele
mov eax,4
mov ebx,1
int 0x80
 
tinput:
 
mov ecx,inp
mov edx,3
mov eax,3
mov ebx,0
int 0x80
 
 
call convert
 
ret
 
global _start
_start:
 
mov ecx,noele
mov edx,lnoele
mov eax,4
mov ebx,1
int 0x80
 
call tinput
 
mov al,byte[inp]
mov byte[n],al
 
mov ebx,0
mov bl,[n]
mov edx,0
taking:
push dx
call takeinput
mov al,byte[inp]
mov edx,0
pop dx
mov byte[input+edx],al
add dx,1
mov bl,[n]
cmp dl,bl
jne taking
 
mov edx,0
sort:
mov bl,byte[input+eax]
mov cl,byte[input+eax+1]
cmp bl,cl
jl dontswap
mov byte[input+eax+1],bl
mov byte[input+eax],cl
dontswap:
add eax,1
mov bl,byte[n]
sub bl,1
cmp al,bl
jne sort
mov eax,0
add edx,1
mov bl,byte[n]
add bl,1
cmp dl,bl
jne sort
 
call startnew
 
mov ecx,sortmsg
mov edx,lsortmsg
mov eax,4
mov ebx,1
int 0x80
 
mov edx,0
mov esi,0
 
output:
 
push 29h
mov ebx,0
mov bl,byte[input+esi]
mov ax,bx
mov ebx,0
mov bl,10
break:
mov edx,0
div bx
add dl,30h
push dx
cmp al,0
jne break
 
mov edx,0
pop dx
 
prints:
 
mov byte[printdata],dl
 
mov ecx,printdata
mov edx,1
mov eax,4
mov ebx,1
int 0x80
 
mov edx,0
pop dx
cmp dl,29h
jne prints
 
mov ecx,space
mov edx,1
mov eax,4
mov ebx,1
int 0x80
 
 
add esi,1
mov ebx,0
mov bl,byte[n]
cmp esi,ebx
jne output
 
call startnew
call startnew
 
mov eax,1
mov ebx,0
int 0x80
 
section .bss
input resb 100
 
section .data
inp dd 30h
temp db 30h
space db 32
newline db 10
n db 30h
printdata db 30h
noele db "ENTER THE NO:OF ELEMENTS ",32
lnoele equ $-noele
msgele db "ENTER THE ELEMENT ",32
lmsgele equ $-msgele
sortmsg db "SORTED LIST",10
lsortmsg equ $-sortmsg






Q6:

section .data
	msg1 db "Enter the value of n: ",0Ah
	len1 equ $-msg1
	msg2 db "Enter the value of n1: ",0Ah
	len2 equ $-msg2
	msg3 db "Enter the value of n2: ",0Ah
	len3 equ $-msg3
	msg4 db "Enter the string: ",0Ah
	len4 equ $-msg4
	msg5 db "The substring is: ",0Ah
	len5 equ $-msg5
	newline db 10
section .bss
	count: resb 10
	num: resw 1
	str: resw 100
	len: resw 10
	temp: resb 10
	c: resb 50
	char: resb 10
	x: resw 1
	n: resw 2
	n1: resw 2
	n2: resw 2
	gc: resb 2
	nod: resw 2
	chr: resb 1
section .text
	global _start
	
	
_start:

	mov eax,4
	mov ebx,1
	mov ecx,msg1
	mov edx,len1
	int 80h
	
	call read_num
	mov cx,word[num]
	mov word[n],cx
	
	
	mov eax,4
	mov ebx,1
	mov ecx,msg2
	mov edx,len2
	int 80h
	
	call read_num
	mov cx,word[num]
	mov word[n1],cx
	
	mov eax,4
	mov ebx,1
	mov ecx,msg3
	mov edx,len3
	int 80h
	
	call read_num
	mov cx,word[num]
	mov word[n2],cx
	
	mov eax,4
	mov ebx,1
	mov ecx,msg4
	mov edx,len4
	int 80h
	
	call read_string
	
	mov eax,4
	mov ebx,1
	mov ecx,msg5
	mov edx,len5
	int 80h
	
	mov cx,word[n2]
	mov dx,word[n1]
	sub cx,dx
	inc cx
	mov word[len],cx
	
	call print_string
	
	
		
	mov eax,4
	mov ebx,1
	mov ecx,newline
	mov edx,1
	int 80h
		
	
	exit:
		mov eax,1
		mov ebx,0
		int 80h
	
	
	
read_num:
pusha
mov word[num], 0
loop_read:
mov eax, 3
mov ebx, 0
mov ecx, temp
mov edx, 1
int 80h
cmp byte[temp], 10
je end_read
mov ax, word[num]
mov bx, 10
mul bx
mov bl, byte[temp]
sub bl, 30h
mov bh, 0
add ax, bx
mov word[num], ax
jmp loop_read
end_read:
popa
ret
;Function to print any number stored in num...


print_num:
pusha
extract_no:
cmp word[num], 0
je print_no
inc byte[nod]
mov dx, 0
mov ax, word[num]
mov bx, 10
div bx
push dx
mov word[num], ax
jmp extract_no
print_no:
cmp byte[nod], 0
je end_print
dec byte[nod]
pop dx
mov byte[temp], dl
add byte[temp], 30h
mov eax, 4
mov ebx, 1
mov ecx, temp
mov edx, 1
int 80h
jmp print_no

end_print:
popa
ret
			
	;len=0
	;while(temp!='\n')
	;	read(temp)
	;	*(arr+len)=temp	
	;	len++
	
	read_string:	
		pusha
		mov word[len],0
		mov ebx,str
		loop4:
			push ebx
			mov eax,3
			mov ebx,0
			mov ecx,temp
			mov edx,1
			int 80h
			
			pop ebx
			
			cmp byte[temp],10
			je end_r
			
			mov al,byte[temp]
			mov byte[ebx],al
			inc ebx
			
			inc word[len]
			jmp loop4
			
		end_r:
			mov byte[ebx],0
			mov ebx,str
			popa
			ret
			
	;while(*(arr+i)!='\n')
	;	print(*(arr+i))
	;	i++
			
	print_string:
		pusha
		mov ebx,str
		add ebx,dword[n1]
		loop5:
			mov al,byte[ebx]
			cmp word[len],0
			je end_p
			mov byte[temp],al
			
			push ebx
			mov eax,4
			mov ebx,1
			mov ecx,temp
			mov edx,1
			int 80h
			
			pop ebx
			inc ebx
			dec word[len]
			jmp loop5
			
		end_p:
			mov eax,4
			mov ebx,1
			mov ecx,newline
			mov edx,1
			int 80h
			
			popa
			ret
	
	
	





