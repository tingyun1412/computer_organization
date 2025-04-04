.data
	input_msg:	.asciiz "Please enter the first number: "
	newline: 	.asciiz "\n"
	input_msg:	.asciiz "Please enter the second number: "
	output_msg:	.asciiz " "
	newline: 	.asciiz "\n"

.text
.globl main
#------------------------- main -----------------------------
main:
# print input_msg on the console interface
	li      $v0, 4				# call system call: print string
	la      $a0, input_msg		# load address of string into $a0
	syscall                 	# run the syscall
 
# read the input integer in $v0
	li      $v0, 5          	# call system call: read integer
	syscall                 	# run the syscall
	move    $a0, $v0      		# store input in $a0 (set arugument of procedure factorial)

# jump to procedure factorial
	jal 	factorial
	move 	$t0, $v0			# save return value in t0 (because v0 will be used by system call) 

# print output_msg on the console interface
	li      $v0, 4				# call system call: print string
	la      $a0, output_msg		# load address of string into $a0
	syscall                 	# run the syscall

# print the result of procedure factorial on the console interface
	li 		$v0, 1				# call system call: print int
	move 	$a0, $t0			# move value of integer into $a0
	syscall 					# run the syscall

# print a newline at the end
	li		$v0, 4				# call system call: print string
	la		$a0, newline		# load address of string into $a0
	syscall						# run the syscall

# exit the program
	li 		$v0, 10				# call system call: exit
	syscall						# run the syscall

#------------------------- procedure factorial -----------------------------
# load argument n in $a0, return value in $v0. 
.text
factorial:	
	addi 	$sp, $sp, -8		# adiust stack for 2 items
	sw 		$ra, 4($sp)			# save the return address
	sw 		$a0, 0($sp)			# save the argument n
	slti 	$t0, $a0, 1			# test for n < 1
	beq 	$t0, $zero, L1		# if n >= 1 go to L1
	addi 	$v0, $zero, 1		# return 1
	addi 	$sp, $sp, 8			# pop 2 items off stack
	jr 		$ra					# return to caller
L1:		
	addi 	$a0, $a0, -1		# n >= 1, argument gets (n-1)
	jal 	factorial			# call factorial with (n-1)
	lw 		$a0, 0($sp)			# return from jal, restore argument n
	lw 		$ra, 4($sp)			# restore the return address
	addi 	$sp, $sp, 8			# adjust stack pointer to pop 2 items
	mul 	$v0, $a0, $v0		# return n * factorial(n-1)
	jr 		$ra					# return to the caller
	
