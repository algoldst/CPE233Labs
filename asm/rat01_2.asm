; Author: Alex Goldstein
; Description: RAT Assignment 1, Part 2. (Refer to CPE 233 Lab Manual.)


.EQU LED_PORT = 0x10               ; port for output
.CSEG
.ORG         0x40                              ; code starts here
        
main_loop:  MOV     R29,0xFC
            ADD     R29,0x01
            MOV     R30,0xFA
            MOV     R31,0x05
            EXOR    R30,R31
            SUB     R30,R29
            BRNE    0x041     
            AND     R0,R0
			 
			 
			 
