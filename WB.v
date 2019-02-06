`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/10/2018 02:43:46 PM
// Design Name: 
// Module Name: WB
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


module WB(Clk, Rst, ReadData, ALUout, WriteData, MEMtoReg);
    input Clk, Rst;
    input [31:0] ReadData, ALUout;
    input MEMtoReg;
    
    output [31:0] WriteData;
    
    Mux32Bit2To1 mux_1(WriteData, ReadData, ALUout, MEMtoReg);
    
endmodule
