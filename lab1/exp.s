.data
    input_msg1: .asciiz "Enter base (positive integers): "
    input_msg2: .asciiz "Enter exponent (positive integers): "
    newline:    .asciiz "\n"

.text
.globl main

main:
    # input base
    li      $v0, 4
    la      $a0, input_msg1
    syscall

    li      $v0, 5
    syscall
    move    $s0, $v0  # Save the base to $s0

    # input exp
    li      $v0, 4
    la      $a0, input_msg2
    syscall

    li      $v0, 5
    syscall
    move    $s1, $v0  # Save the exp to $s1

    # exp
    move    $a0, $s0
    move    $a1, $s1
    jal     exp
    move    $t0, $v0  # Save ans to $t0

    move    $a0, $t0
    li      $v0, 1 # print
    syscall

    li      $v0, 4
    la      $a0, newline
    syscall

    # Exit program
    li      $v0, 10
    syscall
    
exp:
    move    $t0, $a0
    move    $t1, $a1
    li      $v0, 1
exp_loop:
    beq     $t1, $zero, ret  # If exp == 0, return 1
    
    mul     $v0, $v0, $t0
    sub     $t1, $t1, 1        
    j       exp_loop
    
ret:
    jr      $ra
