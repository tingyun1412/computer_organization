.data
    input_msg: .asciiz "Enter five positive integers: "
    newline:    .asciiz "\n"
    space:      .asciiz " "

.text
.globl main

main:
    addi    $sp, $sp, -20 # 5*4=20
    
    li      $v0, 4
    la      $a0, input_msg
    syscall
    
    li      $t1, 5
    move    $t0, $sp
    
input_loop:
    beq     $t1, $zero, find_max_min
    li      $v0, 5
    syscall
    sw      $v0, 0($t0)
    addi    $t0, $t0, 4
    addi    $t1, $t1, -1
    j       input_loop


# t0 for cur t1 for size t2 for max t3 for min

find_max_min:
    lw      $t2, 0($sp)
    lw      $t3, 0($sp)
    
    li      $t1, 4
    addi    $t0, $sp, 4
    
loop:
    beq     $t1, $zero, result
    lw      $t4, 0($t0)

    slt     $t5, $t2, $t4
    bne     $t5, $zero, max
    
continue:
    slt     $t6, $t4, $t3
    bne     $t6, $zero, min
    
next_num:
    addi    $t0, $t0, 4
    addi    $t1, $t1, -1
    j       loop
    
max:
    move    $t2, $t4
    j continue
 
min:
    move    $t3, $t4
    j next_num
    
result:
    move    $a0, $t2
    li      $v0, 1
    syscall
    
    li      $v0, 4
    la      $a0, space
    syscall
    
    move    $a0, $t3
    li      $v0, 1
    syscall
    
    li      $v0, 4
    la      $a0, newline
    syscall

    # Exit program
    li      $v0, 10
    syscall
