.data
message: .asciiz "ID = E24153784\n" 
prompt: .asciiz "Enter 4 integers for A, B, C, D respectively: \n"
space: .asciiz "\n"
exp1: .word 2
exp2: .word 4
exp3: .word 1
exp4: .word 5
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
   
exp:
    
   
   addi $s1, $zero, 0 #set i = 0
loop0:
    blt $s1, $t0, loop1 #i < A
    j out
loop1:
    addu $s7, $t0, $t0 #A+A
    addi $s1, $s1, 1
    j loop0
out:

     addi $s3, $zero, 2 #first exponent
     addi $s1, $zero, 0 #set i = 0 (may not need this)
     addi $s2, $zero, 1 #result = 1
loop2:
    blt $s1, $s3, loop3
    j out
loop3:
    addu $s7, $s7, $s7 #AxA
    addi $s1, $s1, 1
    j loop2
out1:
    
    addi $s1, $zero, 0 #set i = 0
loop4:
    blt $s1, $t1, loop5 #i < B
    j out
loop5:
    addu $s0, $t1, $t1 #B+B
    addi $s1, $s1, 1
    j loop4
out2:

     addi $s4, $zero, 4 #second exponent
     addi $s1, $zero, 0 #set i = 0 (may not need this)
     addi $s2, $zero, 1 #result = 1
loop6:
    blt $s1, $s4, loop7
    j out
loop7:
    addu $s0, $s0, $s0 #BxB
    addi $s1, $s1, 1
    j loop6
out3:
  addi $s1, $zero, 0 #set i = 0
loop8:
    blt $s1, $t2, loop9 #i < C
    j out
loop9:
    addu $t2, $t2, $t2 #C+C
    addi $s1, $s1, 1
    j loop8
out4:

     addi $s5, $zero, 1 #third exponent
     addi $s1, $zero, 0 #set i = 0 (may not need this)
     addi $s2, $zero, 1 #result = 1
loop10:
    blt $s1, $s3, loop11
    j out
loop11:
    addu $t2, $t2, $t2 #CxC
    addi $s1, $s1, 1
    j loop10
out5:
      addi $s1, $zero, 0 #set i = 0
loop12:
    blt $s1, $t4, loop13 #i < D
    j out
loop13:
    addu $t3, $t3, $t3 #D+D
    addi $s1, $s1, 1
    j loop12
out6:

     addi $s6, $zero, 2 #fourth exponent
     addi $s1, $zero, 0 #set i = 0 (may not need this)
     addi $s2, $zero, 1 #result = 1
loop14:
    blt $s1, $s6, loop15
    j out
loop15:
    addu $t3, $t3, $t3 #DxD
    addi $s1, $s1, 1
    j loop14
out7:

    add $t5, $s7, $t1 #f = a^2+b^4
    add $t6, $t2, $t3 #g = c^1+d^5
    
    #display
    #li $t4, 4
    #li $v0, 1
    #move $a0, $t4
    #syscall
    
    #li $v0, 10
    #syscall
    
   #Display Decimal
   li $v0, 4    
   la $a0, decimal
   syscall
   
   li $v1, 4
   syscall
    
    

    #end of main
    li $v0, 10
    syscall
