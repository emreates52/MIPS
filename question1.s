#Emre ATEŞ 150112059-Oğuz ÖZTÜRK 150112060
#Question 1	  

	  .data
	  
#Definitions
	  
msg1: .asciiz "Please enter an integer number: "								#Define the asking message
msg2: .asciiz "Error!!! "				#define the asking message
msg3: .asciiz "Result: "														#Define the asking message
newline: .asciiz "\n"															#define the newline 
arr: .word 100   #int arr[100]													#Define the array

	  .text
	  .globl main
	  
main:

		li $v0, 4                # system call for print_str
        la $a0, msg1             # address of string to print
        syscall					 #calling the asking message						
		
		# now get an integer from the user
        li $v0, 5                # system call for read_int
        syscall                  # the integer placed in $v0
		
		addi $s3,$v0,0			 # $s3= int k value store for send parameter to func1
		
		#checking error control
		addi $t7,$t7,1
		slt $t8,$s3,$t7     	#if number<1 then t8=1
		beq $t8,$zero,noerror		#if no error jump a label
		
		addi $v0, $zero, 4  	# print_string syscall
		la $a0, newline       	# load address of the string
		syscall					#moving bottom line
		
		li $v0, 4                # system call for print_str
        la $a0, msg2             # address of string to print
        syscall			#if there is an error print error message
		
		addi $v0, $zero, 4  	# print_string syscall
		la $a0, newline       	# load address of the string
		syscall					#moving the bottom line
		addi $v0, $zero, 4  	# print_string syscall
		la $a0, newline       	# load address of the string
		syscall
		
		j main				#jump back to the main and again ask a number
		
		
		
noerror:		
		
		jal func1				 # call func1
		addu $t7, $v0, $0        # move return value to $t7
		
		addi $v0, $zero, 4  	# print_string syscall
		la $a0, newline       	# load address of the string
		syscall					#moving bottom line
		li $v0, 4                # system call for print_str
        la $a0, msg3             # address of string to print
        syscall	
		
		li $v0, 1                # system call for print_int
		addu $a0, $t7, $0        # move number to print in $t7
		syscall					 # print s value
		
		li $v0, 10               # terminate program run and
		syscall                  # Exit
		
	  
func1:		
		addi $sp,$sp,-4				#Decrement stack pointer by 4
	    sw $ra,0($sp)				#Save $ra to stack
		
		#initalize variables
		move $s2,$zero	# i=0
		la $s1, arr 	# $s1 = array address
		addi $a1,$s2,0	# $a1=0

loop1: 
	   addi $a1,$s2,0	# func2(i) find i value	
	   jal func2	    # call func2
	   sll $t1,$s2,2	# $t1= i*4
	   add $t1,$t1,$s1	# $t1=v+[i*4]

	   sw $v0,0($t1)	# arr[i]=func2(i)
	   
	   addi $s2,$s2,1	# i=i+1
	   slt $t3,$s2,$s3	# $t3=(i<size)
	   bne $t3,$zero,loop1 

	   #initalize variables
	   move $t0,$zero	# i=0
	   move $s4,$zero	# s=0
	   la $s1, arr 		# $s1=array address

loop2: 
	   sll $t1,$t0,2	# $t1= i*4
	   add $t1,$t1,$s1	# $t1= v+[i*4]

	   lw $t4,0($t1)	# $t4= arr[i]
	   add $s4,$s4,$t4	# s = s+arr[i]
	   
	   addi $t0,$t0,1	# i=i+1
	   slt $t3,$t0,$s3	# $t3=(i<size)
	   bne $t3,$zero,loop2 
	   
	   addi $v0,$s4,0
	   lw $ra,0($sp)		#copy from stack to $ra
	   addi $sp,$sp,4		#Increment stack pointer by 4	
	   jr $ra 			# return address
	   
func2:
		addi $sp,$sp,-4				#Decrement stack pointer by 4
	    sw $ra,0($sp)				#Save $ra to stack
	   
	   andi $t0,$a1,1		# k%2
	   bne $t0,$zero,else	# if(k%2!=0) go to else statement
	   mul $t2,$a1,$a1		# k*k
	   addi $t2,$t2,2		# k*k+2
	   addi $v0,$t2,0		# return (k*k+2)
	   lw $ra,0($sp)		#copy from stack to $ra
	   addi $sp,$sp,4		#Increment stack pointer by 4
	   jr $ra               #return address

else: 
	   nor $t1,$a1,0		# assign not value of $a1 to $t1 register
	   addi $t1,$t1,1		# add one to register $t1 and find its negative value
	   addi $v0,$t1,0		# return k*(-1)
	   
	   lw $ra,0($sp)		#copy from stack to $ra
	   addi $sp,$sp,4		#Increment stack pointer by 4	
	   
	   jr $ra 			    # return address
	
	   
	   