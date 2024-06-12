#include <string.h>
#include <stdio.h>
#include "ex1.h"

/* Returns the number of times LETTER appears in STR.
There are two different ways to iterate through a string.
1st way hint: strlen() may be useful
2nd way hint: all strings end in a null terminator */
int num_occurrences(char *str, char letter) {
    /* TODO: implement num_occurances */
    int count = 0;
    while (*str != '\0') {
//	printf("%c\n", *str);
	if (*str == letter) {
		
		count = count + 1;
//		printf("Count : %d, letter : %c", count, *str);
	}
	str++;
	}
    printf("Letter appeared %d times in str\n", count);
    return count;
}

/* Populates DNA_SEQ with the number of times each nucleotide appears.
Each sequence will end with a NULL terminator and will have up to 20 nucleotides.
All letters will be upper case. */
void compute_nucleotide_occurrences(DNA_sequence *dna_seq) {
    /* TODO: implement compute_nucleotide_occurances */
    

	char *seq = dna_seq -> sequence;
	dna_seq -> A_count = 0;
	dna_seq -> C_count = 0;
	dna_seq -> G_count = 0;
	dna_seq -> T_count = 0;

    while (*seq != '\0') {
		if (*seq == 'A') {
			dna_seq -> A_count += 1;
		}

		if (*seq == 'C') {
			dna_seq -> C_count += 1;
		}

		if (*seq == 'G') {
			dna_seq -> G_count += 1;
		}
		if (*seq == 'T') {
			dna_seq -> T_count += 1;
		}
		
	    seq++;
	}
      
}
