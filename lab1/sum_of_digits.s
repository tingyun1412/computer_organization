.data
    input_msg: .asciiz "Enter an integer: "
    newline:    .asciiz "\n"
    
.text
.globl main

main:
    li      $v0, 4
    la      $a0, input_msg
    syscall

    li      $v0, 5
    syscall
    move    $s0, $v0
    
    li      $t0, 0
    move    $t1, $s0
    beq     $t0, $zero, loop
    
# t0 for sum t1 for n
loop:
    beq     $t1, $zero, result
    li      $t3, 10
    div     $t1, $t3
    mflo    $t1
    mfhi    $t2
    add     $t0, $t0, $t2
    j loop

result:
    move    $a0, $t0
    li      $v0, 1
    syscall

    li      $v0, 4
    la      $a0, newline
    syscall
    
    # Exit program
    li      $v0, 10
    syscall

    
