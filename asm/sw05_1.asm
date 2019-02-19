
; CPE 233. SW05_01
; Author: Alexander Goldstein

; Description:
;    Create an array in the data segment that contains the first 14 values of
;    Fibonacci sequence (starting with 0 and ending with 233).
;    Write a program that progresses through the array and calculates the
;    difference between values that are 3 spots away from each other.
;    For example, the first value (0) and the 4th value (2) is a difference of 2.
;    The next calculation would be between the 2nd (1) and 5th (3) values.
;    When no item exists 3 spots away, no difference can be calculated.
;    Each difference should be output to port_id 0x42.
;    Fibonacci: 0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233

; Register Uses:
;    R0, R1 - Indexes
;    R2, R3 - Hold value at index [R0] and [R1]


.DSEG   ; Data segment (array) on Scratch Ram
.ORG 0x00   ; These instructions are PROG_ADDR lines 0-27 (each DB takes 2x lines)
.DB 0,1,1,2,3,5,8,13,21,34,55,89,144,233

.EQU outPort = 0x42
.CSEG
.ORG 0x28

        ; Setup
        MOV r0, 0x00    ; Index i
        MOV r1, 0x03    ; Index j

start:
        LD  r2, (r0)    ; Load r2 with the value in memory[r0]  // R0 is an index!
        LD  r3, (r1)    ; Load r3 with the value in memory[r1]  // R1 is an index!
        SUB r3, r2      ; r3 -= r2
        OUT r3, outPort ; r3 -> outPort
        ADD r0, 0x01    ; Increment i, j
        ADD r1, 0x01
        CMP r1, 0x0E    ; Is r1 == 14?
        BRNE start      ; if(r1 != 14) --> start

