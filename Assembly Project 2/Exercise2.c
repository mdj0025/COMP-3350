/*****************************************************************************\
 * Programming Assignment 2 COMP 3350
 * Author: Michael Johnson, Blake Schilleci
 * Date  : September 20, 2018
 \*****************************************************************************/
 
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
unsigned int         hexaDigit2Value(char whichCharacter){
   unsigned int value;
    
    
    
    
   if(whichCharacter >= 0x30 && whichCharacter <= 0x39){
      value =  whichCharacter & 0xF;
      return value;
   }
   else if ((whichCharacter >= 0x41 && whichCharacter <= 0x46)) {
      value =  whichCharacter - 55;
      return value;
   }
   else  {
      return -1;
   }
    
}

unsigned int          hexaString2Value(char *str) {
   int n = 0;
   int total = 0;
   int current = 0;
   
   if (str[0] == '\0') {
      return -1;
   }
   
   while (str[n] != '\0') {
      n++;
   }
   
   int count = 0;
   int i;
   for (i = n - 1; i >= 0; i--) {
   
      current = hexaDigit2Value(str[i]);
      if (current == -1) {
         return -1;
      }
      total = total | (current << count);
      count += 4;
   
   }
   
   return total;
}

int main() {
   char string [5];
   printf("Please enter a four digit hexadecimal number: ");
   scanf("%4s", string);
   
   int n = 0;
   
   while (string[n] != '\0') {
      n++;
   }
   if (n != 4) {
      printf("The number %s is not a four digit hexadeximal number.", string);
      return -1;
   }
   
   int value = hexaString2Value(string);
   if (value == -1) {
      printf("One of the values in %s is not a valid hexadecimal digit. Please try again.", string);
      return -1;
   }
   
   printf("The decimal number of %s is %d.", string, value); 
   printf("\n");
}