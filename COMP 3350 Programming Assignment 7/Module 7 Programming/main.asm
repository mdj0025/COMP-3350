; MODULE 7 Programming assignment 
; 11/15/2018 Michael Johnson mdj0025, Blake Schilleci wbs0013
INCLUDE Irvine32.inc
.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.data
	myString BYTE "Please enter a sentence: ",0dh,0ah,0;
	myString2 BYTE "Please enter the number of characters to delete (in hexadecimal):", 0dh, 0ah, 0;
	myString3 BYTE "Please enter the position from where to start deleting (in hexadecimal): ", 0dh, 0ah, 0;
	myString4 BYTE "Please enter a string S1 in which to insert:",0dh,0ah,0;
	myString5 BYTE "Please enter a string S2 to insert:",0dh,0ah,0;
	myString6 BYTE "Please enter the position P where to insert:",0dh,0ah,0;
	newLine BYTE 0dh,0ah,0;
	buffer BYTE 256 DUP (?);
	bufferSize DWORD ?;
	delete_size DWORD ?;
	delete_pos DWORD ?;
	new_sentence BYTE 256 DUP (?);
	buffer2 BYTE 256 DUP (?);
	buffer2Size DWORD ?;
	buffer3 BYTE 256 DUP (?);
	buffer3Size DWORD ?;
	insert_pos DWORD ?;
	final_string BYTE 256 DUP (?);
	first_pos DWORD ?;
	final_length DWORD ?;
.code
main proc
	call Exercise1;
	call Exercise2;

	invoke ExitProcess,0
main endp



Exercise1 proc
	push EDX;
	push ECX;
	push EAX;
	push ESI;
	push EDI;
	push EBX;

	mov EDX, OFFSET myString; moving the string into edx to call WriteString
	call WriteString; outputs the string to the terminal
	
	mov EDX, OFFSET buffer; preparing to call Readstring
	mov ECX, SIZEOF buffer;
	call ReadString;
	mov bufferSize, EAX;

	mov EDX, OFFSET myString2; moving the string into edx to call WriteString
	call WriteString;

	call ReadHex; This will store the number of characters to delete in EAX.
	mov delete_size, EAX;

	;use esi the offset of the buffer and then you use edi to store the string up to the point
	;where you need to start deleting and then move the amount of characters forward and then start back in edi.


	mov EDX, OFFSET myString3;
	call WriteString;

	call ReadHex;
	mov delete_pos, EAX;
	
	cld; set the direction to move forward
	mov ESI, OFFSET buffer; Put in ESI the sentence the user entered.
	mov EDI, OFFSET new_sentence; Put in EDI the offset of the new sentence
	mov ECX, delete_pos; move in ECX the amount of bytes to move over before deleting
	dec ECX; this will set to the correct delete position
	rep movsb; copy the first part of the sentence into the new sentence.


	ADD ESI, delete_size; Move the position of ESI past the amount of characters to delete
	
	MOV EAX, delete_pos;
	ADD EAX, delete_size; Get the number of bytes that we have moved forward in the sentence.

	MOV EBX, SIZEOF buffer;
	SUB EBX, delete_pos;

	cld;
	mov ECX, EBX;
	rep movsb; copy the rest of the sentence into the new string;

	mov EDX, offset new_sentence;
	call WriteString;
	
	mov EDX, offset newLine;
	call WriteString;


	pop EBX;
	pop EDI;
	pop ESI;
	pop EAX;
	pop ECX;
	pop EDX;
ret;
Exercise1 endp

Exercise2 proc
	push EAX;
	push ECX;
	push ESI;
	push EDI;
	push EDX;
	push EBX;

	mov EDX, OFFSET myString4; prepare to call WriteString
	call WriteString;

	mov EDX, OFFSET buffer2; Prepare to store the string into buffer2
	mov ECX, SIZEOF buffer2;
	call ReadString; get the input from the user.
	push EAX; saves the number of characters in the first string.

	mov EDX, OFFSET myString5; Prepare to call WriteString
	call WriteString;

	mov EDX, OFFSET buffer3; Prepare to store the second string in buffer3
	mov ECX, SIZEOF buffer3;
	call ReadString; get the input from the user.
	mov EBX, EAX;

	mov EDX, OFFSET myString6; Preparing to call WriteString;
	call WriteString;

	call ReadHex;
	mov insert_pos, EAX;

	cld;
	mov ESI, OFFSET buffer2;
	mov EDI, OFFSET final_string;
	mov ECX, EAX;
	DEC ECX; since the position starts at 0.. we need to go back one to get the correct position;
	rep movsb;
	mov first_pos, ESI; store the stopping point of the first string into the variable.


	cld;
	mov ESI, OFFSET buffer3;
	mov ECX, EBX;
	rep movsb;

	cld;
	mov ESI, OFFSET buffer2;
	add ESI, insert_pos;
	DEC ESI;
	pop ECX; 
	sub ECX, EAX;
	INC ECX;
	rep movsb;

	mov EDX, OFFSET final_string;
	call WriteString;
	
	pop EBX;
	pop EDX;
	pop EDI;
	pop ESI;
	pop ECX;
	pop EAX;
	ret;
Exercise2 endp
end main