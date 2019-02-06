`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/03/2018 02:49:07 PM
// Design Name: 
// Module Name: EX
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


module EX(Clk, Rst, AddControl, Jin, ALUSrc, ALUOp, signExIn, ReadData1, ReadData2, inst20to16, inst15to11, RegDst, writeReg, addIn, addOut, ALUResult, Lo, Hi, instruction10_6, Zero);
    
    input [31:0] ReadData1, ReadData2, signExIn, addIn;
    input [31:0] Jin;
    input RegDst, ALUSrc, Clk, Rst;
    input [4:0] inst20to16, inst15to11, instruction10_6;
    input [5:0] ALUOp;
    input [1:0] AddControl;
    
    output [31:0] addOut, ALUResult, Lo, Hi;
    output [4:0] writeReg;
    output Zero;
    
    wire [31:0] muxOut,  LoOut, HiOut, shiftOut;
    wire [5:0] ALUcontrolOut;
    wire Write;
    wire [31:0] Jaddress;
    
    Mux5Bit2To1 mux_1(writeReg, inst20to16, inst15to11, RegDst);
    Mux32Bit2To1 mux_2(muxOut, ReadData2, signExIn, ALUSrc);
    ALUcontrol ALUcontrol_1(ALUOp, signExIn[5:0], ALUcontrolOut);
    ALU32Bit ALU_1(ALUcontrolOut,  muxOut, ReadData1, {HiOut,LoOut}, Lo, Hi, ALUResult, Zero, Rst, Clk, instruction10_6, Write);
    HiLoReg HiLoReg_1(Clk, Rst, Write, Lo, Hi, LoOut,HiOut);
    ShiftLeft2 shift_1(signExIn,shiftOut);
    ShiftLeft2 shift_2(Jin, Jaddress);
    Add add_1(addIn, shiftOut, AddControl, ReadData1, Jaddress, addOut);

    
    
endmodule
