# MIPS
 Projects
In this project, you are required to implement some procedures in MIPS assembly language. You will use SPIM simulator to develop and test your code.
1. Transform the following C code into a MIPS assembly code.
int func1 (int k) {
int arr[100];
int i = 0;
int s = 0;
for (i = 0; i < k; i = i + 1)
arr[i] = func2(i);
for (i = 0; i < k; i = i + 1)
s = s + arr[i];
return (s);
}
int func2 (int k) {
if (k % 2 == 0)
return (k * k + 2);
else
return k * (-1);
}
Note: There is no modulo operation in MIPS.
2. Write a program in MIPS that reads a number N and prints the following:
1
1 2
1 2 3
1 2 3 4
…..
1 2 3 4 5 …. N
Please note that you should consider all possible error checking and related warnings.
CSE 338 – Computer Organization Spring 2016
Assist. Prof. Betül Boz
3. Write a MIPS program that takes an input sentence and prints the words in it. A word is a sequence of characters without any whitespaces and punctuation marks. The only punctuation marks that you have to consider are: , . ! ? _ - ( ) (comma, period, exclamation, question mark, underscore, hyphen, parentheses, and white-space). Example:
input : !!!The first CSE-338 project is due on 25-March-2016 (Friday).!!!
output:
The
first
CSE
338
project
is
due
on
25
March
2016
Friday
4. A special sequence of numbers is defined as follows. The first two numbers in the sequence are 0 and 1, and each subsequent number is 4 times the previous number minus the one before that. In other words, let Ax be the x-th number in sequence. Then, Ax = (4 Ax-1 ) - Ax-2
The sequence is: 0, 1, 4, 15, 56, 209, 780, 2911...
Write a MIPS program that calculates the x-th number in the sequence. The program asks the user for the value of x and then pass x value to a procedure. The called procedure calculates the first x numbers in the sequence and writes them to an array in memory. After that, the procedure returns the beginning address of the array to the main program. The main program then accesses the x-th element of the array and prints it out to the screen. Ex:
Input: Please enter an integer number:
8
Output: In position 8, the value is 2911.
CSE 338 – Computer Organization Spring 2016
Assist. Prof. Betül Boz
If the value of x is smaller than 1, the program asks the user to enter a number greater than 1. You may assume that user enters only integers. (This is for simplicity so there is no need to check for floating point numbers).
Notes:
 A good way to go about writing a MIPS program is to first write an equivalent C program. It is much easier and quicker to get all the control flow and data manipulations correct in C than in MIPS. Once the C code for a program is correct, one can translate it to an equivalent MIPS program statement-by-statement.
 Bonus: You will get 10% extra credit if your program support a Menu including all questions above. Example:
Please select an option:
1. C-to-MIPS convert
2. Print Numbers
3. Word Finder
4. Print x-th Number
5. Exit
These options must be printed inside a loop until “Exit” option is selected.
Requirements
 The arguments to the procedures are stored in $a registers; i.e., the first one is in $a0, the second one is in $a1, and so on.
 The values in all $a registers should be as they were at the time of call at the end of the procedure.
 You have to use QtSpim simulator in your implementation. Any other simulator is not allowed.
 You are required to submit a 2-pages report explaining implementation details of your Project and commented code (via e-mail: cse338.projects@gmail.com). Your report should include explanations about procedure implementations. Your implementation detail should be provided in the source code comment.
General Policies
 All projects must be done with a partner. You will select your partner and the partner will not be changed throughout the semester. It is not acceptable of a partner team to work with other teams.
CSE 338 – Computer Organization Spring 2016
Assist. Prof. Betül Boz
 It is NOT acceptable to copy (or start your) solutions from Web.
 In case of any forms of cheating or copying among the groups, the penalties will be severe. Both Giver and Receiver are equally culpable and suffer equal penalties!!!
 No late submission will be accepted!
References
[1] http://spimsimulator.sourceforge.net/
