; template to start a new project 
; 11/29/2018 Michael Johnson mdj0025 Blake Schilleci wbs0013
INCLUDE Irvine32.inc
.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.data
	myString1 BYTE "Please enter a 64 bit number in hexadecimal(8 bytes)", 0Dh, 0Ah, 0;
	myString2 BYTE "Please enter the fist 32 bits of the number in hexadecimal (4 bytes)", 0Dh, 0Ah, 0;
	myString3 BYTE "Please enter the second 32 bits of the number in hexadecimal (4 bytes)", 0Dh, 0Ah, 0;
	myString4 BYTE "Please enter a 32 bit number in hexadecimal (4 bytes)", 0Dh, 0Ah, 0;
	buffer BYTE 11 DUP(?);
	result BYTE 256 DUP(?);
	N1Low DWORD ?;
	N1High DWORD ?;
	N2Low DWORD ?;
	N2High DWORD ?;

.code
main proc
	;call Exercise1;
	call Exercise2;
	;call Exercise3;
	invoke ExitProcess,0
main endp
Exercise1 proc
	push EDX;
	push EDI;
	push ESI;
	push EBX;


	mov EDX, OFFSET myString1;
	call WriteString;

	mov EDX, OFFSET myString2;
	call WriteString;
	call ReadHex;
	MOV EBX, EAX; This will store the first 32 bits of the number to EBX

	mov EDX, OFFSET myString3;
	call WriteString;
	call ReadHex; This will store the 2nd half of the 32 bit number into EAX
	mov EDI, EAX; This will store the 2nd half of the 64 bit number into EDX

	; The number is now in EBX:EDI

	;Start getting the second 64 bit number.
	mov EDX, OFFSET myString1;
	call WriteString;

	;get the first half
	mov EDX, OFFSET myString2;
	call WriteString;
	call ReadHex;
	MOV ESI, EAX; The first half will be stored in ESI
	
	;get the 2nd half of the number
	mov EDX, OFFSET myString3;
	call WriteString;
	call ReadHex;
	;The second number is stored in ESI:EAX

	;First we need to add the lower half of the two numbers
	;The lower half of the first number is stored in EDI
	;The lower half of the second number is stored in EAX;
	;Then we need to add the upper halves
	; If there is no carry from adding the lower halves then go to adding the upper halves.
	; The upper half of the first number is in EBX
	; The upper half of the second number is in ESI

	ADD EDI, EAX; stores the sum of the lower half in EDX
	jnc UPPER; If there is no carry, jump to add the upper half.
	;if there is a carry, then we need to add one to one of the upper halves
	ADD EBX, 1;
	jnc UPPER; if there is no carry from this then we go to add the upper values
	;if there is a carry
	MOV AL, 31h;
	call WriteChar;



  UPPER: ADD ESI, EBX; Stores the sum of the two upper halves in ESI
		 jnc DONE; If there is no carry from addition then jump to printing the answer
		 MOV AL, 31h;
		 call WriteChar; If there is a carry, we have a 65 bit number so print out a 1 to start


		 ;Now we have the sum of the upper halves stored in ESI
		 ;The sums of the lower halves are stored in EDI
		 ;All we need to do now is print the two values.
  DONE:	MOV EAX, ESI;
		call WriteHex; prints the upper half

		MOV EAX, EDI;
		call WriteHex;

		mov AL, 68h;
		call WriteChar;

	pop EBX;
	pop ESI;
	pop EDI;
	pop EDX;
ret;
Exercise1 endp

Exercise2 proc
	push EAX;
	push ESI;
	push EDI;
	push EDX;
	push ECX;
	push EBX;

	mov EDX, OFFSET myString1;
	call WriteString;

	mov EDX, OFFSET myString2;
	call WriteString;
	call ReadHex;
	MOV N1High, EAX;

	mov EDX, OFFSET myString3;
	call WriteString;
	call ReadHex;
	MOV N1Low, EAX;


	mov EDX, OFFSET myString1;
	call WriteString;

	mov EDX, OFFSET myString2;
	call WriteString;
	call ReadHex;
	MOV N2High, EAX;

	mov EDX, OFFSET myString3;
	call WriteString;
	call ReadHex;
	MOV N2Low, EAX;

	MOV EDI, OFFSET result;
	
	MOV EAX, N2Low;
	MUL N1Low;
	;stores in EDX:EAX
	MOV [EDI], EAX;
	MOV [EDI+4], EDX;

	MOV EAX, N2Low;
	MUL N1High;

	ADD [EDI+4], EAX;
	ADC [EDI+8], EDX;

	MOV EAX, N1Low;
	MUL N2High;
	;stores in EDX:EAX
	ADD [EDI+4], EAX;
	ADC [EDI+8], EDX;

	;There could still be a carry so dont forget to adc
	MOV EAX, N2High;
	MUL N1High;
	;Result in EDX:EAX
	ADD [EDI+8], EAX;
	ADC [EDI+12], EDX;

	MOV EAX, [EDI+12];
	Call WriteHex;

	MOV EAX, [EDI+8];
	Call WriteHex;

	MOV EAX, [EDI+4];
	Call WriteHex;

	MOV EAX, [EDI];
	Call WriteHex;

	pop EBX;
	pop ECX;
	pop EDX;
	pop EDI;
	pop ESI;
	pop EAX;
ret;
Exercise2 endp

Exercise3 proc
push EAX;
push EDX;
push EDI;
push ECX;
;ask for a 32 bit number
;store in a register
;mov into a seperate register the lower 4 bits
; then and with 0111

	MOV EDX, OFFSET myString4;
	call WriteString;
	call ReadHex;
	;The 32 bit number is now in EAX
	mov EDI, OFFSET buffer;
	add edi, 10;
	mov ECX, 11;

myLoop:	MOV BL, AL;
		AND BL, 07h;
		ADD BL, '0';
		MOV [EDI], BL;
		DEC EDI;
		SHR EAX, 3;
		loop myLoop;

		MOV EDX, OFFSET buffer;
	call WriteString;

pop ECX;
pop EDI;
pop EDX;
pop EAX;
ret;
Exercise3 endp
end main