
# Emre ATEŞ 150112059-Oğuz ÖZTÜRK 150112060
# Question 3  

			.data
# global variables
buffer: 	.space 250
str1:  		.asciiz "input : "
str2:  		.asciiz "output :\n"
newline: 	.asciiz "\n"

			.text
			.globl main

main:
		la $a0, str1    	# load and print string asking for string
		li $v0,4
		syscall

		li $v0,8       		# take in input
		la $a0, buffer  	# load byte space into address
		syscall		
		
		la $a0, str2        # load and print string output
		li $v0,4
		syscall
	
		
	# initialize some variables
			move $t1,$zero    	# i=0
			addi $t4,$t4,250    # buffer size=250
			
	# assign some ascii values into temporary registers
			addi $t5,$t5,47		# character=,space()'.-
			addi $t6,$t6,63		# character=?
			addi $t7,$t7,95		# character=_
			
	# control the characters according to their ascii value and print characters
loop:
			lb $a0,buffer($t1)		# find ascii value of character and store value in a0
			addi $t0,$t1,1		
			lb $a1,buffer($t0)		# find next ascii value of character and store value in a1
						
			bne $a0,$t6,L2			# if character is not ? then we do not need look next character
			beq $a0,$t6,L4			# if character ? we need to look next character in order not to put extra newline
L2:			
			bne $a0,$t7,L3			# if character is not _ then we do not need look next character
			beq $a0,$t7,L4			# if character _ we need to look next character in order not to put extra newline
L3:			
			blt $t5,$a0,L1			# if character is not (,space()!.-)  then we do not need look next character			

L4:			
			beq $a1,$t6,exit		# if next character = ? go to exit do not print newline character
			beq $a1,$t7,exit		# if next character = _ go to exit do not print newline character
			blt $a1,$t5,exit		# if character < 47 so if it is (,space()!.-) and go to exit do not print newline character	
L1:			
			beq $a0,$t6,elsecon		# if character = ? go to else and pass newline
			beq $a0,$t7,elsecon		# if character = _ and pass newline
			blt $a0,$t5,elsecon		# if character < 47 so if it is (,space()!.-) and pass newline  
			
printc:				
			li $v0,11				# if it is not these characters, print the character 
			syscall			
			j exit					# pass the next character
            			
elsecon:	
			addi $v0, $zero,4  	# print string syscall
			la $a0, newline         # system call for print newline
			syscall

exit:			
			addi $t1,$t1,1			# i++
			slt $t3, $t1, $t4       # i < buffersize
            bne $t3, $zero, loop	


# restore now the return address in $ra and return from main
            jr $ra                   # return from main
