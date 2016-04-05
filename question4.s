
# Emre ATEŞ 150112059-Oğuz ÖZTÜRK 150112060
# Question 4  


            .data 

# Definitions
			
arr: 		.word 100   #int arr[100]						# Define the array

# Define the  messages

msg1:       .asciiz "Input: Please enter an positive integer number: "
msg2:    	.asciiz "Output: In position "
msg3:    	.asciiz ",the value is "
msg4:    	.asciiz "Please enter a number greater than 1"

			newline: .asciiz "\n"
			space:  .asciiz " "
            .text
            .globl main

main:       li $v0, 4                # system call for print msg1
            la $a0, msg1             # address of string to print
            syscall					 # call the message
			
# prompt an integer from the user
            li $v0, 5                # system call for read_int
            syscall                  # the integer placed in $v0
			
# array operations
			addi $t2,$v0,0			 # array size

		# check the errors like if number<1	
			
			addi $t7,$t7,1
			slt $t8,$t2,$t7     	 # if number<1 then t8=1
			beq $t8,$zero,noerr		 # if no error jump a label
			
			li $v0, 4                # system call for print_str
            la $a0, msg4             # address of string to print
            syscall					 # if there is an error print error message
			
			addi $v0, $zero, 4       # print_string syscall
			la $a0, newline          # load address of the string
			syscall				     # for moving to the bottom line

			
			j main				     # jump back to the main and again ask a number
noerr:			
			
			la $s1, arr 			 # $s1 = array address
			move $t0,$zero
			sw $t0,0($s1)		     # arr[0]=0
			addi $t0,$t0,1		
			sw $t0,4($s1)		     # arr[1]=1
			
			jal func1				 # call the func1 in order to calculate the other elements of the array
						
# print array
printloop:	
			sll $t4,$t1,2	         # $t4=i*4
			add $t4,$t4,$s1	         # $t4=v+[i*4]
			lw $t5,0($t4)			
			li $v0, 1                # system call for print_int
			addu $a0, $t5, $0        # move number to print in $a0
			syscall
			la  $a0, space           # system call for print space
			li  $v0, 4          
			syscall
			addi $t1, $t1, 1	     # i = i + 1
            slt $t3, $t1, $t2        # i < size
            bne $t3, $zero, printloop

# print last element of the array			
			addi $v0, $zero, 4       # print_string syscall
			la $a0, newline          # load address of the string
			syscall
	   
			li $v0, 4                # system call for print_msg2
            la $a0, msg2             # address of string to print
            syscall 
			
			li $v0, 1                # system call for print_int
			add $a0, $t2, $0         # move number to print in $a0
			syscall
			
			li $v0, 4                # system call for print_msg3
            la $a0, msg3             # address of string to print
            syscall 
			
			li $v0, 1                # system call for print_int
			addu $a0, $t5, $0        # move number to print in $a0
			syscall
			
			li $v0,10				 # exit
			syscall
			

func1:			
			move $t1,$zero           # i=0
			addi $t2,$t2,-2	

# calculate array elements and store to memory
loop:
			sll $t4,$t1,2			 # $t4=i*4 integer hold 4 byte so we multiply by 4
			add $t4,$t4,$s1			 # $t4=v+[i*4] find address of the element
			lw $t5,0($t4)			 # assign to $t5 register value of in $t4 address location 
			lw $t6,4($t4)			 # assign to $t6 register value of next element
			mul $t7,$t6,4			 # $t6 register multiply by 4
			nor $t5,$t5,$zero		 # !$t5
			addi $t5,$t5,1			 # take -$t5 value
			
			add $t8,$t7,$t5			 # get result of the operations(Result like this : A(x) = 4A(x-1) - A(x-2) )
			sw $t8,8($t4)			 # store result to memory after 2 next element
			addi $t1, $t1, 1	     # i = i + 1
            slt $t3, $t1, $t2        # i < size
            bne $t3, $zero, loop
			
			move $t1,$zero           # i=0
			addi $t2,$t2,2			

		
# restore now the return address in $ra and return from main
            jr $ra                   # return from main
			

