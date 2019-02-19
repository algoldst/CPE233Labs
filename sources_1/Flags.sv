`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/07/2019 12:08:32 PM
// Design Name: 
// Module Name: Flags
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


module Flags(
    input clk,
    input c_in, z_in,
    input flg_c_set, flg_c_clr, flg_c_ld,
    input flg_z_ld,
    input flg_ld_sel,
    input flg_shad_ld,
    output c_out, z_out
    );
    
    FlagReg CFlag( .clk(clk), .dIn(c_in), .wr_en(flg_c_ld), .set(flg_c_set), .reset(flg_c_clr), .dOut(c_out) );
    FlagReg ZFlag( .clk(clk), .dIn(z_in), .wr_en(flg_z_ld), .set('0), .reset('0), .dOut(z_out) );
    
endmodule
