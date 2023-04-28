.data
	msg1: .asciiz "Enter the value of n: "
	msg2: .asciiz "Enter the elements in the array serially:\n"
	msg3: .asciiz "The most frequent element is: "
	msg4: .asciiz "The least frequent element is: "
	msg5: .asciiz "the highest frequency is: "
	msg6: .asciiz "the lowest frequency is: "
	arr: 
		.align 2
		.space 100
	mf: .space 100
	lf: .space 100
	nl: .asciiz "\n"
	space: .asciiz " "
	
.text
.globl main

main:
	
	li $v0,4
	la $a0,msg1
	syscall
	
	li $v0,5
	syscall
	move $t0,$v0 #n=t0
	
	li $v0,4
	la $a0,msg2
	syscall
	
	li $t1,0 #counter
	li $s1,0 #index
	loop_read:
		beq $t1,$t0,end_read
		li $v0,5
		syscall
		sw $v0,arr($s1)
		addi $s1,$s1,4
		addi $t1,$t1,1
		j loop_read
		
	end_read:
	
	li $t2,0 #stores max
	li $t3,999 #stores min
	li $t4,0 #j
	li $t1,0 #i
	li $s0,0 #index_i
	li $s1,0 #index_j
	li $s4,0 #ele1
	li $s5,0 #ele2
	
	while_out:
		beq $t1,$t0,print
		li $t5,0 #count
		li $t4,0
		while_in:
			beq $t4,$t0,while_out_2
			lw $s2,arr($s0);
			lw $s3,arr($s1);
			bne $s2,$s3,cont
			addi $t5,$t5,1
			cont:
				addi $t4,$t4,1
				addi $s1,$s1,4
				j while_in
	while_out_2:
		blt $t5,$t2,cont2
		move $t2,$t5
		move $s4,$s2
		
		cont2:
		bgt $t5,$t3,cont3
		move $t3,$t5
		move $s5,$s2
		
		cont3:
		addi $t1,$t1,1
		addi $s2,$s2,4
		j while_out
		
	print:
		
		li $v0,4
		la $a0,msg3
		syscall
		
		move $a0,$s4
		li $v0,1
		syscall
		
		li $v0,4
		la $a0,nl
		syscall
		
		li $v0,4
		la $a0,msg4
		syscall
		
		move $a0,$s5
		li $v0,1
		syscall
		
		li $v0,4
		la $a0,nl
		syscall
		
		li $v0,4
		la $a0,msg5
		syscall
		
		move $a0,$t2
		li $v0,1
		syscall
		
		li $v0,4
		la $a0,nl
		syscall
		
		li $v0,4
		la $a0,msg6
		syscall
		
		move $a0,$t3
		li $v0,1
		syscall
	
	exit:
		li $v0,10
		syscall	
