`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/17/2018 02:41:13 PM
// Design Name: 
// Module Name: ID_EX_REG
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


module ID_EX_REG(Clk, Rst, PCSrc, instruc25to21, AddControl, Jaddress, WBin, Min, BranchADDin, ReadData1, ReadData2, extendInstruction15_0, Instruction20_16, Instruction15_11, RegDst, ALUOp, ALUSrc, WBout, Mout, BranchADDout, ReadData1out, ReadData2out, extendInstruction15_0out, Instruction20_16out, Instruction15_11out, RegDstout, ALUOpout, ALUSrcout, Jout, AddControlOut, instruc25to21out);
 input [1:0] WBin, AddControl;
 input [4:0] Min;
 input [31:0] extendInstruction15_0, Jaddress, ReadData1, ReadData2, BranchADDin;
 input [5:0]  ALUOp;
 input [4:0] Instruction20_16, Instruction15_11, instruc25to21;
 input RegDst, ALUSrc, Clk, Rst, PCSrc;
 
 output reg [1:0] WBout, AddControlOut;
 output reg [4:0] Mout;
 output reg [31:0] Jout, extendInstruction15_0out, BranchADDout, ReadData1out, ReadData2out;
 output reg [5:0] ALUOpout;
 output reg [4:0] Instruction20_16out, Instruction15_11out, instruc25to21out;
 output reg RegDstout, ALUSrcout;
 
 always @(posedge Clk) begin
 if(PCSrc == 1) begin
   WBout <= 0;
   Mout <=  0;
   BranchADDout <= 0;
   ReadData1out <= 0;
   ReadData2out <= 0;
   extendInstruction15_0out <= 0;
   Instruction15_11out <= 0;
   Instruction20_16out <= 0;
   RegDstout <= 0;
   ALUOpout <= 0;
   ALUSrcout <= 0;
   Jout <= 0;
   AddControlOut <= 0;
   instruc25to21out <= 0;
 end
 else begin
  WBout <= WBin;
  Mout <=  Min;
  BranchADDout <= BranchADDin;
  ReadData1out <= ReadData1;
  ReadData2out <= ReadData2;
  extendInstruction15_0out <= extendInstruction15_0;
  Instruction15_11out <= Instruction15_11;
  Instruction20_16out <= Instruction20_16;
  RegDstout <= RegDst;
  ALUOpout <= ALUOp;
  ALUSrcout <= ALUSrc;
  Jout <= Jaddress;
  AddControlOut <= AddControl;
  instruc25to21out <= instruc25to21;
  end
 end

endmodule
