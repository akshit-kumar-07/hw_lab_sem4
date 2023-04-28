section .data
	msg1 db "Enter the string",0Ah
	len1 equ $-msg1
	msg2 db "The string you have entered is",0Ah
	len2 equ $-msg2
	newline db 10
	
section .bss
	temp: resb 1
	str: resw 100
	len: resw 1
	
section .text
	global _start
	
_start:
	mov eax,4
	mov ebx,1
	mov ecx,msg1
	mov edx,len1
	int 80h
	
	pusha
	mov ebx,str
	mov eax,0
	call read_string
	popa
	
	mov eax,4
	mov ebx,1
	mov ecx,msg2
	mov edx,len2
	int 80h
	
	pusha
	mov ebx,str
	mov eax,0
	call print_string
	popa
	
	exit:
		mov eax,1
		mov ebx,0
		int 80h
	
	;i=0	
	;while(temp!='\n')
	;	read(temp)	
	;;	*(str)=temp
	;	str++
	
	read_string:
		mov word[len],0
		mov byte[temp],0
		read_char:
			pusha
			mov eax,3
			mov ebx,0
			mov ecx,temp
			mov edx,1
			int 80h
			popa
			
			cmp byte[temp],10
			je end_read
			
			mov cl,byte[temp]
			mov byte[ebx],cl
			
			inc ebx
			inc word[len]
			jmp read_char
		end_read:
			ret
	
	;i=0		
	;while(i!=n)
	;	temp=*str
	;	print(temp)
	;	str++
	;	i++
	
	print_string:
		mov ax,0
		print_char:
			cmp ax,word[len]
			je end_print
			mov cl,byte[ebx]
			mov byte[temp],cl
			
			pusha
			mov eax,4
			mov ebx,1
			mov ecx,temp
			mov edx,1
			int 80h
			popa
			
			inc ebx
			inc eax
			jmp print_char
		end_print:
			mov eax,4
			mov ebx,1
			mov ecx,newline
			mov edx,1
			int 80h
			
			ret
		
	
	
	
	
	
	
	
	
	
	
	
	
