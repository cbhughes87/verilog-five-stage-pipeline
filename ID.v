`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/01/2018 02:53:39 PM
// Design Name: 
// Module Name: ID
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


module ID(Clk, Rst, controlMux, Instruction, WriteRegister, WriteData, RegWrite, signExtOut, ReadData1, ReadData2, WB, M, ALUSrc, ALUOp, RegDst, Jaddress, AddControl, PCAddress);
    input[31:0] Instruction, WriteData, PCAddress;
    input[4:0] WriteRegister;
    input Clk, Rst, RegWrite, controlMux;
    
    output [31:0] signExtOut, ReadData1, ReadData2, Jaddress;
    output ALUSrc, RegDst;
    output [1:0]  WB, AddControl;
    output [4:0] M;
    output [5:0] ALUOp;
    
    wire PCWrite;
    wire [4:0] Mout;
    wire [1:0] WBout, AddControllerout;
    wire RegDstout, PCWriteout,  ALUSrcout;
    wire [5:0] ALUOpout;
    
    SignExtension SE_1(Instruction[15:0], signExtOut);
    signextend26 SE_2(Instruction[25:0], Jaddress);
    Controler cont_1(Instruction, WBout, Mout, ALUOpout, ALUSrcout, RegDstout, AddControllerout, PCWriteout);
    controlerMux cmux( Mout, WBout, AddControllerout, RegDstout, PCWriteout, ALUOpout, ALUSrcout, controlMux, M, WB, AddControl, RegDst, PCWrite, ALUOp, ALUSrc );
    RegisterFile RF_1(PCWrite, PCAddress, Instruction[25:21], Instruction[20:16], WriteRegister, WriteData, RegWrite, Clk, ReadData1, ReadData2);
    
    
endmodule
