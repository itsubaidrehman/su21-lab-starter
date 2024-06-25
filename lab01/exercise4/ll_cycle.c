#include <stddef.h>
#include "ll_cycle.h"
#include <stdio.h>

int ll_has_cycle(node *head) {
    /* TODO: Implement ll_has_cycle */
    node *fast_ptr = head;
    node *slow_ptr = head;    // starting fast and slow ptr at the head of the list

   // check if advacning fast ptr by 2 nodes results in NULL then list is cyclic else advance the fast ptr to new node
   while (fast_ptr != NULL && fast_ptr -> next != NULL) {
      fast_ptr = fast_ptr -> next -> next;
      slow_ptr = slow_ptr -> next;

      if (fast_ptr == slow_ptr) {
         return 1;
      }
   }
   
}
