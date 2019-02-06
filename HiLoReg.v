`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/18/2018 01:25:59 PM
// Design Name: 
// Module Name: HiLoReg
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


module HiLoReg(Clk, Rst, Write, Lo, Hi, LoOut,HiOut);
    input Write, Clk, Rst;
    input [31:0] Lo, Hi;
    
    output reg [31:0] LoOut, HiOut;
    
    reg [31:0] LoHold, HiHold;
    
    initial begin
     LoHold <= 0;
     HiHold <= 0;
    end

    always @(posedge Clk) begin
          if(Write == 1) begin
            LoHold <= Lo;
            HiHold <= Hi;
          end
          
        end
        
     always@(*) begin
       LoOut <= LoHold;
       HiOut <= HiHold;
     end
endmodule
