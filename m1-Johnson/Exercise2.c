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

unsigned int         hexaDigit2Value(char whichCharacter);

/*****************************************************************************\
 * function: main()                                                            *
 * usage:    command line with no parameter - main tries 3 fi=unctions         *
 *******************************************************************************
 * Inputs: ANSI flat C NO command line parameters                              *
 * Output: None                                                                *
 *                                                                             *
 
 \*****************************************************************************/

int main () {
    char hex;
    printf("Enter any hexadecimal character: ");
    scanf("%c", &hex);
    if((hex < '0' || hex > '9') && (hex < 'A' || hex > 'F')) {
        
        printf("The character %c is invalid: %c is not a hexadecimal digit.\n", hex, hex);
        
        return -1;
    }
    
    printf("hexaDigit2Value %d\n",hexaDigit2Value(hex));
} /* end of main function */


/***********************************************************************\
 * Input : hexadecimal digit (character)                                 *
 * Output: value of the digit                                            *
 * Function: returns value of binary digit                               *
 \***********************************************************************/
unsigned int         hexaDigit2Value(char whichCharacter){
    unsigned int value;
    if(whichCharacter >= 0x30 && whichCharacter <= 0x39){
        value =  whichCharacter - 0x30;
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





