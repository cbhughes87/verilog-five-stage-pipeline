`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/10/2018 02:20:23 PM
// Design Name: 
// Module Name: MEM
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


module MEM(Rst, Clk, ALUResult, ReadData2, MemWrite, MemRead, ReadData1, branch, PCSrc, zero);
    input [31:0] ALUResult, ReadData2;
    input Clk, Rst, branch, zero;
    input [1:0] MemRead, MemWrite;
    
    output [31:0] ReadData1;
    output PCSrc;
    
    DataMemory DataMemory_1(ALUResult, ReadData2, Clk, MemWrite, MemRead, ReadData1);
    Branch branch_1(branch, zero, PCSrc);

endmodule
