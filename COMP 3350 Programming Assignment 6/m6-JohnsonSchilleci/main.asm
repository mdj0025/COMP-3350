; template to start a new project 
; 10/25/2018 Michael Johnson, mdj0025. Blake Schilleci, wbs0013
INCLUDE Irvine32.inc
.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.data
	myString BYTE "Please enter a sentence:",0dh,0ah,0

	
	byteCount DWORD ?; will hold the number of elements in the string.

	
	ex2Char BYTE "Please enter a character", 0dh,0ah,0;
	
	prompt3 BYTE "Please enter the first sentence:",0dh,0ah,0

     prompt4 BYTE "Please enter the second sentence:",0dh,0ah,0

     spacer BYTE " ",0dh,0ah,0 ;Spacer

     buffer BYTE 256 DUP(?) ;Buffer for string storage

     buffer2 BYTE 256 DUP(?) ;Buffer for more string storage

     finalString BYTE 512 DUP(?) ;Buffer for final string in exercise 3
	
.code
main proc
	
	call Exercise1;
	call Exercise2;
	call Exercise3;
	invoke ExitProcess,0
main endp

Exercise1 proc
	mov	EDX,OFFSET myString; Move into EDX the string to be printed.
	call WriteString; 
	
	mov EDX, OFFSET buffer;
	mov ECX, SIZEOF buffer;
	call ReadString;
	mov byteCount, EAX; here we have the desired value in AL.
	call WriteDec;
	mov AL, 0Ah; line feed
	call WriteChar;
	mov AL, 0Dh; Get carriage return character in al to call WriteChar.
	call WriteChar;
	mov EAX, byteCount;
	call WriteHex;
	mov AL, 0Ah; line feed
	call WriteChar;
	mov AL, 0Dh; Get carriage return character in al to call WriteChar.
	call WriteChar;
	mov EDX, OFFSET buffer;
	call WriteString;
	MOV Al, 0Dh;
	call WriteChar;
	mov AL, 0Ah;
	call WriteChar;

	ret;
Exercise1 endp

Exercise2 proc
	mov EDX, OFFSET myString;
	call WriteString; Prints out "Please enter a sentence"

	mov EDX, OFFSET buffer;
	mov ECX, SIZEOF buffer;
	call ReadString; Gets the string from the user
	mov byteCount, EAX; Gets the length from EAX and puts it into byteCount

	mov EDX, OFFSET ex2Char;
	call WriteString; Asks the user to input a character from the keyboard

	call ReadChar;
	call WriteChar;
	MOV BL, AL; store the character to use
	MOV AL, 0dh;
	call WriteChar;
	MOV Al, 0Ah;
	call WriteChar;
	MOV AL, BL;
	mov EDI, offset buffer;
	mov EBX, 00000000h; use BL as a counter for number of occurences
	mov ECX, byteCount; get the number of bytes in the string to loop.
F1: cmp AL, [EDI];
	jnz F2;
	inc EBX;

F2: add EDI, 1;
	loop F1;
	MOV EAX, 00000000h
	MOV EAX, EBX;
	call WriteDec;
	mov AL, 0dh;
	call WriteChar;
	mov Al, 0ah;
	call WriteChar;
	ret;
Exercise2 endp

Exercise3 proc
	 mov edx, OFFSET prompt3 ;set edx to prompt3
     call WriteString ;prompt for first sentence
     mov edx, OFFSET buffer ;point to buffer
     mov ecx, SIZEOF buffer ;max characters (256 bytes)
     call ReadString ;get string from keyboard, store in buffer
     mov ebx, eax ;store size of first string in ebx for safe keeping
     mov edx, OFFSET prompt4 ;set edx to prompt4
     call WriteString ;prompt for second sentence
     mov edx, OFFSET buffer2 ;point to buffer
     mov ecx, SIZEOF buffer2 ;max characters (256 bytes)
     call ReadString ;get string from keyboard, store in buffer
     ;Now have both strings. Now must concatenate them.
     ;esi = source
     ;edi = destination

	cld ;cear D to go forward with MOVSB
     mov esi, OFFSET buffer ;first source is first string.
     mov edi, OFFSET finalString ;final string after concatenation
     mov ecx, ebx ;use size of first string in loop/rep counte
     rep movsb ;copy value from esi to edi
     ;First string is now in finalstring. Time to add second string
     mov esi, OFFSET buffer2 ;second string
     mov ecx, eax ;eax = size of 2nd string
     rep movsb ;copy value from esi to edi
     ;Strings now concatenated, now print size and final string
     mov edx, OFFSET finalString ;move edx to prepare to write final string
     call WriteString ;write final string
     mov edx, OFFSET spacer ;create spacer
     call WriteString ;space
     call WriteDec ;display character count in decimal
     call WriteString ;write space/new line
     call WriteHex ;display character count in hex
     Call WriteString;write space/new line
	 ret ;return to calling function
Exercise3 endp

end main