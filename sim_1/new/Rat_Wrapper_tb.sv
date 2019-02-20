`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/19/2019 05:27:18 PM
// Design Name: 
// Module Name: Rat_Wrapper_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Rat_Wrapper_tb(
    );
    
    logic CLK;
    logic BTNC = 0;
    logic [7:0] SWITCHES;
    logic [7:0] LEDS;
    Rat_Wrapper rat_wrapper_tb( .* );
    
    always begin
        CLK <= 0; #5;
        CLK <= 1; #5;
    end
    
    initial begin
    
    end
endmodule
