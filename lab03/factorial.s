.globl factorial

.data
n: .word 7

.text
main:
    la t0, n
    lw a0, 0(t0)
    jal ra, factorial

    addi a1, a0, 0
    addi a0, x0, 1
    ecall # Print Result

    addi a1, x0, '\n'
    addi a0, x0, 11
    ecall # Print newline

    addi a0, x0, 10
    ecall # Exit

factorial:
    # YOUR CODE HERE
    add t0, a0, zero
    addi t1, zero, 0
    #check the condtion if argument is 0 or less
    bgt t0, t1, else
    addi a0, zero, 1
    jr ra
    
    else:
        addi t1, zero, 1     # i
        addi t2, zero, 1      #result
        loop: 
            
            bgt t1, t0, return
            mul t2, t1, t2
            addi t1, t1, 1
            j loop
            
        return:
            mv a0, t2
            jr ra
            
    
    
    
    
    
    
    
    
    
    
    