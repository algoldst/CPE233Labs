; Author: Alexander Goldstein
; Description: CPE 233 Software Lab 2, Part 2.
;   Read an 8-bit unsigned value input from port id 0x30.
;   If the input value is a multiple of 4, all of the bits should be inverted, 
;       otherwise if the input value is odd, add 17 and divide the result by 2,
;       otherwise subtract 1 from the value. 
;   The result should be output to port id 0x42

; Register Uses:
;   R0 = Input, output value 
;   R1 = Manipulations
;   R31 = Loop counter

.EQU INPORT = 0x30
.EQU OUTPORT = 0x42
.CSEG
.ORG 0x01

start:      IN   R0, INPORT
            MOV  R1, R0         ; Copy into R1 to preserve R0
            
checkIfMultiple4:               ; Starting with number of form 0000-0000
            MOV R31, 0x03        ; Loop 3 times, for(i=3, i!=0, i--)
loopM4:     CLC
            LSR  R1             ; Divide by 2
            LSR  R1
            CMP  R1, 0x01       ; Is R1==1 ?
            BREQ isDiv4         ; branch if( div by 4 => 1) --> isDiv4

            SUB  R31, 0x1        ; i--
            CMP  R31, 0x0        ; i!=0 ?
            BRNE loopM4
            BRN  checkIfOdd     ; if(i==0) --> checkIfOdd

isDiv4:     EXOR R0, 0xFF       ; If input is multiple of 4, invert all bits 
            BRN  output

checkIfOdd:
            MOV  R1, R0         ; Copy R0 -> R1 for manipulations
            LSR  R1             ; Shifts R1 LSB into carry flag
            BRCS isOdd          ; If carry == 1, it's odd
            SUB  R0, 0x01       ; Otherwise subtract 1...
            BRN  output         ;       ...and output the result  

isOdd:      ADD  R0, 0x11       ; If odd, add 17 ...
            LSR  R0             ;       ... and divide by 2.
            BRN  output

output:     OUT  R0, OUTPORT
