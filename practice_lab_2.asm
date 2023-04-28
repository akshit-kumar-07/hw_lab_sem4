1.

;Accept three 2-digit numbers and find the greatest among them. what is the error in the code?
section .data
	space: db ' '
	newline: db 10
	msg1: db 'Enter the number of integers: ',0
	len1: equ $-msg1
	msg2: db 'Enter the numbers serially',0
	len2: equ $-msg2
	msg3: db 'The greatest integer is: ',0
	len3: equ $-msg3
section .bss
	num: resw 1
	temp: resw 1
	cntr: resw 1
	num1: resw 1
	num2: resw 1
	n: resd 10
	arr: resw 50
	count: resb 10
	
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
	
	mov eax,4
	mov ebx,1
	mov ecx,newline
	mov edx,1
	int 80h
	
	mov ebx,arr
	mov eax,0
	call read_array
	
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
	
	mov ebx,arr
	mov eax,0
	mov dx,0
	loop1:
		cmp eax,dword[n]
		je end_loop1
		mov cx,word[ebx+2*eax]
		inc eax
		cmp cx,dx
		jng loop1
		mov dx,cx
		jmp loop1
		
	end_loop1:
		mov word[num],dx
		call print_num
		
	
	exit:
		mov eax,1
		mov ebx,0
		int 80h
		
read_array:
	pusha
	read_loop:
		cmp eax,dword[n]
		je read_end
		call read_num
		mov cx,word[num]
		mov word[ebx+2*eax],cx
		inc eax
		jmp read_loop
	read_end:
		popa
		ret
		
print_array:
	pusha
	print_loop:
		cmp eax,dword[n]
		je print_end
		mov cx,word[ebx+2*eax]
		mov word[num],cx
		call print_num
		inc eax
		jmp print_loop
	print_end:
		popa
		ret








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

	
		

2.

section .data
	newline:db 10
	msg1: db 'Enter the number: ',0
	len1: equ $-msg1
	msg2: db 'The square of the number is: ',0
	len2: equ $-msg2
section .bss
	num1:resw 10
	num2 resw 10
	temp:resb 10
	num:resw 10
	nod:resb 10
	count:resb 10

section .text
	global _start

_start:
	mov eax,4
	mov ebx,1
	mov ecx,msg1
	mov edx,len1
	int 80h
	
	call read_num
	mov eax,dword[num]
	mul eax
	mov dword[num],eax
	
	mov eax,4
	mov ebx,1
	mov ecx,msg2
	mov edx,len2
	int 80h
	
	call print_num
	_end:
		mov eax,1
		mov ebx,0
		int 80h
	;call print_num

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

	exit:
		mov eax,1
		mov ebx,0
		int 80h
		
		
		
3. 

section .data
	newline:db 10
	msg1: db 'Enter the first 32bit number: ',0
	len1: equ $-msg1
	msg2: db 'Enter the second 32bit number: ',0
	len2: equ $-msg2
	msg3: db 'The sum of the two numbers is: ',0
	len3: equ $-msg3
section .bss
	num1:resd 100
	num2 resd 100
	temp:resd 100
	num:resd 100
	nod:resd 100
	count:resd 100

section .text
	global _start

_start:

	mov eax,4
	mov ebx,1
	mov ecx,msg1
	mov edx,len1
	int 80h

	call read_num
	mov ecx,dword[num]
	mov dword[num1],ecx
	
	mov eax,4
	mov ebx,1
	mov ecx,msg2
	mov edx,len2
	int 80h
	
	call read_num
	mov ecx,dword[num]
	mov dword[num2],ecx
	mov eax,dword[num1]
	mov ebx,dword[num2]
	add eax,ebx
	mov dword[num],eax
	
	mov eax,4
	mov ebx,1
	mov ecx,msg3
	mov edx,len3
	int 80h
	
	call print_num
	
	_end:
		mov eax,1
		mov ebx,0
		int 80h
	;call print_num

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

	exit:
		mov eax,1
		mov ebx,0
		int 80h
		
		
		
4.

section .data
    test_word dw 0x1234
	msg1: db 'The system is little endian',0
	len1: equ $-msg1
	msg2: db 'The system is big endian',0
	len2: equ $-msg2
section .text
    global _start

_start:
    mov eax, dword[test_word]
    xor edx, edx
    mov dl, al
    cmp dl, 0x12
    je big_endian
    mov eax,4
    mov ebx,1
    mov ecx,msg1
    mov edx,len1
    int 80h
    jmp end

big_endian:
    mov eax,4
    mov ebx,1
    mov ecx,msg2
    mov edx,len2
    int 80h
    jmp end
    

end:
    mov eax,1
    mov ebx,0
    int 80h




5.

section .data
space:db ' '
newline:db 10
msg1: db 'Enter the number of integers: ',0
len1: equ $-msg1
msg2: db 'Enter the inetgers serially: ',0
len2: equ $-msg2
msg3: db 'The mean of the numbers is: ',0
len3: equ $-msg3
msg4: db 'The mean of the numbers is: 0',0
len4: equ $-msg4

section .bss
nod: resb 1
num: resw 1
temp: resb 1
counter: resw 1
num1: resw 1
num2: resw 1
n: resd 10
array: resw 50
matrix: resw 1
count: resb 10


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


mov eax,4
mov ebx,1
mov ecx,newline
mov edx,1
int 80h

mov ebx,array
mov eax,0
call read_array


mov ebx,array
mov eax,0
mov dx,0

loop1:
mov cx,word[ebx+2*eax]
add dx,cx
inc eax
cmp eax,dword[n]
jb loop1

cmp dx,0
je print_zero

mov ax,dx
mov bx,word[n]
mov dx,0
div bx
mov word[num],ax

mov eax,4
mov ebx,1
mov ecx,msg3
mov edx,len3
int 80h

call print_num

mov eax,4
mov ebx,1
mov ecx,newline
mov edx,1
int 80h
mov eax,0
mov ebx,array
;call print_array



exit:
mov eax,1
mov ebx,0
int 80h	

print_zero:
	mov eax,4
	mov ebx,1
	mov ecx,msg4
	mov edx,len4
	int 80h
	jmp exit

read_array:
	pusha
	read_loop:
		cmp eax,dword[n]
		je read_end
		call read_num
		mov cx,word[num]
		mov word[ebx+2*eax],cx
		inc eax
		jmp read_loop
	read_end:
		popa
		ret
		
print_array:
	pusha
	print_loop:
		cmp eax,dword[n]
		je print_end
		mov cx,word[ebx+2*eax]
		mov word[num],cx
		call print_num
		inc eax
		jmp print_loop
	print_end:
		popa
		ret








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

