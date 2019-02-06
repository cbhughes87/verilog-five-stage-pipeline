`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/17/2018 03:05:42 PM
// Design Name: 
// Module Name: EX_MEM_REG
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


module EX_MEM_REG(Rst, Clk,PCSrc, WBin, Min, BranchAdd, ALUResult, ALUZero, WriteReg, ReadData2, WBout, MBranch, MEMWrite, MEMRead, BranchAddout, ALUResultout, ALUZeroout, WriteRegout, ReadData2out, LO, HI, Loout, Hiout);
  input [1:0] WBin;
  input [4:0] Min;
  input [31:0] BranchAdd, ALUResult, LO, HI;
  input ALUZero, Rst, Clk, PCSrc;
  input [4:0] WriteReg;
  input [31:0] ReadData2;
  
  output reg [1:0] WBout,  MEMWrite, MEMRead;
  output reg MBranch;
  output reg [31:0] BranchAddout, ALUResultout, Loout, Hiout;
  output reg ALUZeroout;
  output reg [4:0] WriteRegout;
  output reg [31:0] ReadData2out;
  
  always @(posedge Clk) begin
  if(PCSrc == 1) begin
      WBout <= 0;
      MBranch <= 0;
      MEMWrite <= 0;
      MEMRead <= 0;
      BranchAddout <= 0;
      ALUResultout <= 0;
      ALUZeroout <= 0;
      WriteRegout <= 0;
      ReadData2out <= 0;
      Loout <= 0;
      Hiout <= 0;
  end
  else begin
    WBout <= WBin;
    MBranch <= Min[4];
    MEMWrite <= Min[3:2];
    MEMRead <= Min[1:0];
    BranchAddout <= BranchAdd;
    ALUResultout <= ALUResult;
    ALUZeroout <= ALUZero;
    WriteRegout <= WriteReg;
    ReadData2out <= ReadData2;
    Loout <= LO;
    Hiout <= HI;
    end
  end


endmodule
