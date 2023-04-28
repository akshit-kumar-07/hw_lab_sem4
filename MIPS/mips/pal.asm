.data
	str: .space 1000
	msg1: .asciiz "Enter the string:\n"
	yes: .asciiz "The string is a palindrome\n"
	no: .asciiz "the string is not a palindrome\n"
	lent: .asciiz "the length of the strings is: "
	last: .asciiz "the last byte is: "
	bt: .space 1
	nl: .asciiz "\n"
.text
.globl main

main:
	
	li $v0,4
	la $a0,msg1
	syscall
	
	la $a0,str
	li $v0,8
	syscall
	
	li $t0,0
	len:
		lbu $t1,str($t0)
		beqz $t1,end_len
		addi $t0,$t0,1
		j len
	end_len:
	addi $t0,$t0,-2
	
	move $t8,$t0 #stores the end pointer
	move $t9,$0 #stores the front pointer
	
	addi $t0,$t0,1
	
	loop_pal:
		bgt $t9,$t8,post
		lbu $t6,str($t8)
		lbu $t7,str($t9)
		bne $t6,$t7,negt
		addi $t8,$t8,-1
		addi $t9,$t9,1
		j loop_pal
	post:
		li $v0,4
		la $a0,yes
		syscall
		j exit
		
	negt:
		li $v0,4
		la $a0,no
		syscall
	
	exit:
		li $v0,10
		syscall
	
