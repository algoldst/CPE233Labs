; Author: Matthew Stallings
; Description:  Read an 8-bit unsigned value input from port id 0x30. 
;               If the input is greater than or equal to 128, the value is divided by 4. 
;               You can ignore any remainder. 
;               If the value is less than 128, the value is multiplied by 2. 
;               The result should be output to port id 0x42.


.EQU IN_PORT = 0x30
.EQU OUT_PORT = 0x42

.CSEG
.ORG 0x01

start:          IN   R0,IN_PORT
                CMP  R0,0x80
                BRCC greater_than   ; if(R0 >= 128)
                BRCS less_than      ; else

greater_than:   LSR  R0             ; divide by 4
                LSR  R0
                BRN  output

less_than:      CLC
                LSL  R0             ; multiply by 2
                BRN  output
                
output:         OUT  R0,OUT_PORT
