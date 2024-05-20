.data
.word 2, 4, 6, 8
n: .word 9

.text
main:
    add t0, x0, x0      #t0 holds 0
    addi t1, x0, 1     #t1 holds 1
    la t3, n         #t3 holds the addr of n
    lw t3, 0(t3)      #data at addr holded by t3 is now moved to t3 -> 9
fib:
    beq t3, x0, finish    # if t3 equals zero, branch is taken move to label finish
    add t2, t1, t0        # t2 = 0 + 1 on 1st iteration
    mv t0, t1             #t0 holds t1, 
    mv t1, t2
    addi t3, t3, -1      #decrementing t3
    j fib
finish:
    addi a0, x0, 1
    addi a1, t0, 0
    ecall # print integer ecall
    addi a0, x0, 10
    ecall # terminate ecall
