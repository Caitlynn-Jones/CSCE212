.data
paragraph: .asciiz "The South Carolina Gamecocks football program represents the Univeristy of\n"
input1: .space 20
input2: .space 20
space: .asciiz "\n"
msg1: .asciiz "Please input first word: "
msg2: .asciiz "\nPlease input the second word: "
colon: .asciiz ":"

.text

main:
   #Prints out statement
   li $v0, 4    
   la $a0, paragraph #Prints out paragraph to be searched through
   syscall
   la $t0, paragraph #puts the paragraph into register $t0
   
   #Prints out the first message that asks the user for an input
   li $v0, 4
   la $a0, msg1 
   syscall
   
   #Takes the first input from the user
   li $v0, 8 #reads string from user
   la $a0, input1         
   li $a1, 20  #sets the maximum length of the string      
   syscall
   
   #prints out the second prompt message
   li $v0, 4
   la $a0, msg2
   syscall
   
  #Takes the second input from the user 
   li $v0, 8 #reads string from user
   la $a0, input2         
   li $a1, 20    #sets the maximum length of the string     
   syscall
  
   li $t1, 0 #set i = 0
search1: #searches for the first word inputted by the user
    la $t2, input1 #puts the first input into $t2
for1: #finds how many times the inputted word is in the paragraph
    lb $t4, ($t2) #start address of input
    lb $t3, ($t0) #start address of paragraph
    beq $t4, 0, iplus #if 0, go to iplus
    beq $t4, '\n', iplus #if there is a blank line, go to iplus
    beq $t3, 0, print1 #if 0, go to print1
    move $a0, $t3 #Converts to uppercase to avoid case sensitivity 
    jal upperCase #jumps to upperCase procedure
    move $t3, $v0 #puts the value from upperCase into $t3
    move $a0, $t4 #Converts to uppercase to avoid case sensitivity
    jal upperCase #jumps to uppercase procedure
    move $t4, $v0 #puts the value from upperCase into $t4
    bne $t3, $t4, iterator #if char are not equal jump to iterator
    addi $t2, $t2, 1 #goes to next index within the input
    addi $t0, $t0, 1 #goes to next index within the paragraph
    j for1  
iplus:
    la $t2, input1 #put the input from user into $t2
    addi $t1, $t1, 1 #i++, keeps count of how many times the word appears in the paragraph
    j for1 #jumps back to the first loop     
iterator: #iterates though the input
    la $t5, input1 #loads the input from user into $t5
    bne $t5, $t2, search1 #if inputs don't match, jump back to search1
    la $t2, input1 #loads the input into $t2
    addi $t0, $t0, 1 #iterates to the next char within the paragraph
    j for1  #jumps back to the loop       
print1:
    la $t0, input1 #prints the word inputted by the user 
for2: #converts all words in paragraph to uppercase in order to compare uppercase input
    lb $a0, ($t0) 
    beq $a0, '\n', exit1 #if there is a new line got to exit1
    jal upperCase #jumps to upperCase procedure
    move $a0, $v0 
    li $v0, 11
    syscall
    addi $t0, $t0, 1 #iterates through the paragraph
    j for2   
exit1:
    li $v0, 4
    la $a0, colon #prints a colon
    syscall
    move $a0, $t1 #prints the count of how many times the word appeared
    li $v0, 1
    syscall
    li $v0, 4
    la $a0, space #prints a new line
    syscall
    
    la $t0, paragraph 
    li $t1, 0 #set j = 0
search2:  #searches for the first word inputted by the user
    la $t2, input2  #puts the second input into $t2
for3:
    lb $t4, ($t2)
    lb $t3, ($t0) #loads starting character  
    beq $t4, 0, jplus #if 0, go to jplus
    beq $t4, '\n', jplus #if there is a blank line, got to jplus
    beq $t3, 0, print2 #if 0, go to print2
    move $a0, $t3 #Converts to uppercase to avoid case sensitivity
    jal upperCase #jumps to uppercase procedure
    move $t3, $v0 #puts the value from upperCase into $t3
    move $a0, $t4 #Converts to uppercase to avoid case sensitivity
    jal upperCase #jumps to uppercase procedure
    move $t4, $v0 #puts the value from upperCase into $t4
    bne $t3, $t4, iterator2 #if char are not equal jump to iterator2
    addi $t2, $t2, 1 #goes to next index within the input
    addi $t0, $t0, 1 #goes to next index within the paragraph
    j for3 
jplus:
    addi $t1, $t1, 1 #j++, keeps count of how many times the word appears in the paragraph
    la $t2, input2 #puts the input from user into $t2
    j for3 #jumps to for3
iterator2: #iterates though the input
    la $t5, input2 #loads the input from user into $t5
    bne $t5, $t2, search2 #if inputs don't match, jump back to search2
    la $t2, input2 #loads the input into $t2
    addi $t0, $t0, 1 #iterates to the next char within the input
    j for3  #jumps to for3
print2: #prints the word inputted by the user
    la $t0, input2   
for4: #converts all words in paragraph to uppercase in order to compare uppercase input
    lb $a0, ($t0)
    beq $a0, '\n', exit2 #if there is a new line got to exit2
    jal upperCase #jumps to upperCase procedure
    move $a0, $v0
    li $v0, 11
    syscall
    addi $t0, $t0, 1 #iterates through the paragraph
    j for4 #jumps to for4
exit2:
    li $v0, 4
    la $a0, colon #prints a colon
    syscall
    move $a0, $t1 #prints how many times input2 appeared in the paragraph
    li $v0, 1
    syscall 
MainExit:  
   #end of main
   li $v0, 10
   syscall
upperCase: #converts to uppercase
    move $v0, $a0
    beq $a0, 0, end #end if passed in string is 0
    blt $a0, 'a', end 
    bgt $a0, 'z', end
    sub $v0, $a0, 32 
end:
    jr $ra
