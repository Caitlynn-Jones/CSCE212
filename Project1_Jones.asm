.data
message: .asciiz "ID = E24153784\n" 
prompt: .asciiz "Enter 4 integers for A, B, C, D respectively: \n"
space: .asciiz "\n"
decimal: .asciiz "f_ten = "
binary: .asciiz "f_two = "
decimal2: .asciiz "g_ten = "
binary2: .asciiz "g_two = "
decimalQ: .asciiz "h_quotient = "
decimalR: .asciiz "h_remainder = "

.text

main:

   #Display message
   li $v0, 4    
   la $a0, message
   syscall
    
   #display prompt
   li $v0, 4
   la $a0, prompt
   syscall
  
   #Read A input in $v0 and store it in $t0
   li $v0, 5
   syscall
   move $t0, $v0
  
   #Read B input in $v0 and store it in $t1
   li $v0, 5
   syscall
   move $t1, $v0
  
   #Read C input in $v0 and store it in $t2
   li $v0, 5
   syscall
   move $t2, $v0
  
   #Read D input in $v0 and store it in $t3
   li $v0, 5
   syscall
   move $t3, $v0
  
  
   #Loop 1 (A^2 = A*A)
   li $t6, 0
   loop1: 
       bge $t6, $t0, quit1
       add $s1, $s1, $t0
       addi $t6, $t6, 1
       j loop1
       quit1:
  
   #Loop 2 (B^2 = B*B)
   li $t6, 0
   loop2:
       bge $t6, $t1, quit2
       addu $s2, $s2, $t1
       addi $t6, $t6, 1
       j loop2
    quit2:
       li $t6, 0
    loop2a: #(B^2+B^2 = B^4)
        bge $t6, $s2, quit2a
        addu $s3, $s3, $s2
        addi $t6, $t6, 1
        j loop2a
     quit2a:
        li $t6, 0
            
     #Loop 3 (d^2 = d*d)
     loop3:
       bge $t6, $t3, quit3
       addu $s4, $s4, $t3
       addi $t6, $t6, 1
       j loop2
     quit3:
       li $t6, 0
     
     loop3a: #(d^2+d^2 = d^4)
        bge $t6, $s4, quit3a
        addu $s5, $s5, $s4
        addi $t6, $t6, 1
     quit3a:
        li $t6, 0
        addu $s5, $s5, $t3 #(d^4+d^1 = d^5)
     
        li $t7, 0 #f = $t7
        addu $t7, $s2, $s3 #f=(a^2+b^4)
        li $t8, 0 #g = $t8
        add $t8, $s5, $t2 #g=(c^1+d^5)
       
  
   #Display

   li $v0,4 # display the answer string with syscall having $v0=4
   la $a0, decimal # Gives answer in decimal value
   syscall # value entered is returned in register $v0

   li $v0, 1 # display the answer string with syscall having $v0=1
   move $a0, $t8 # moves the value from $a0 into $t8
   syscall # value entered is returned in register $v0

   li $v0,4 # display the answer string with syscall having $v0=4
   la $a0, space # puts space in between answers
   syscall # value entered is returned in register $v0

   li $v0,4 # display the answer string with syscall having $v0=4
   la $a0, binary # Gives answer in binary
   syscall # value entered is returned in register $v0

   li $v0, 35
   move $a0, $t7 # moves the value from into $a0 from $t8
   syscall # value entered is returned in register $v0

   li $v0,4 # display the answer string with syscall having $v0=4
   la $a0, space # puts space in between answers
   syscall # value entered is returned in register $v0

   #2nd equation

   li $v0,4 # display the answer string with syscall having $v0=4
   la $a0, decimal2 # Gives answer in decimal value
   syscall # value entered is returned in register $v0

   li $v0, 1 # display the answer string with syscall having $v0=1
   move $a0, $t8 # moves the value from $a0 into $t8
   syscall # value entered is returned in reg $v0

   li $v0,4 # display the answer string with syscall having $v0=4
   la $a0, space # puts space in between answers
   syscall # value entered is returned in register $v0

   li $v0,4 # display the answer string with syscall having $v0=4
   la $a0, binary2 # Gives answer in binary
   syscall # value entered is returned in register $v0

   li $v0, 35
   move $a0, $t8 # moves the value from into $a0 from $t8
   syscall # value entered is returned in register $v0

   li $v0,4 # display the answer string with syscall having $v0=4
   la $a0, space # puts space in between answers
   syscall # value entered is returned in register $v0
