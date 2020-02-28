#written by Jonathan Williams, April 2018
#prints the worm onto the grid
#.DATA
	.data

	.align 4
wormCol:	.space	40 * 4
	.align 4
wormRow:	.space	40 * 4
	.align 4
grid:		.space	20 * 40 * 1
main__4:	.asciiz "Hey guys\n"
	
	.text
main:
	
	sw	$fp, -4($sp)
	sw	$ra, -8($sp)
	sw	$s0, -12($sp)
	sw	$s1, -16($sp)
	sw	$s2, -20($sp)
	sw	$s3, -24($sp)
	sw	$s4, -28($sp)
	la	$fp, -4($sp)
	addiu	$sp, $sp, -28
	
	
	
	
	li      $s0, 0		#row = 0
	li	$s1, 0		#col = 0
	li	$t0, '.'
	la	$t1, grid	#t1 = &grid[0][0]	
	

clearGrid:
	#set up stack frame
	sw	$fp, -4($sp)
	sw	$ra, -8($sp)
	sw	$s0, -12($sp)
	sw	$s1, -16($sp)
	la	$fp, -4($sp)
	addiu   $sp, $sp, -16
	
clearGridFor1:
	bge	$s0, 20, clearGridEnd1		#if(row >= 20) branch to clearGridEnd1
	
clearGridFor2:
	bge	$s1, 40, clearGridEnd2 	#if(col >= 40) branch to clearGridEnd2
	mul	$t2, $s0, 40		#t2 = row * 40 --- t2 is the offset
	add	$t2, $t2, $s1		#t2 += col
	mul	$t2, $t2, 4		#t2 *= 4
	add	$t2, $t2, $t1		#t2 += &grid[0][0]
	sw	$t0, ($t2)		#grid[row][col] = '.'
	
	addi	$s1, $s1, 1			#col++
	
	j	clearGridFor2		#continue loop
	
clearGridEnd2:
	li	$s1, 0			#col = 0
	addi    $s0, $s0, 1			#row++
	
	
	
	j	clearGridFor1
clearGridEnd1:
	
	li      $s0, 0		#row = 0
	li	$s1, 0		#col = 0
	li	$t3, '\n'
	
# tear down stack frame
	lw	$s1, -12($fp)
	lw	$s0, -8($fp)
	lw	$ra, -4($fp)
	la	$sp, 4($fp)
	lw	$fp, ($fp)
	jr	$ra	
	
	
	
printgrid:
	#set up stack frame
	sw	$fp, -4($sp)
	sw	$ra, -8($sp)
	sw	$s0, -12($sp)
	sw	$s1, -16($sp)
	la	$fp, -4($sp)
	addiu   $sp, $sp, -16		

printfor1:
	bge	$s0, 20, printend1
printfor2:
	bge	$s1, 40, printend2 	#if(col >= 40) branch to clearGridEnd2
	mul	$t2, $s0, 40		#t2 = row * 40 --- t2 is the offset
	add	$t2, $t2, $s1		#t2 += col
	mul	$t2, $t2, 4		#t2 *= 4
	add	$t2, $t2, $t1		#t2 += &grid[0][0]
	
	
	lw	$a0, ($t2)		#a0 = $t2 = '.'
	li      $v0, 11
	syscall
	
	
	addi	$s1, $s1, 1			#col++
	
	j	printfor2		#continue loop
printend2:
	li	$s1, 0
	addi	$s0, $s0, 1
	
	move	$a0, $t3		#print new line
	li	$v0, 11
	syscall
	
	j	printfor1
printend1:

	# tear down stack frame
	lw	$s1, -12($fp)
	lw	$s0, -8($fp)
	lw	$ra, -4($fp)
	la	$sp, 4($fp)
	lw	$fp, ($fp)
	jr	$ra
