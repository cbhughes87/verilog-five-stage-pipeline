`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/14/2018 02:14:06 PM
// Design Name: 
// Module Name: Hazard
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


module Hazard(Clk, Instruction, EX_memRead, MEM_memRead, PCWrite, EX_RegRt, MEM_RegRd, IF_ID_Write, controlMux);
    input [31:0] Instruction;
    input [4:0] EX_RegRt, MEM_RegRd;
    input [1:0] EX_memRead, MEM_memRead;
    input Clk;
    
    output reg PCWrite, IF_ID_Write, controlMux;
 
    always @ (negedge Clk) begin
        if(EX_memRead > 0 && (EX_RegRt == Instruction[25:21] || EX_RegRt == Instruction[20:16])) begin
            PCWrite <= 0;
            IF_ID_Write <= 0;
            controlMux <= 0;
        end
        else if(MEM_memRead > 0 && (MEM_RegRd == Instruction[25:21] || MEM_RegRd == Instruction[20:16])) begin
              PCWrite <= 0;
              IF_ID_Write <= 0;
              controlMux <= 0;
         end
         else begin
             PCWrite <= 1;
             IF_ID_Write <= 1;
             controlMux <= 1;
         end     
      
    end
endmodule
