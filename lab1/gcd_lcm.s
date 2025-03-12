.data
	input_msg1:	.asciiz "Please enter the first number: "
	input_msg2:	.asciiz "Please enter the second number: "
	space:	.asciiz " "
	newline:	.asciiz "\n"

.text
.globl main
#------------------------- main -----------------------------
main:
# print input_msg on the console interface
	li      $v0, 4				# call system call: print string
	la      $a0, input_msg1		# load address of string into $a0
	syscall                 	# run the syscall

# read the input integer in $v0
	li      $v0, 5          	# call system call: read integer
	syscall                 	# run the syscall
	move    $a0, $v0      		# store input in $a0 

 # print input_msg on the console interface
	li      $v0, 4				# call system call: print string
	la      $a1, input_msg2		# load address of string into $a1
	syscall                 	# run the syscall
 
# read the input integer in $v0
	li      $v0, 5          	# call system call: read integer
	syscall                 	# run the syscall
	move    $a1, $v0      		# store input in $a0 (set arugument of procedure factorial)

# jump to procedure gcd
	move $t0, $a0
	move $t1, $a1
	jal 	gcd
	move 	$t0, $v0			# save return value in t0 (because v0 will be used by system call)
	
# jump to procedure gcd
	jal 	lcm
	move 	$t1, $v0			# save return value in t1 (because v0 will be used by system call)

# print the result of procedure factorial on the console interface
	li      $v0, 1              # System call: print integer
    move    $a0, $t2            # Load GCD result
    syscall                     # Print GCD
	li		$v0, 4				# call system call: print string
	la		$a0, space		# load address of string into $a0
	syscall						# run the syscall
    li      $v0, 1              # Print integer
    move    $a0, $t3            # Load LCM result
    syscall                     # Print LCM					# run the syscall

# print a newline at the end
	li		$v0, 4				# call system call: print string
	la		$a0, newline		# load address of string into $a0
	syscall						# run the syscall

# exit the program
	li 		$v0, 10				# call system call: exit
	syscall						# run the syscall

#------------------------- procedure factorial -----------------------------
# load a in $a0, b in $a1, return value in $v0. 
.text
gcd:	
	beq  $t1, $zero, return_a	# if b == 0 go to return_a
	move $t2, $a1                # Move b to $a2 (temp)
    remu $t1, $t0, $t1           # a % b, result in $a1
    move $t0, $t2                # Move original b to $a0
    jal gcd                      # Recursive call to gcd(b, a % b)
	jr 		$ra					# return to caller
return_a:		
	move $v0, $t0               # return a
	jr 		$ra					# return to the caller

lcm:
	jal gcd
	move $t0, $v0
	mult $a3, $a0, $a1               # a*b 存入 $a3
	div $a3, $t0                     # a*b /gcd(a,b)
	mflo $v0                         # result 存入 $v0
	jr 		$ra					     # return to caller
