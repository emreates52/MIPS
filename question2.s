
# Emre ATEŞ 150112059-Oğuz ÖZTÜRK 150112060
# Question 2

            .data
				
# definitions			
			
msg2:       .asciiz "Please enter a positive number!!! "			# define the error message
msg1:       .asciiz "Please enter a positive integer number: "		# define the asking message
newline: .asciiz "\n"												# define the newline 
space:  .asciiz " "													# define the space
           
		    .text			
            .globl main	

main:       li $v0,4                 # system call for print_str
            la $a0,msg1              # address of string to print
            syscall					 # calling the asking message
			
			# prompt an integer from the user
            li $v0,5                 # system call for read_int
            syscall                  # the integer placed in $v0
		
            addu $t0, $v0, $0        # move the input number in $t0			
			
			# checking error control
			addi $t7,$t7,1
			slt $t8,$t0,$t7     	# if number<1 then t8=1
			beq $t8,$zero,noerr		# if no error jump a label
			
			li $v0,4                # system call for print_str
            la $a0,msg2             # address of string to print
            syscall					# if there is an error print error message
			
			addi $v0, $zero, 4    	# print_string syscall
			la $a0, newline       	# load address of the string
			syscall				  	# for moving to the bottom line

			
			j main					#jump back to the main and again ask a number
			
noerr:		#initalize the values	
			move $t1,$zero    		# i=0		
			addi $t3,$t3,1    		# j=1
			addi $s0,$s0,2    		# x=2
			
outer_loop: 
																				#before again entering inner_loop,reinitialize j=1 and increase x (x=x+1)
	inner_loop:																				#for(j=1;j<x;j++)
				li $v0, 1               	# system call for print_int						#print j value
				addu $a0, $t3, $0        	# move number to print in $a0
				syscall						# print the j value
				la  $a0, space      		# print space
				li  $v0, 4          
				syscall
				addi $t3,$t3,1				# increase j by one   
				blt $t3,$s0,inner_loop		# after that while j is smaller than x back to the inner_loop  
			
			addi $v0, $zero, 4  			# print_string syscall
			la $a0, newline       			# load address of the string
			syscall	
			addi $s0,$s0,1					# increase x by one
			move $t3,$zero      			# j=0 for reinitializing
			addi $t3,$t3,1					# then again initalize j=1
			addi $t1,$t1,1					# increase i by one
			slt $t2,$t1,$t0					# check if i is smaller than number
			bne $t2,$zero,outer_loop 		# if i<number turn back,else the loops will end		

			
# restore now the return address in $ra and return from main
            jr $ra                   # return from main

