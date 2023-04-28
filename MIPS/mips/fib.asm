.data
	msg1: .asciiz "enter the value of n: "
	msg2: .asciiz "The fibbonacci numbers are:\n"
	space: .asciiz " "
	nl: .asciiz "\n"
	
.text
.globl main

main:
	li $t0,1 #a
	li $t1,1 #b
	li $s0,0 #n
	
	
	
	li $v0,4
	la $a0,msg1
	syscall
	
	li $v0,5
	syscall
	move $s0,$v0
	
	
	li $v0,4
	la $a0,msg2
	syscall
	
	move $a0,$t0
		li $v0,1
		syscall
		
		li $v0,4
		la $a0,space
		syscall
		
	move $a0,$t1
		li $v0,1
		syscall
		
		li $v0,4
		la $a0,space
		syscall
	
	
	li $s1,3 #i
	
	while:
		bgt $s1,$s0,exit
		li $t2,0 #t2=temp
		move $t2,$t1
		add $t1,$t1,$t0
		move $t0,$t2
		move $a0,$t1
		li $v0,1
		syscall
		
		li $v0,4
		la $a0,space
		syscall
		
		addi $s1,$s1,1
		j while
		
	exit:
		li $v0,10
		syscall
