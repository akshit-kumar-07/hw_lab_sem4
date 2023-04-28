.data
	msg1: .asciiz "Enter the value of n: "
	msg2: .asciiz "The sum of odd numbers upto n is: "
	msg3: .asciiz "The sum of even numbers upto n is: "
	nl: .asciiz "\n"
	
.text
.globl main

main:
	
	li $t0,0 #stores n
	li $v0,4
	la $a0,msg1
	syscall
	
	li $v0,5
	syscall
	move $t0,$v0 #n is stored in t0
	
	li $t1,0 #counter
	li $t2,0 #odd sum
	li $t3,0 #even sum
	
	loop_check:
		beq $t1,$t0,end
		addi $t1,$t1,1
		li $t4,0 #temp to store rem
		rem $t4,$t1,2
		beq $t4,$zero,add_even
		add $t2,$t2,$t1
		j loop_check
		add_even:
			add $t3,$t3,$t1
		j loop_check
		
	end:
		li $v0,4
		la $a0,msg2
		syscall
		
		li $v0,1
		move $a0,$t2
		syscall
		
		li $v0,4
		la $a0,nl
		syscall
		
		li $v0,4
		la $a0,msg3
		syscall
		
		li $v0,1
		move $a0,$t3
		syscall
		
	exit:
		li $v0,10
		syscall
		
