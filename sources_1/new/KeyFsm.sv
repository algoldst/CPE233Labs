`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/28/2019 12:03:53 PM
// Design Name: 
// Module Name: KeyFsm
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Multiplexes through making rows B,G,F,D high, and checks whether column C, A, or E is high for each row, to determine which keypad button is being pressed.
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module KeyFsm(
    input clk,
    input C, A, E,
    output logic B, G, F, D,
    output logic press,
    output logic [3:0] keyOut
    );
    
    typedef enum {CHECK_B, CHECK_G, CHECK_F, CHECK_D} State;
    State NS, PS = CHECK_B;
    
    always_ff @(posedge clk) begin
        PS <= NS;
    end
    
    always_comb begin
        B = 0; G = 0; F = 0; D = 0;
        if(C | A | E) press = 1;
            else press = 0;
        case(PS)
            CHECK_B: begin
                B = 1;
                if(C) keyOut = 1;
                else if(A) keyOut = 2;
                else if(E) keyOut = 3;
                else keyOut = 13;
                NS = CHECK_G;
            end
            CHECK_G: begin
                G = 1;
                if(C) keyOut = 4;
                else if(A) keyOut = 5;
                else if(E) keyOut = 6;
                else keyOut = 13;
                NS = CHECK_F;
            end
            CHECK_F: begin
                F = 1;
                if(C) keyOut = 7;
                else if(A) keyOut = 8;
                else if(E) keyOut = 9;
                else keyOut = 13;
                NS = CHECK_D;
            end
            CHECK_D: begin
                D = 1;
                if(C) keyOut = 10;
                else if(A) keyOut = 0;
                else if(E) keyOut = 11;
                else keyOut = 13;
                NS = CHECK_B;
            end
            default: begin
                keyOut = 13; 
                NS = CHECK_B;
            end  
        endcase
    end
    
    
endmodule
