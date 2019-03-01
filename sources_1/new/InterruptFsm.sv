`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/28/2019 01:44:26 PM
// Design Name: 
// Module Name: InterruptFsm
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


module InterruptFsm(
    input clk, press,
    output logic interrupt
    );
    
    typedef enum{START, INTERRUPT, RELOAD} State;
    State NS = START, PS = START;
    
    logic [2:0] cycleCounter = 0;
    always_ff @(posedge clk) begin
        PS <= NS;
        case(PS)
            START: begin                        // Loops until key "press" signal is received
                if(press) NS <= INTERRUPT;
                else NS <= START;
            end
            INTERRUPT: begin                    // Outputs interrupt high for 60ns, then goes to RELOAD
                interrupt <= 1;
                
                cycleCounter <= cycleCounter + 1;
                if(cycleCounter < 6) NS <= INTERRUPT;
                else begin
                    NS <= RELOAD;
                    if(!press) NS <= START;
                    cycleCounter = 0;
                end
            end
            RELOAD: begin                       // Interrupt low, doesn't return to START until "press" turns off.
                interrupt <= 0;
                if(press) NS <= RELOAD;
                else NS <= START;
            end
        endcase
    end
    
endmodule
