`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/17/2018 03:31:38 PM
// Design Name: 
// Module Name: MEM_WB_REG
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


module MEM_WB_REG(Rst, Clk, WBin, ReadData, ALUResult, WriteReg, MEMtoReg, RegWrite, ReadDataout, ALUResultout, WriteRegout, Lo, Hi, Loout, Hiout);
  input Rst, Clk;
  input [1:0] WBin;
  input [31:0] ReadData, ALUResult, Lo, Hi;
  input [4:0] WriteReg;
  
  output reg MEMtoReg, RegWrite;
  output reg [31:0] ReadDataout, ALUResultout, Loout, Hiout;
  output reg [4:0] WriteRegout;
  
  
  always @(posedge Clk) begin
    MEMtoReg <= WBin[0];
    RegWrite <= WBin[1];
    ReadDataout <= ReadData;
    ALUResultout <= ALUResult;
    WriteRegout <= WriteReg;
    Loout <= Lo;
    Hiout <= Hi;
  end


endmodule
