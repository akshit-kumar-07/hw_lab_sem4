.data
	msg1: .asciiz "Enter the string: "
	msg2: .asciiz "The length of the string using loop is: "
	msg3: .asciiz "The length stored in register is: "
	nl: .asciiz "\n"
	str: .space 1000
	
.text
.globl main

main:
	li $v0,4
	la $a0,msg1
	syscall
	
	li $v0,8
	la $a0,str
	syscall
	
	li $t0,0 #counter
	la $s0,str #stores the base of the string
	loop:
		lbu $t1,0($s0)
		beqz $t1,end
		addi $s0,$s0,1
		addi $t0,$t0,1
		j loop
		
	end:
		li $v0,4
		la $a0,msg2
		syscall
		
		move $a0,$t0
		li $v0,1
		syscall
		
	exit:
		li $v0,10
		syscall
		
