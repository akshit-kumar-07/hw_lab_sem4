	q.2.
	
	section .data
	msg1: db 'Enter the number of elements: '
	len1: equ $-msg1
	msg2: db 'Enter the elements: '
	len2: equ $-msg2
	msg3: db 'The sum of the elements in the array is: '
	len3: equ $-msg3
	msg4: db 'The sum of the elements in the array is:0 '
	len4: equ $-msg4
	newline: db 10

section .bss
	num1: resw 10
	num2: resw 10
	num: resw 10
	sum: resw 10
	count: resb 10
	temp: resb 10
	arr: resw 100
	n: resd 100
	i: resb 10
section .text
	global _start
	
_start:
	mov eax,4
	mov ebx,1
	mov ecx,msg1
	mov edx,len1
	int 80h
	
	mov eax,4
	mov ebx,1
	mov ecx,newline
	mov edx,1
	int 80h
	
	call read_num
	
	mov cx,word[num]
	mov word[n],cx
	
	mov eax,4
	mov ebx,1
	mov ecx,msg2
	mov edx,len2
	int 80h
	
	mov eax,4
	mov ebx,1
	mov ecx,newline
	mov edx,1
	int 80h
	
	call read_arr
	
	mov ebx,arr
	mov eax,0
	mov word[sum],0
	loop6:
		cmp eax,dword[n]
		je print_sum
		mov cx,0
		mov dx,0
		mov cx,word[sum]
		mov dx,word[ebx+2*eax]
		add cx,dx
		mov word[sum],cx
		inc eax
		jmp loop6
		
	
	print_sum:
		mov ax,word[sum]
		cmp ax,0
		je print_z
		mov word[num],ax
	
		mov eax,4
		mov ebx,1
		mov ecx,msg3
		mov edx,len3
		int 80h
	
		mov eax,4
		mov ebx,1
		mov ecx,newline
		mov edx,1
		int 80h
	
		call print_num
	exit1:
		mov eax,1
		mov ebx,0
		int 80h
	print_z:
		mov eax,4
		mov ebx,1
		mov ecx,msg4
		mov edx,len4
		int 80h
	exit:
		mov eax,1
		mov ebx,0
		int 80h
	
	
	;num=0
	;while(temp1!=enter)
	;	read(temp)
	;	num=num*10+temp
		
	read_num:
		pusha
		mov word[num],0
		
		loop1:
			mov eax,3
			mov ebx,0
			mov ecx,temp
			mov edx,1
			int 80h
			
			cmp byte[temp],10
			je end_read
			
			mov ax,word[num]
			mov bx,10
			mul bx
			
			mov bl,byte[temp]
			sub bl,30h
			mov bh,0
			
			add ax,bx
			mov word[num],ax
			jmp loop1
			
		end_read:
			popa
			ret
			
	;count=0
	;while(num!=0)
	;	temp=num%10
	;	count++
	;	push(temp)
	;	num=num/10
		
	;while(count)
	;	temp=pop()
	;	print(temp)
	;	count--
		
	print_num:
		pusha
		mov byte[count],0
		loop2:
			cmp word[num],0
			je loop3
			mov dx,0
			mov ax,word[num]
			mov bx,10
			div bx
			inc byte[count]
			mov word[num],ax
			push dx
			jmp loop2
		
		loop3:
			cmp byte[count],0
			je end_print
			pop dx
			mov byte[temp],dl
			add byte[temp],30h
			dec byte[count]
			mov eax,4
			mov ebx,1
			mov ecx,temp
			mov edx,1
			int 80h
			jmp loop3
			
		end_print:
			mov eax,4
			mov ebx,1
			mov ecx,newline
			mov edx,1
			int 80h
			popa
			ret
			
	;i=0
	;while(i<n)
	;	read(num)
	;	*(arr+i)=num
	;	i++
	
	read_arr:
		pusha
		mov ebx,arr
		mov eax,0
		
		loop4:
			cmp dword[n],eax
			je end_r
			call read_num
			mov cx,word[num]
			mov word[ebx+2*eax],cx
			inc eax
			jmp loop4
			
		end_r:
			popa
			ret
			
	;i=0
	;while(i<n)
	;	num=*(arr+i)
	;	print(num)
	;	i++
	
	print_arr:
		pusha
		mov ebx,arr
		mov eax,0
		
		loop5:
			cmp dword[n],eax
			je end_p
			mov cx,word[eax+2*ebx]
			mov word[num],cx
			call print_num
			inc eax
			jmp loop5
			
		end_p:
			mov eax,4
			mov ebx,1
			mov ecx,newline
			mov edx,1
			int 80h
			popa
			ret	
				
	
	
	
	
	
	
	
	
		
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
Q 6:

section .bss
num: resw 1 ;For storing a number, to be read of printed....
nod: resb 1 ;For storing the number of digits....
temp: resb 2
matrix1: resw 200
m: resw 1
n: resw 1
i: resw 1
j: resw 1
section .data
msg1: db "Enter the number of rows in the matrix : "
msg_size1: equ $-msg1
msg2: db "Enter the elements one by one(row by row) for matrix 1: ",0Ah
msg_size2: equ $-msg2
msg: db "Enter the elements one by one(row by row) for matrix 2: ",0Ah
msg_size: equ $-msg
msg3: db "Enter the number of columns in the matrix : "
msg_size3: equ $-msg3
msg4: db "The sum of the two matrices is:",0Ah
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
mov ecx, msg
mov edx, msg_size
int 80h

mov eax, 0
mov ebx, matrix1
mov word[i], 0
mov word[j], 0
i_loopa:
mov word[j], 0
j_loopa:
call read_num
mov dx , word[num]
;eax will contain the array index and each element is 2 bytes(1 word) long
add word[ebx + 2 * eax], dx
inc eax ;Incrementing array index by one....
inc word[j]
mov cx, word[j]
cmp cx, word[n]
jb j_loopa
inc word[i]
mov cx, word[i]
cmp cx, word[m]
jb i_loopa

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
j_loop2:
;eax will contain the array index and each element is 2 bytes(1 word) long
mov dx, word[ebx + 2 * eax] ;
mov word[num] , dx
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
cmp cx, word[n]
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
cmp cx, word[m]
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



Q 10:
	
section .data
	newline: db 10
	msg1: db 'enter the string: '
	len1: equ $-msg1
	msg2: db 'enter the character: '
	len2: equ $-msg2
	msg3: db 'The number of times the chaarcter occurs in the string is: '
	len3: equ $-msg3
	msg4: db 'The number of times the chaarcter occurs in the string is:0 '
	len4: equ $-msg4
section .bss
	count: resb 10
	num: resw 10
	str: resw 100
	len: resw 10
	temp: resb 10
	c: resb 50
	char: resb 10
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
	
	mov eax,3
	mov ebx,0
	mov ecx,char
	mov edx,1
	int 80h
	
	mov ebx,str
	mov byte[c],0
	loop_s:
		cmp word[len],0
		je res
		dec word[len]
		mov al,byte[ebx]
		inc ebx
		cmp al,byte[char]
		jne loop_s
		inc byte[c]
		jmp loop_s
	res:
		mov cl,byte[c]
		cmp cl,0
		je p_z
		mov byte[num],cl
		
		mov eax,4
		mov ebx,1
		mov ecx,newline
		mov edx,1
		int 80h
		
		mov eax,4
		mov ebx,1
		mov ecx,msg3
		mov edx,len3
		int 80h
		
		call print_num		
		mov eax,1
		mov ebx,0
		int 80h
		
	p_z:
		mov eax,4
		mov ebx,1
		mov ecx,msg4
		mov edx,len4
		int 80h
		
	mov eax,1
	mov ebx,0
	int 80h
	
	
	
	
	
	
	
	;num=0
	;while(temp!=enter)
	;	read(temp)
	;	num=num*10+temp
		
	read_num:
		pusha
		mov word[num],0
		
		loop1:
			mov eax,3
			mov ebx,0
			mov ecx,temp
			mov edx,1
			int 80h
			
			cmp byte[temp],10
			je end_read
			
			mov ax,word[num]
			mov bx,10
			mul bx
			
			mov bl,byte[temp]
			mov bh,0
			sub bx,30h
			
			add ax,bx
			
			mov word[num],ax
			jmp end_read
			
		end_read:
			popa
			ret
			
	;count=0
	;while(num!=0)
	;	temp=num%10
	;	count++
	;	push(temp)
	;	num=num/10
		
	;while(count!=0)
	;	temp=pop()
	;	print(temp)
	;	count--
			
	print_num:
		pusha
		mov byte[count],0
		loop2:
			cmp word[num],0
			je loop3
			
			mov ax,word[num]
			mov dx,0
			mov bx,10
			div bx
			
			inc byte[count]
			
			push dx
			
			mov word[num],ax
			jmp loop2
			
		loop3:
			cmp byte[count],0
			je end_print
			
			pop dx
			mov byte[temp],dl
			add byte[temp],30h
			
			mov eax,4
			mov ebx,1
			mov ecx,temp
			mov edx,1
			int 80h
			
			dec byte[count]
			jmp loop3
			
		end_print:
			mov eax,4
			mov ebx,1
			mov ecx,newline
			mov edx,1
			int 80h
			
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
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
