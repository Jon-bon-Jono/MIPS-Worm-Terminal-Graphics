	.globl	grid
	
	.data
	
grid:		.space	20 * 40 * 1
	
	
main__4:	.asciiz "Blocked!\n"
	.align	4
	
	
	.text
main:
	sw	$fp, -4($sp)
	sw	$ra, -8($sp)
	sw	$s0, -12($sp)
	sw	$s1, -16($sp)
	la	$fp, -4($sp)
	addiu   $sp, $sp, -16
	
	li      $s0, 0			#row = 0
	li	$s1, 0			#col = 0
	li	$t2, '.'		
	
	
clearGridFor1:
	#li	$t3, 0
	la	$t1, grid #($t3)		#t1 = &grid[0][0]
	li	$t3, 20			#t3 = NROWS = 20 -- only used for comparison below
	bge	$s0, $t3, clearGridEnd1	#if(row >= 20) branch to clearGridEnd1
	
	la	$a0, main__4
	addiu	$v0, $0, 4	# print_string
	syscall
	
clearGridFor2:
	li	$t3, 40			#t3 = NCOL = 40
	bge	$s1, $t3, clearGridEnd2 #if(column >= 40) branch to clearGridEnd2
	mul	$t3, $s0, 4		#t3 (total_offset) = 4*row
	mul	$t4, $s1, 4		#t4 (curr_row_offset) = 4*col
	add	$t1, $t3, $t4		#total_offset = total_offset + curr_row_offset
	add	$t1, $t1, $t3		#t1 = &grid[0][0] + total_offset
	lw	$t1, ($t1)		#$t1 = *$t1 = grid[row][col]
	li	$t1, '.'		#grid[row][col] = '.'
	addi    $s1, 1	                #col++
	
	la	$a0, main__4
	addiu	$v0, $0, 4	# print_string
	syscall
	
	j	clearGridFor2		#continue loop
	
clearGridEnd1:
	li	$s1, 0			#col = 0
	addi    $s0, 1			#row++
	j	clearGridFor1
clearGridEnd2:

        la	$a0, main__4
	addiu	$v0, $0, 4	# print_string
	syscall

	# tear down stack frame
	lw	$s1, -12($fp)
	lw	$s0, -8($fp)
	lw	$ra, -4($fp)
	la	$sp, 4($fp)
	lw	$fp, ($fp)
	jr	$ra
