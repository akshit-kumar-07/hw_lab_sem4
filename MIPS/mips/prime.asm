.data
	msg1: .asciiz "Enter the first number: "
	msg2: .asciiz "Enter the seconnd number: "
	msg3: .asciiz "The first number is prime\n"
	msg4: .asciiz "The first number is not prime\n"
	msg5: .asciiz "The second number is prime\n"
	msg6: .asciiz "The second number is not prime\n"
	space: .asciiz " "
	nl: .asciiz "\n"
	
.text
.globl main

main:
	
	li $v0,4
	la $a0,msg1
	syscall
	
	li $v0,5
	syscall
	move $t0,$v0 #t0=a
	
	li $v0,4
	la $a0,msg2
	syscall
	
	li $v0,5
	syscall
	move $t1,$v0 #t1=b
	
	li $t2,2
	check_1:
		beq $t2,$t0,is_prime_1
		li $t3,0
		rem $t3,$t0,$t2
		beq $t3,$0,is_com_1
		addi $t2,$t2,1
		j check_1
	
	li $t2,2	
	check_2:
		beq $t2,$t1,is_prime_2
		li $t3,0
		rem $t3,$t1,$t2
		beq $t3,$0,is_com_2
		addi $t2,$t2,1
		j check_2
		
	is_prime_1:
		li $v0,4
		la $a0,msg3
		syscall
		j exit
	is_prime_2:
		li $v0,4
		la $a0,msg4
		syscall
		j exit
	is_com_1:
		li $v0,4
		la $a0,msg5
		syscall
		j exit
	is_com_2:
		li $v0,4
		la $a0,msg6
		syscall
	exit:
		li $v0,10
		syscall
		
