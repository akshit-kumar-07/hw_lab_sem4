section .text
	msg1 db "Enter the number of elements in the array",0Ah
	len1 equ $-msg1
	msg2 db "Enter the elements serially",0Ah
	len2 equ $-msg2
	msg4 db "The sorted array is:",0Ah
	len4 equ $-msg4
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
	high: resw 1
	low: resw 1
	mid: resw 1
	i: resw 1
	j: resw 1
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
	mov ecx,msg4
	mov edx,len4
	int 80h
	
	pusha
	mov ebx,arr
	mov eax,0
	mov ecx,0
	call sort
	popa
	
	pusha
	mov ebx,arr
	mov eax,0
	call print_array
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
	
	;i=0;j=0;
	;for(i=0;i<n-1;i++)
	;	for(j=0;j<n-i-1;j++)
	;		swap(arr[j],arr[j+1])
	
	sort:
		mov dx,word[n]
		dec dx
		mov word[i],dx
		
		outer_loop:
			
			cmp eax,dword[i]
			jl con
			ret
			
			con:
			
			mov dx,word[n]
			sub dx,ax
			dec dx
			mov word[j],dx
			inner_loop:
				
				cmp ecx,dword[j]
				je outer_loop	
				
				mov dx,word[ebx+2*ecx]
				mov word[num1],dx
				
				mov dx,word[ebx+2*ecx+2]
				mov word[num2],dx
				
				mov dx,word[num2]
				mov word[ebx+2*ecx],dx
				
				mov dx,word[num1]
				mov word[ebx+2*ecx+2],dx
				
				inc ecx
				jmp inner_loop
			inc eax
			jmp outer_loop
			
	
	
	
	
	
	
	
