`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/28/2019 12:03:53 PM
// Design Name: 
// Module Name: KeyPadDriver
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


module KeyPadDriver #(parameter clkDiv = 22727270)(    // Use clkDiv = 22727270 for 22 Hz clkdiv
    input clk,
    input C, A, E,  // columns 0,1,2 << PMOD
    output [7:0] seg,   // sseg segments
    output [3:0] an,    // sseg digit on/off
    output B, G, F, D,  // rows B,G,F,D >> PMOD
    output interrupt
    );
    
    // Clock Divider to create 22 MHz Clock //////////////////////////////////
    logic [22:0] s_clkCounter = 0;
    logic s_clk = 0;
    always_ff @(posedge clk) begin
        s_clkCounter = s_clkCounter + 1;
        if(s_clkCounter >= clkDiv) begin
            s_clk <= ~s_clk;
            s_clkCounter <= 0;
        end
    end
    
    // Key FSM and KeyPressReg
    logic [3:0] t_keyOut_imm, t_keyOut;
    logic t_press;
    KeyFsm keyFsm(.clk(s_clk), .C(C), .A(A), .E(E), .B(B), .G(G), .F(F), .D(D), .press(t_press), .keyOut(t_keyOut_imm));
    DReg #(4) keyPressReg(.clk(s_clk), .dIn(t_keyOut_imm), .ld(t_press), .set(0), .clr(0), .dOut(t_keyOut));
    
    // Interrupt FSM -- Sends interrupt signal for 60ns = 3 MCU clock cycles
    InterruptFsm interruptFsm(.clk(clk), .press(t_press), .interrupt(interrupt));
    
    // SSEG Driver
    SevSegDisp sseg(.CLK(clk), .MODE(0), .DATA_IN(t_keyOut), .CATHODES(seg), 
                    .ANODES(an) );  
    
endmodule
