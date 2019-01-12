; Author: Alex Goldstein
; Description: Software Assignment 1.2
; 	Read an input from port id 0x30. Assume the input is an 8-bit signed value in 2’s complement (RC). Change the sign of the input and output the result to port id 0x40. The result should also be an 8-bit signed value in 2’s complement (RC).  


.EQU IN_PORT = 0x30
.EQU OUT_PORT = 0x40

.CSEG
.ORG 0x01

start:	IN R1, IN_PORT
		SUB R2, R1		; R2 -= R2
		
		OUT R2, OUT_PORT
			
		
