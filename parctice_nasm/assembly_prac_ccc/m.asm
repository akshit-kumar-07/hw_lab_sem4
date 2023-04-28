section .data
	msg1 db "Enter the number of rows: ",0Ah
	len1 equ $-msg1
	msg2 db "Enter the number of coloumns:",0Ah
	len2 equ $-msg2
	msg3 db "Enter the elements of matrix serially:",0Ah
	len3 equ $-msg3
	msg4 db "The matrix you have entered is:",0Ah
	len4 equ $-msg4
	newline db 10
	tab db 32
	zero db "0"
	len_zero equ $-zero
section .bss
	num: resw 1
	;temp: resb 1
	count: resb 1
	mat: resw 100
	temp: resb 1
	m: resd 1
	n: resd 1
	i: resw 1
	j: resw 1
	k: resw 1
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
	
	pusha
	mov ebx,mat
	mov eax,0
	call read_matrix
	popa
	
	mov eax,4
	mov ebx,1
	mov ecx,msg4
	mov edx,len4
	int 80h
	
	pusha
	mov ebx,mat
	mov eax,0
	call print_matrix
	popa
	
	exit:
	    mov eax,1
	    mov ebx,0
	    int 80h
	
	
	;num=0
	;while(temp!='\n')
	;	read(temp)
	;	num= num*10 +temp
	
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
	;	num=num/10
	;	
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
			mov bx,10
			mov dx,0
			div bx
			push dx
			mov word[num],ax
			inc byte[count]
			jmp loop2
			
		loop3:
			cmp byte[count],0
			je end_print
			pop dx
			add dx,30h
			mov bh,0
			mov bl,dl
			mov byte[temp],bl
			mov eax,4
			mov ebx,1
			mov ecx,temp
			mov edx,1
			int 80h
			dec byte[count]
			jmp loop3
		
		end_print:
			popa
			ret
	
	;i=0;j=0
	;while(i<m)
	;	while(j<n)
	;		read(num)
	;		*(*(mat+i)+j)=num
	;		j++
	;	i++
		
	read_matrix:
		pusha
		mov ax,word[m]
		mov bx,word[n]
		mul bx
		mov word[k],ax
		popa
		read_loop:
			cmp ax,word[k]
			je end_read_matrix
			call read_num
			mov cx,word[num]
			mov word[ebx+2*eax],cx
			inc ax
			jmp read_loop
		end_read_matrix:
			ret
	
	;i=0;j=0
	;while(i<m)
	;	while j<n
	;		print *(arr+i+j)
	;		print ' '
	;		j++
	;	print('\n')
	;	i++		
	
	print_matrix:
		mov word[i],0
		mov word[j],0
		outer_loop:
			mov word[j],0
			inner_loop:
				mov cx,word[ebx+2*eax]
				mov word[num],cx
				cmp word[num],0
				jne con
				
				pusha
				mov eax,4
				mov ebx,1
				mov ecx,zero
				mov edx,len_zero
				int 80h
				popa	
				
				con:
				call print_num
				
				pusha
				mov eax,4
				mov ebx,1
				mov ecx,tab
				mov edx,1
				int 80h
				popa
				
				inc word[j]
				inc eax
				
				mov cx,word[n]
				cmp word[j],cx
				je outer_loop_cnt
				jmp inner_loop
			
			outer_loop_cnt:
			pusha
			mov eax,4
			mov ebx,1
			mov ecx,newline
			mov edx,1
			int 80h
			popa
			
			inc word[i]
			mov cx,word[i]
			cmp	cx,word[m]
			je end_print_matrix
			jmp outer_loop
			
		end_print_matrix:
			ret
		
	
	
	
