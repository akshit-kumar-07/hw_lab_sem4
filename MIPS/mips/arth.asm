.data
	msg1: .asciiz "Enter the first number: "
	msg2: .asciiz "Enter the second number: "
	msg3: .asciiz "Enter your option: "
	msg4: .asciiz "The result is: "
	msg5: .asciiz "The remainder is: "
	nl: .asciiz "\n"
	
.text
.globl main

main:
	
	li $t0,0
	li $t1,0
	li $s0,0 #for option
	li $s1,1
	li $s2,2
	li $s3,3
	li $s4,4
	
	li $v0,4
	la $a0,msg1
	syscall
	
	li $v0,5
	syscall
	move $t0,$v0 #t0 represents a
	
	li $v0,4
	la $a0,msg2
	syscall
	
	li $v0,5
	syscall
	move $t1,$v0  #t1 represents b
	
	li $v0,4
	la $a0,msg3
	syscall
	
	li $v0,5
	syscall
	move $s0,$v0 #takes in the option
	
	beq $s0,$s1,addn
	beq $s0,$s2,subtn
	beq $s0,$s3,muln
	beq $s0,$s4,divn
	
	
	addn:
		li $t3,0
		add $t3,$t0,$t1
		
		li $v0,4
		la $a0,msg4
		syscall
		
		move $a0,$t3
		li $v0,1
		syscall
		
		j exit
		
	subtn:
		li $t3,0
		sub $t3,$t0,$t1
		
		li $v0,4
		la $a0,msg4
		syscall
		
		move $a0,$t3
		li $v0,1
		syscall
		
		j exit
	
	muln:
		li $t3,0
		mul $t3,$t0,$t1
		
		li $v0,4
		la $a0,msg4
		syscall
		
		move $a0,$t3
		li $v0,1
		syscall
		
		j exit
	
	divn:
		
		li $t3,0
		li $t4,0
		div $t3,$t0,$t1
		rem $t4,$t0,$t1
		
		
		li $v0,4
		la $a0,msg4
		syscall
		
		move $a0,$t3
		li $v0,1
		syscall
		
		li $v0,4
		la $a0,nl
		syscall
		
		li $v0,4
		la $a0,msg5
		syscall
		
		move $a0,$t4
		li $v0,1
		syscall
		
		j exit
	
	exit:
		li $v0,10
		syscall
		

