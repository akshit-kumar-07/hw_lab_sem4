section .data
	newline: equ 0Ah
	msg: db 'Yes',0
	len: equ $-msg
	msg2: db 'No',0
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
	call read_num
	mov cx,word[num]
	mov word[num1],cx
	call read_num
	mov cx,word[num]
	mov word[num2],cx
	mov ax,word[num1]
	mov bx,word[num2]
	div bx
	cmp dx,0
	je _yes
	jne _no
	_yes:
		mov eax,4
		mov ebx,1
		mov ecx,msg
		mov edx,len
		int 80h
		jmp _end
	_no:
	mov eax,4
	mov ebx,1
	mov ecx,msg2
	mov edx,len2
	int 80h
	jmp _end
	
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
