
; RAT 05_01: Control Unit & RAT MCU

.EQU SWITCH_PORT = 0x20 ; port for switch input 
.EQU LED_PORT    = 0x40 ; port for LED output  

.CSEG 
.ORG 0x01 

main:  IN    r10,SWITCH_PORT	; Read from 0x20 -> r10.	~> 0x34 00110100
       MOV   r11,0xFF 		 	; Write 0xFF -> r11			~> 0xFF 11111111
       EXOR  r10,r11 			; r10 = ~r10				~>    = 11001011
       OUT   r10,LED_PORT 		; r10 = 0xCB
       BRN   main 

	   