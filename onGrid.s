#written by Jonathan Williams, April 2018
#tests whether the worm is currently on the grid
	.text
main:
	#set up frame
	sw	$fp, -4($sp)
	sw	$ra, -8($sp)
	la	$fp, -4($sp)
	addiu	$sp, $sp, -8
	
	li	$a0, 1
	li	$a1, 0
	jal	onGrid
	
	move	$a0, $v0
	li	$v0, 1
	syscall
	
	li	$a0, '\n'
	li	$v0, 11
	syscall
	
	lw	$ra, -4($fp)
	la	$sp, 4($fp)
	lw	$fp, ($fp)
	jr	$ra


onGrid:
# set up stack frame
	sw	$fp, -4($sp)
	sw	$ra, -8($sp)
	la	$fp, -4($sp)
	addiu	$sp, $sp, -8

onGridCond1:
    	blt	$a0, 0, onGridReturnZero	
onGridCond2:
	bge	$a0, 40, onGridReturnZero
onGridCond3:
	blt	$a1, 0, onGridReturnZero
onGridCond4:
	bge	$a1, 20, onGridReturnZero
	li	$v0, 1
	j	onGridEnd
onGridReturnZero:
	li	$v0, 0
onGridEnd:
	# tear down stack frame
	lw	$ra, -4($fp)
	la	$sp, 4($fp)
	lw	$fp, ($fp)
	jr	$ra
