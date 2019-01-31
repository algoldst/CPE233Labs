
; Author: Alex Goldstein
; Description: Test file for peripheral speaker for RAT computer. Given an input, plays a note.
;   0 --> No note output
;   1 --> C6 note
;   2 --> C#6 note
;   ...
;   36 --> B8 note

; Register Uses:
;   None


.EQU OUTPORT = 0x0F     ; This is the port that outputs to the speaker. (This is an assumption -- change in the future to match hardware.)
.ORG 0x10
.CSEG

start:  OUT  0x01, OUTPORT      ; Output C
        OUT  0x07, OUTPORT      ; F#        <-- Tritone! :D
        OUT  0x00, OUTPORT      ; Silence
        BRN  start


