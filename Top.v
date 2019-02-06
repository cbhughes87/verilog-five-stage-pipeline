`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// 50/50 Sarah Wiltbank, Christopher Hughes

// Create Date: 10/13/2018 08:56:08 AM
// Design Name: 
// Module Name: Top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
//      Pipline has 5 stages
//      Memory stage has branch decisions
//      Forwarding in EX stage
//      Hazard in ID stage
//
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Top(Rst, Clk, PCAddResult, PCMux, Hi, Lo, WriteData, ALUResult );
    input Rst, Clk;
    output [31:0] PCAddResult, PCMux, Hi, Lo, WriteData, ALUResult;

    wire [31:0] Instin, Instruction, addOutIF_Reg, WriteData, ReadData1, ReadData2, signExtOut, BranchADDoutID_Reg, BranchAddout, MEMReadData, ReadData1outtomux, ReadData2outtomux, MEMReadDataout;
    wire [31:0] Jaddress, Jaddressout, ReadData1out, ReadData2out, extendInstruction15_0out, Loout, Hiout, LO, HI, AddOut, ReadData2MEMout, ALUResultoutMEM_Reg, ALUResultOut;
    wire [5:0] ALUOp, ALUOpout;
    wire [4:0] WriteRegister, Instruction20_16out, Instruction15_11out,Instruction25_21out, writeRegout, WriteRegMEMout;
    wire [4:0] M, Mout;
    wire [1:0] WB, WBout, WBMEMout, AddControl, AddControlOut, MemWrite, MemRead, MuxA, MuxB;
    wire PCSrc,LoWrite, HiWrite, RegWrite, ALUSrc, RegDst, RegDstout, ALUSrcout, Zero, ZeroOut, MBranch, MEMtoReg;
    wire PCWrite, IF_ID_Write, controlMux;

    IF2 IF2_1(Rst, Clk, PCWrite, Instin, PCSrc, BranchAddout, PCAddResult, PCMux);
    
    IF_ID_REG IF_ID_REG_1(Clk, Rst, PCSrc, IF_ID_Write, PCAddResult, addOutIF_Reg, Instin, Instruction);
    
    Hazard h1(Clk, Instruction, Mout[1:0], MemRead, PCWrite, Instruction20_16out, WriteRegMEMout, IF_ID_Write, controlMux);
    
    ID ID_1(Clk, Rst, controlMux, Instruction, WriteRegister, WriteData, RegWrite, signExtOut, ReadData1, ReadData2, WB, M, ALUSrc, ALUOp, RegDst, Jaddress, AddControl, addOutIF_Reg);
    
    ID_EX_REG ID_EX_REG_1(Clk, Rst, PCSrc, Instruction[25:21], AddControl, Jaddress, WB, M, addOutIF_Reg, ReadData1, ReadData2, signExtOut, Instruction[20:16], Instruction[15:11], RegDst, ALUOp, ALUSrc, WBout, Mout, BranchADDoutID_Reg, ReadData1outtomux, ReadData2outtomux, extendInstruction15_0out, Instruction20_16out, Instruction15_11out, RegDstout, ALUOpout, ALUSrcout, Jaddressout, AddControlOut, Instruction25_21out);    
    //forwarding
    forward fw1(Clk,Instruction25_21out, Instruction20_16out, WBMEMout[1], WriteRegMEMout, RegWrite, WriteRegister, MuxA, MuxB);
    //muxA, MuxB
    Mux32Bit3to1 muxa(ReadData1out, ReadData1outtomux, ALUResultoutMEM_Reg, WriteData, MuxA);
    
    Mux32Bit3to1 muxb(ReadData2out, ReadData2outtomux, ALUResultoutMEM_Reg, WriteData, MuxB);

    EX EX_1(Clk, Rst, AddControlOut, Jaddressout, ALUSrcout, ALUOpout, extendInstruction15_0out, ReadData1out, ReadData2out, Instruction20_16out, Instruction15_11out, RegDstout, writeRegout, BranchADDoutID_Reg, AddOut, ALUResult, LO, HI, extendInstruction15_0out[10:6], Zero);
    
    EX_MEM_REG EX_MEM_REG_1(Rst, Clk, PCSrc, WBout, Mout, AddOut, ALUResult, Zero, writeRegout, ReadData2out, WBMEMout, MBranch, MemWrite, MemRead, BranchAddout, ALUResultoutMEM_Reg, ZeroOut, WriteRegMEMout, ReadData2MEMout, LO, HI, Loout, Hiout);
    
    MEM MEM_1(Rst, Clk, ALUResultoutMEM_Reg, ReadData2MEMout, MemWrite, MemRead, MEMReadData, MBranch, PCSrc, ZeroOut);
    
    MEM_WB_REG MEM_WB_REG_1(Rst, Clk, WBMEMout, MEMReadData, ALUResultoutMEM_Reg, WriteRegMEMout, MEMtoReg, RegWrite, MEMReadDataout, ALUResultOut, WriteRegister, Loout, Hiout, Lo, Hi);
    
    WB WB_1(Clk, Rst, MEMReadDataout, ALUResultOut, WriteData, MEMtoReg);
endmodule
