# write a spim program to read n numbers and find the sum of odd numbers and that of even numbers

.text
.globl main

main:
	li $v0,4
	la $a0,msg1
	syscall
	
	li $v0,5
	syscall 
	move $t0,$v0 #stores the number n
	
	addi $t0,$t0,1
	
	li $v0,4
	la $a0,msg2
	syscall
	
	li $v0,4
	la $a0,nl
	syscall
	
	li $t6,0 # for storing the sum 
	li $t4,0 # for scanning the number
	li $t1,0 # counter
	li $t2,2
	
	loop:
		addi $t1,$t1,1
		beq $t1,$t0,exit
		
		li $v0,5
		syscall
		move $t4,$v0
		
		add $t6,$t6,$t4
		j loop
		
	exit:
		li $v0,4
		la $a0,msg3
		syscall
		
		mflo $t3
		div $t6,$t0
		
		li $v0,1
		move $a0,$t6
		syscall
		
		
	
	
	li $v0,10
	syscall
	
.data
	msg1: .asciiz "Enter the number n: "
	msg2: .asciiz "start entering the numbers serially: "
	msg3: .asciiz "The mean of numbers is: "
	
	hi: .asciiz "H"
	nl: .asciiz "\n"
