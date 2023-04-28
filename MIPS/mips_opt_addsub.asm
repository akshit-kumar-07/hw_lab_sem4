.text
.globl main

main:
	
	li $v0,4
	la $a0,msg1
	syscall
	
	li $v0,5
	syscall
	move $t0,$v0
	
	li $v0,4
	la $a0,msg2
	syscall
	
	li $v0,5
	syscall
	move $t1,$v0
	
	li $v0,4
	la $a0,msg3
	syscall
	
	li $v0,5
	syscall
	move $t2,$v0
	
	
	beq $t2,$0,addn
	
	sub $t4,$t0,$t1
	li $v0,4
	la $a0,msg5
	syscall
	
	move $a0,$t4
	li $v0,1
	syscall
	j exit
	
	addn:
	add $t4,$t0,$t1
	li $v0,4
	la $a0,msg4
	syscall
	
	move $a0,$t4
	li $v0,1
	syscall
	
	exit:
		li $v0,10
		syscall
	
	
	
.data
	msg1: .asciiz "enter number 1: "
	msg2: .asciiz "Enter number 2: "
	msg3: .asciiz "Enter the option: "
	msg4: .asciiz "The sum is : "
	msg5: .asciiz "The difference is : "
	nl: .asciiz "\n"
