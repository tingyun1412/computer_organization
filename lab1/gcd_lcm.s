.data
    input_msg1: .asciiz "Please enter the first number: "
    input_msg2: .asciiz "Please enter the second number: "
    space:      .asciiz " "
    newline:    .asciiz "\n"

.text
.globl main

main:
    # input a
    li      $v0, 4
    la      $a0, input_msg1
    syscall

    li      $v0, 5
    syscall
    move    $s0, $v0  # Save the a to $s0

    # input b
    li      $v0, 4
    la      $a0, input_msg2
    syscall

    li      $v0, 5
    syscall
    move    $s1, $v0  # Save the b to $s1

    # GCD
    move    $a0, $s0
    move    $a1, $s1
    jal     gcd
    move    $t0, $v0  # Save GCD to $t0

    move    $a0, $t0
    li      $v0, 1 # print
    syscall

    li      $v0, 4
    la      $a0, space
    syscall

    # LCM
    move    $a0, $s0
    move    $a1, $s1
    jal     lcm
    move    $t1, $v0  # Save LCM to $t1

    move    $a0, $t1
    li      $v0, 1 # print
    syscall

    li      $v0, 4
    la      $a0, newline
    syscall

    # Exit program
    li      $v0, 10
    syscall

gcd:
    move    $t0, $a0
    move    $t1, $a1
gcd_loop:
    beq     $t1, $zero, ret  # If b == 0, GCD is a
    div     $t0, $t1              
    mfhi    $t2                   # a % b
    move    $t0, $t1              # Update a = b
    move    $t1, $t2              # Update b = remainder
    j       gcd_loop
ret:
    move    $v0, $t0              # Return GCD in $v0
    jr      $ra

lcm:
    addi    $sp, $sp, -4
    sw      $ra, 0($sp)           # Save return address
    
    add $t3, $a0, $zero	
    add $t4, $a1, $zero
    
    jal     gcd
    move    $t1, $v0
    mult    $t3, $t4              # Compute a * b
    mflo    $t0                   # Store the result in $t0
    div     $t0, $t1              # LCM = (a * b) / GCD
    mflo    $v0                   # Store LCM in $v0

    lw      $ra, 0($sp)           # Restore return address
    addi    $sp, $sp, 4
    jr      $ra

