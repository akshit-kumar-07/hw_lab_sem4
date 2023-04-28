.data
	msg: .asciiz "Hello World !!"
	nl: .asciiz "\n"
.text
.globl main

main:
	li $v0,4
	la $a0,msg
	syscall
	
	li $v0,4
	la $a0,nl
	syscall
	
	li $v0,10
	syscall
	
