/*****************************************************************************\
 * Programming Assignment 2 COMP 3350
 * Author: Michael Johnson, Blake Schilleci
 * Date  : September 20, 2018
 \*****************************************************************************/
 
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

unsigned int         binaryDigit2Value(char whichCharacter){
   unsigned int value;
   if(whichCharacter != '0' && whichCharacter != '1') {
      return -1;
   }
   else {
     return whichCharacter & 1;
   }
}

unsigned int         stringOfCharacters(char *str) {
   int n = 0;
   int total = 0;
   int current = 0;
   if (str[0] == '\0') {
      return -1;
   }
  
   while (str[n] != '\0') {
      n++;
   }
   int i;
   for (i = (n - 1); i >= 0; i--){
      current = binaryDigit2Value(str[i]);
      
      if (current == -1) {
         return -1;
      }
      else {
         total += current  << ((n-1) - i);
      
      }
   }
  
  
   return total;
}

int main() {
   char string [17];
   
   printf("Please enter a binary number: ");
   scanf("%16s", string);
   
   int value = stringOfCharacters(string);
   if (value == -1) {
      printf("The number you entered is not a valid binary number");
   }
   else {
      printf("The number is %d", value);
   
   }
   printf("\n");
   return 0;
}