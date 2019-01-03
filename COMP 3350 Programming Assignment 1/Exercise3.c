/*****************************************************************************\
 * Programmin Assignment COMP 3350                                             *
 * Author: Michael Johnson                                                           *
 * Date  : September 6, 2018                                                   *
 \*****************************************************************************/

/*****************************************************************************\
 *                             Global system headers                           *
 \*****************************************************************************/
#include <stdio.h>
#include <stdlib.h>



/*****************************************************************************\
 *                             Global data types                               *
 \*****************************************************************************/



/*****************************************************************************\
 *                             Global definitions                              *
 \*****************************************************************************/





/*****************************************************************************\
 *                            Global data structures                           *
 \*****************************************************************************/




/*****************************************************************************\
 *                                  Global data                                *
 \*****************************************************************************/



/*****************************************************************************\
 *                               Function prototypes                           *
 \*****************************************************************************/
char                 *integerToString(unsigned int number);



/*****************************************************************************\
 * function: main()                                                            *
 * usage:    command line with no parameter - main tries 3 fi=unctions         *
 *******************************************************************************
 * Inputs: ANSI flat C NO command line parameters                              *
 * Output: None                                                                *
 *                                                                             *
 
 \*****************************************************************************/

int main () {

   int n;
   printf("Enter any positive int value n: ");
   scanf("%d", &n);
   if (n < 0) {
      printf("Error. You must input a positive number.");
      return -1;
   }
   printf("hexaDigit2Value %s\n",integerToString(n));
} /* end of main function */

/***********************************************************************\
 * Input : integer number n                                              *
 * Output: string s of characters representing n in binary               *
 * Function: returns a string s                                          *
 \***********************************************************************/
char                 *integerToString(unsigned int number){
    unsigned int value = number;
    char *string = NULL;
    char* reverse_string;
    
    string = malloc(33); // 33 = 32+1 as string of 32 charcaters + null characters at the end
    reverse_string = malloc(33);
    string[32] = '\0';
    int i = 0;
    int j;
    
    //string = value | 0x30 or 0x31
    while (value > 0) {
        reverse_string[i] = (value%2) + 0x30;
        i++;
        value = value / 2; 
    }
    string[i] = '\0';
    int length = i - 1;
    for (j = 0; j <= length; j++){
        string[j] = reverse_string[length - j];
    }
    return(string);
}
