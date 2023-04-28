.data
	msg1: .asciiz "Enter the value of n: "
	msg2: .asciiz "Enter the elements sequentially: \n"
	msg3: .asciiz "The maximum number in the array is: "
	msg4: .asciiz "The minimum number in the array is: "
	nl: .asciiz "\n"
	arr: 
		.align 2 
		.space 400
	space: .asciiz " "
.text
.globl main

main:
	
	li $v0,4
	la $a0,msg1
	syscall
	
	li $t0,0 #stores n
	li $v0,5
	syscall
	move $t0,$v0
	
	li $v0,4
	la $a0,msg2
	syscall
	
	
	addi $t1,$zero,0 #counter
	addi $s1,$zero,0
	loop_read:
		beq $t0,$t1,end_read
		li $t2,0 #stores the temp num
		li $v0,5
		syscall
		move $t2,$v0
		sw $t2,arr($s1)
		addi $t1,$t1,1
		addi $s1,$s1,4
		j loop_read
	
	end_read:
	li $t7,0 #stores max
	li $t8,100 #stores min
	li $t1,0 #counter
	li $s0,0
	loop_find:
		beq $t0,$t1,end
		lw $t2,arr($s0)
		bgt $t2,$t8,find_max
		move $t8,$t2
		find_max:
			blt $t2,$t7,jmp
			move $t7,$t2
			jmp:
				addi $t1,$t1,1
				addi $s0,$s0,4
				j loop_find
	
	end:
		li $v0,4
		la $a0,msg3
		syscall
		
		move $a0,$t7
		li $v0,1
		syscall
		
		li $v0,4
		la $a0,nl
		syscall
		
		li $v0,4
		la $a0,msg4
		syscall
		
		move $a0,$t8
		li $v0,1
		syscall
		
	exit:
		li $v0,10
		syscall
		
