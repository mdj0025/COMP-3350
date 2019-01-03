/*****************************************************************************\
 * Programmin Assignment COMP 3350
 * Author: Michael Johnson
 * Date  : September 6, 2018
 \*****************************************************************************/

/*****************************************************************************\
 *                             Global system headers                           *
 \*****************************************************************************/
#include <stdio.h>
#include <stdlib.h>
/*****************************************************************************\
 *                               Function prototypes                           *
 \*****************************************************************************/
unsigned int         binaryDigit2Value(char whichCharacter);



/*****************************************************************************\
 * function: main()                                                            *
 * usage:    command line with no parameter - main tries 3 fi=unctions         *
 *******************************************************************************
 * Inputs: ANSI flat C NO command line parameters                              *
 * Output: None                                                                *
 *                                                                             *
 
 \*****************************************************************************/
int main () {
    char value;
    printf("Please enter a binary digit: ");
    scanf("%c", &value);
    if(value != 48 && value != 49) {
        printf("The character %c is invalid %c is not a bit.\n", value, value);
        return -1;
    }
    printf("binaryDigit2Value %d\n",binaryDigit2Value(value));
} /* end of main function */


/***********************************************************************\
 * Input : binary digit (character)                                      *
 * Output: value of the digit                                            *
 * Function: returns value of binary digit                               *
 \***********************************************************************/
unsigned int         binaryDigit2Value(char whichCharacter){
    unsigned int value;
    value = whichCharacter - 48;
    return(value);
}