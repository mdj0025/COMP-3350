; template to start a new project 
; 10/04/2018 Michael Johnson mdj0025, Blake Schilleci wbs0013
INCLUDE Irvine32.inc
.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.data
	myString BYTE "h", 0dh, 0ah
.code
main proc
	;Exercise 1
	MOV AL, 06h; Convert value in AL into ASCII in DL
	MOV DL, 30h;
	OR AL, DL;
	MOV DL, AL;  
	call WriteChar;   Printout the character with LF/CR
	MOV AL, 0Ah;
	call WriteChar;
	MOV AL, 0Dh;
	call WriteChar;

	;Exercise 2
	MOV AL, 94h; 
	MOV DH, AL;
	SHR DH, 4; Get the MSB
	OR DH, 30h; Convert to ASCII value
	MOV DL, AL; 
	AND DL, 0Fh; Get the LSB
	OR DL, 30h; Convert to ASCII value
	MOV AL, DH;
	call WriteChar;
	MOV AL, DL;
	call WriteChar;
	MOV AL, 68h; Move in value 'h' to print
	call WriteChar;
	MOV AL, 0Ah; New line
	call WriteChar;
	MOV AL, 0Dh; Carriage Return
	call WriteChar;


	; Exercise 3 -- get the value from a digit
	call ReadChar;
	MOV DL, AL;
	AND DL, 0Fh; 

	; Exercise 4
	call ReadChar; Reading the most significant Digit
	MOV DH, AL;
	AND DH, 0Fh;
	SHL DH, 4
	call ReadChar; Reading the LSB
	MOV DL, AL;
	AND DL, 0Fh;
	OR DL, DH;
	MOV AL, DL;

	invoke ExitProcess,0
main endp
end main