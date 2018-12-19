/*****************************************************************************\
 * Programming Assignment 2 COMP 3350                                             *
 * Author: Michael Johnson, Blake Schilleci                                                           *
 * Date  : September 20, 2018                                                   *
 \*****************************************************************************/

/*****************************************************************************\
 *                             Global system headers                           *
 \*****************************************************************************/
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char                 *integerToString(unsigned int number);

int main() {
   int value;
   printf("Please enter an integer. (From 0 to (2^32)-1): ");
   scanf("%d", &value);
   if (value < 0) {
      printf("The value you intered is not positive.");
      return -1;
   }
    
   char* string_value = integerToString(value);
    
   printf("The binary value for %d is %s", value, string_value);
   printf("\n");
   return -1;


}

char                 *integerToString(unsigned int number){
   char* string;
   string = malloc(33);
   int i;
   for(i = 31; i >= 0; i--) {
      string[i] = (number & 1) | 0x30;
      number = number >> 1;
   }
   string[32] = '\0';
   
   
   return string;
}