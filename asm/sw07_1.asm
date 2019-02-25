; Software 07, Problem 1
; Author: Alex Goldstein

; Description:
; Create a subroutine that will divide a value by 10. Then use the subroutine
; to convert an unsigned 8-bit value into a 3 digit binary coded decimal. The
; main program should read an 8-bit unsigned value from port_id 0x9A. The value
; will be converted into a BCD (binary coded decimal) of 3 values for 100s, 10s,
; and 1s decimal place value. For example, the value 0xAF (175 decimal) should be
; split into 3 binary values for 1, 7, and 5. The 100’s value should be output to
; port_id 0x41, the 10’s value should be output to port_id 0x42, and the 1’s
; value should be output to port_id 0x43.


.EQU SWITCHES = 0x20

.ORG  0x01
.CSEG

setup:			ADD R0, R0
				BRN start

varStore:		ST   R1, (R0)				; varStore(r0 = var "stack" pointer)
				ADD  R0, 0x01
				ST   R2, (R0)
				ADD  R0, 0x01
				ST   R3, (R0)
				ADD  R0, 0x01
				ST   R4, (R0)
				ADD  R0, 0x01
				ST   R5, (R0)
				ADD  R0, 0x01
				ST   R6, (R0)
				ADD  R0, 0x01
				ST   R7, (R0)
				ADD  R0, 0x01
				ST   R8, (R0)
				ADD  R0, 0x01
				ST   R9, (R0)
				ADD  R0, 0x01
				RET
varRet:			SUB  R0, 0x01
				LD   R9, (R0)
				SUB  R0, 0x01
				LD   R8, (R0)
				SUB  R0, 0x01
				LD   R7, (R0)
				SUB  R0, 0x01
				LD   R6, (R0)
				SUB  R0, 0x01
				LD   R5, (R0)
				SUB  R0, 0x01
				LD   R4, (R0)
				SUB  R0, 0x01
				LD   R3, (R0)
				SUB  R0, 0x01
				LD   R2, (R0)
				SUB  R0, 0x01
				LD   R1, (R0)
				RET

start:			IN   R10, SWITCHES		; IN >> r10
				
				; Get hundred's place
				MOV  R1, R10			; value << r10
				CALL varStore			; getMaxPlaceDigit(value, index)
				MOV  R2, 0x02			; index = 2 (hundred's place)
				CALL getMaxPlaceDigit	; >> r3
				MOV  R11, R3			; R11 = hundreds
				CALL varRet				; Load R1-9
				
				; Get ten's place
				CALL varStore					; multNum(hundreds_digit, 100)
				MOV  R1, R11
				MOV  R2, 0x64
				CALL multNum				; >> r4
				MOV  R31, R4
				CALL varRet
				SUB  R1, R31			; Subtract hundred's place from original number

				CALL varStore
				MOV  R2, 0x01			; getMaxPlaceDigit(new_value, index=1) <-- tens place
				CALL getMaxPlaceDigit	; >> r3
				MOV  R12, R3			; R12 = tens
				CALL varRet

				; Get one's place
				CALL varStore			; Multiply tens digit * 10 so we can subtract it out
				MOV  R1, R12			; multNum(tens, 10) >> r4
				MOV  R2, 0x0A
				CALL multNum
				MOV  R31, R4
				CALL varRet
				SUB  R1, R31			; Subtract tens place from number

				MOV  R13, R1			; One's digit is just the remainder
end:			BRN  end
				
getMaxPlaceDigit:						; getMaxPlaceDigit(number=r1, maxDigit=r2) >> r3
				; Start by getting 10^(maxDigit) // in this case, maxDigit=2
				CALL varStore			; do expNum(0x0A, maxDigit)) >> r4
				MOV  R3, R2
				MOV  R1, 0x0A
				CALL expNum
				MOV  R31, R4			; temp hold for varRet
				CALL varRet
				MOV  R2, R31			; replace r2=10^(maxDigit) = 10,100,1000,etc.

				; Find how many times 100 goes into the number
				CALL divNum				; divNum(r1, r2)) >> r3
				;MOV  R1, R3				; Feed output of divNum r3 >> r1
				;SUB  R2, 0x01			; maxDigit--;
				;BRNE getMaxPlaceDigit	; while(maxDigit > 0);
				RET

divNum:			MOV  R3, 0x00  ; (R1 = dividend, R2 = divisor) >> r3
				CMP  R1, R2				; Check that R1 > R2
				BRCS divNum_ret
divNum_loop:	SUB  R1, R2
				BRCS divNum_ret			; if remainder < divisor, return
				ADD  R3, 0x01
				BRN  divNum_loop
divNum_ret:		RET

multNum:								; multNum(r1, r2) >> r4
				MOV  R4, 0x00
				CMP  R1, 0x00
				BREQ multNum_ret
				CMP  R2, 0x00
				BREQ multNum_ret
multNum_loop:	ADD  R4, R2
				SUB  R1, 0x01
				BRNE multNum_loop
multNum_ret:	RET

expNum:								; squareNum(num = r1, exp=r3) >> r4
				CMP  R3, 0x01
				BRCS expNum_pow0
				MOV  R4, 0x00
				MOV  R2, 0x01
expNum_loop:	CALL varStore
				CALL multNum
				MOV  R31, R4
				CALL varRet
				MOV  R4, R31
				MOV  R2, R4			;  product >> r2 for multNum(r1,r2)
				SUB  R3, 0x01
				BRNE expNum_loop
				RET
expNum_pow0:	MOV  R4, 0x01			; return num^0
                RET



