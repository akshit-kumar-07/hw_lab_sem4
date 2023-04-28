section .text
	msg1 db "Enter the number of elements in the array",0Ah
	len1 equ $-msg1
	msg2 db "Enter the elements serially",0Ah
	len2 equ $-msg2
	msg3 db "Enter the number you're looking for:",0Ah
	len3 equ $-msg3
	msg4 db "The number is found at the index:",0Ah
	len4 equ $-msg4
	msg5 db "Sorry,the number you're looking for is not found",0Ah
	len5 equ $-msg5
	zero db "0"
	len_zero equ $-zero
	newline db 10
	
section .bss
	temp: resb 1
	num: resw 1
	count: resb 1
	sum: resw 1
	n: resd 1
	num1: resw 1
	num2: resw 1
	arr: resw 50
	flag: resb 1
	x: resw 1
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
	
	pusha
	mov ebx,arr
	mov eax,0
	call read_array
	popa
	
	mov eax,4
	mov ebx,1
	mov ecx,msg3
	mov edx,len3
	int 80h
	
	call read_num
	mov cx,word[num]
	mov word[x],cx
	
	;flag=0,i=0,x
	;while(i!=n)
	;	if arr[i]==x
	;		flag=1
	;		break
	;	i++
	;
	
	
	
	pusha
	mov ebx,arr
	mov eax,0
	search:
		cmp eax,dword[n]
		je not_found
		mov cx,word[ebx+2*eax]
		cmp cx,word[x]
		je found
		inc eax
		jmp search
	found:
		mov eax,4
		mov ebx,1
		mov ecx,msg4
		mov edx,len4
		int 80h
		
		mov dword[num],eax
		call print_num
		jmp exit
	not_found:
		mov eax,4
		mov ebx,1
		mov ecx,msg5
		mov edx,len5
		int 80h
	popa
	
	
	exit:
		mov eax,1
		mov ebx,0
		int 80h
		
	;num=0
	;while(temp!='\n')
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
			
			sub byte[temp],30h
			
			mov ax,word[num]
			mov bx,10
			mul bx
			add al,byte[temp]
			mov word[num],ax
			jmp loop1
		
		end_read:
			popa
			ret
			
	;count=0
	;while(num!=0)
	;	temp=num%10
	;	push(temp)
	;	count++
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
			mov dx,0
			mov ax,word[num]
			mov bx,10
			div bx
			push dx
			inc byte[count]
			mov word[num],ax
			jmp loop2
			
		loop3:
			cmp byte[count],0
			je end_print
			dec byte[count]
			pop dx
			mov bh,0
			mov bl,dl
			add bl,30h
			mov byte[temp],bl
			cmp byte[temp],30h
			jmp pz
			mov eax,4
			mov ebx,1
			mov ecx,temp
			mov edx,1
			int 80h
			jmp loop3
			pz:
			mov eax,4
			mov ebx,1
			mov ecx,zero
			mov edx,len_zero
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
	;while(i!=n)
	;	read(num)
	;	*(arr+i)=num
	;	i++
	
	read_array:
		loop_read:
			cmp eax,dword[n]
			je end_array_read
			call read_num
			mov cx,word[num]
			mov word[ebx+2*eax],cx
			inc eax
			jmp loop_read
		end_array_read:
			ret
			
	;i=0
	;while(i!=n)
	;	num=*(arr+i)
	;	print(num)
	;	i++
			
	print_array:
		loop_print:
			cmp eax,dword[n]
			je end_array_print
			mov cx,word[ebx+2*eax]
			mov word[num],cx
			call print_num
			inc eax
			jmp loop_print
		end_array_print:
			mov eax,4
			mov ebx,1
			mov ecx,newline
			mov edx,1
			int 80h
			ret
