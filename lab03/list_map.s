.globl map

.text
main:
    jal ra, create_default_list
    add s0, a0, x0 # a0 (and now s0) is the head of node list

    # Print the list
    add a0, s0, x0
    jal ra, print_list
    # Print a newline
    jal ra, print_newline

    # === Calling `map(head, &square)` ===
    # Load function arguments
    add a0, s0, x0 # Loads the address of the first node into a0

    # Load the address of the "square" function into a1 (hint: check out "la" on the green sheet)
    ### YOUR CODE HERE ###
    la a1, square     
    

    # Issue the call to map
    jal ra, map

    # Print the squared list
    add a0, s0, x0
    jal ra, print_list
    jal ra, print_newline

    # === Calling `map(head, &decrement)` ===
    # Because our `map` function modifies the list in-place, the decrement takes place after
    # the square does

    # Load function arguments
    add a0, s0, x0 # Loads the address of the first node into a0
    
    # Load the address of the "decrement" function into a1 (should be very similar to before)
    ### YOUR CODE HERE ###
    la a1, decrement

    # Issue the call to map
    jal ra, map

    # Print decremented list
    add a0, s0, x0
    jal ra, print_list
    jal ra, print_newline

    addi a0, x0, 10
    ecall # Terminate the program

map:
    # Prologue: Make space on the stack and back-up registers
    ### YOUR CODE HERE ###
    
    addi sp, sp, -8     #-16   # decrementing the stack by 3 location to store a0, a1, s0, ra
    sw ra, 0(sp)        #return address of function
    sw s0, 4(sp)        #node
    #sw a1, 8(sp)
    #sw a0, 12(sp)
    beq a0, x0, done # If we were given a null pointer (address 0), we're done.

    add s0, a0, x0        # Save address of this node in s0
    add s1, a1, x0        # Save address of function in s1

    # Remember that each node is 8 bytes long: 4 for the value followed by 4 for the pointer to next.
    # What does this tell you about how you access the value and how you access the pointer to next?

    # Load the value of the current node into a0
    # THINK: Why a0? -> what I thinks is as we have to pass this node as a function so to pass the argument we are saving it in a0
    ### YOUR CODE HERE ###
    lw a0, 0(s0)
    
    
    # Call the function in question on that value. DO NOT use a label (be prepared to answer why).
    # Hint: Where do we keep track of the function to call? Recall the parameters of "map".
    ### YOUR CODE HERE ###
    jalr s1    #As s1 holds the address of function

    # Store the returned value back into the node
    # Where can you assume the returned value is?
    ### YOUR CODE HERE ###
    sw a0, 0(s0)   # since s0 is the node in which we want the store the returned value & we know that function return its value is a0

    # Load the address of the next node into a0
    # The address of the next node is an attribute of the current node.
    # Think about how structs are organized in memory.
    ### YOUR CODE HERE ###
    lw a0, 4(s0)

    # Put the address of the function back into a1 to prepare for the recursion
    # THINK: why a1? What about a0? 
    # because we have to call the recursive function we have to keep the value of argument so we saved it in a0 & every time 
    #we will be calling the map function so we want to store the address of map function as well so we stored it in a1
    ### YOUR CODE HERE ###
    mv a1, s1

    # Recurse
    ### YOUR CODE HERE ###
    jal map

done:
    # Epilogue: Restore register values and free space from the stack
    ### YOUR CODE HERE ###
    lw ra, 0(sp)        #return address of function
    lw s0, 4(sp)        #node
    #lw s1, 8(sp)
    addi sp, sp 8
    jr ra # Return to caller

# === Definition of the "square" function ===
square:
    mul a0, a0, a0
    jr ra

# === Definition of the "decrement" function ===
decrement:
    addi a0, a0, -1
    jr ra

# === Helper functions ===
# You don't need to understand these, but reading them may be useful

create_default_list:
    addi sp, sp, -12
    sw ra, 0(sp)
    sw s0, 4(sp)
    sw s1, 8(sp)
    li s0, 0            # Pointer to the last node we handled
    li s1, 0            # Number of nodes handled
loop:                   # do...
    li a0, 8
    jal ra, malloc      #     Allocate memory for the next node
    sw s1, 0(a0)        #     node->value = i
    sw s0, 4(a0)        #     node->next = last
    add s0, a0, x0      #     last = node
    addi s1, s1, 1      #     i++
    addi t0, x0, 10
    bne s1, t0, loop    # ... while i!= 10
    lw ra, 0(sp)
    lw s0, 4(sp)
    lw s1, 8(sp)
    addi sp, sp, 12
    jr ra

print_list:
    bne a0, x0, print_me_and_recurse
    jr ra               # Nothing to print
print_me_and_recurse:
    add t0, a0, x0      # t0 gets current node address
    lw a1, 0(t0)        # a1 gets value in current node
    addi a0, x0, 1      # Prepare for print integer ecall
    ecall
    addi a1, x0, ' '    # a0 gets address of string containing space
    addi a0, x0, 11     # Prepare for print char syscall
    ecall
    lw a0, 4(t0)        # a0 gets address of next node
    jal x0, print_list  # Recurse. The value of ra hasn't been changed.

print_newline:
    addi a1, x0, '\n'   # Load in ascii code for newline
    addi a0, x0, 11
    ecall
    jr ra

malloc:
    addi a1, a0, 0
    addi a0, x0, 9
    ecall
    jr ra
