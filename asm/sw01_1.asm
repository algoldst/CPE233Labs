; Author: Alex Goldstein
; Description: Software Assignment 1.1
;	Read 3 inputs from port id 0x30, add them together, and output the result to port id 0x40. Assume the input values are 8-bit unsigned values.


.EQU IN_PORT = 0x30
.EQU OUT_PORT = 0x40

.CSEG
.ORG 0x01

start:	IN R1, IN_PORT
		IN R2, IN_PORT
		IN R3, IN_PORT
		ADD R1, R2
		ADD R1, R3
		OUT R1, OUT_PORT
			
			
