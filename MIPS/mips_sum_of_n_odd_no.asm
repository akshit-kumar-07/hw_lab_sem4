.text
.globl main
main:

	li $v0,4
	la $a0,msg1
	syscall
	
	li $v0,5
	syscall 
	move $t0,$v0 #stores the number n
	
	mul $t0,$t0,$t0
	
	li $v0,4
	la $a0,msg2
	syscall
	
	move $a0,$t0
	li $v0,1
	syscall
	
	li $v0,10
	syscall


.data
	msg1: .asciiz "enter the value of n: "
	msg2: .asciiz "The sum of first n odd numbers upto n is : "
	nl: .asciiz "\n"
	
	
