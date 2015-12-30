			.data   0x10000000
arr_size: 	.word 	101 		# ARRAY_SIZE + 1
arr: 		.space 	404 		# allocate the array to
								# ARRAY_SIZE + 1
tab: 		.asciiz "	"		# for printing tabs between numbers								
								
			.text	0x0400000
#-----------------------------------------------------------

main:
			addi $t0, $0, 0				# initiate the local variable i
			addi $t1, $0, 0				# initiate the local variable j

			
			lw 		$t2, arr_size		# saves arr_size address in register $t2
			la 		$t3, arr			# saves arr address in register $t3
for:									# every cell in the array get its index as data
			slt 	$s0, $t0, $t2		# if i < arr_size inserts 1 in $s0
			beq 	$s0, $0, endfor1	# if i > arr_size go to end of for
			sw		$t0, 0($t3)			# array[i] = i;
			addi	$t3, $t3, 4			# goes to the next cell in the array
			addi	$t0, $t0, 1			# i++
			j		for					# jump to the beginning of the for

endfor1:			
			addi 	$t0, $0, 0			# initiate the local variable i to 0
			la 		$t3, arr			# saves the address of the beginning of arr in register $t3 for if
			la		$s5, arr			# saves the address of the beginning of arr in register $s5 for while loop
for2:		
			slt 	$s0, $t0, $t2		# if i < arr_size inserts 1 in $s0
			beq 	$s0, $0, endfor2 	# if i > arr_size go to end of for2
			addi 	$t4, $0, 1			# inserts 1 to $t4 in order to use in the next lines
			lw		$t7, 0($t3)			# load value of array[i] to $t7
			slt 	$s1, $t4, $t7		# if 1 < array[i] inserts 1 to $s1
			beq 	$s1, $0, endif  	# if 1 > array[i] go to end if
			addi 	$t1, $0, 2			# j=2
while:			
			mul 	$t5, $t0, $t1		# inserts i*j to $t5
			slt 	$s2, $t5, $t2		# inserts 1 to $s2 if i*j<ARRAY_SIZE+1
			beq 	$s2, $0, endif		# if j*i > ARRAY_SIZE+1 jumps to endif
			add 	$t5, $t5, $t5		# $t5 * 2
			add 	$t5, $t5, $t5		# $t5 * 2
			add 	$t6, $t5, $s5		# inserts the address of array[i*j] to $t6
			sw		$0, 0($t6)			# array[i*j] = 0
			addi	$t1, $t1, 1			# j++
			j		while				# goes to while

endif:
			addi	$t3, $t3, 4			# goes to the next cell in the array
			addi	$t0, $t0, 1			# i++
			j 		for2				# jumps to the beginning of the for
endfor2:	
			
			addi $t0, $0, 0				# initiate the local variable i to 0
for3: 
			slt 	$s0, $t0, $t2		# if i < arr_size inserts 1 in $s0
			beq 	$s0, $0, endfor3	# if i > arr_size go to end of for
			lw		$s6, 0($s5)			# load value of array[i] to $s6
			li 		$v0, 1				# the next 3 lines prints each cell of the array
			move  	$a0, $s6			# part of the printing to the screen
			syscall						# part of the printing to the screen
			li 		$v0, 4				# the next 3 lines prints tab
			la  	$a0, tab			# part of the printing to the screen (tab)
			syscall						# part of the printing to the screen (tab)
			addi	$s5, $s5, 4			# goes to the next cell in the array
			addi	$t0, $t0, 1			# i++
			j 		for3				# returns to for3 for the next iteration
endfor3:	j		endfor3
			 
#-----------------------------------------------------------
