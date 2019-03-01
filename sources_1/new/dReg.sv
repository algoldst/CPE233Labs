`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/28/2019 12:16:29 PM
// Design Name: 
// Module Name: dReg
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


module DReg #(parameter WIDTH=1)(
    input clk, ld, set, clr,
    input [WIDTH-1:0] dIn,
    output logic [WIDTH-1:0] dOut = 0
    );
    always_ff @(posedge clk) begin
        if (clr) dOut <= 0;
        else if (set) dOut <= 1;
        else if (ld) dOut <= dIn;
        else dOut <= dOut;
    end
endmodule
