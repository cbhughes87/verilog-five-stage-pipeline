`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/03/2018 02:41:02 PM
// Design Name: 
// Module Name: IF2
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


module IF2(Rst, Clk, PCWrite, Instruction, PCSrc, JumpAddress, PCAddResult, PCResult);

    input Rst, Clk, PCSrc, PCWrite;
    input[31:0] JumpAddress;
    output [31:0] PCAddResult,Instruction, PCResult;
    
    wire[31:0] out;
    
    PCAdder PCAdder_1( PCResult, PCAddResult);
    Mux32Bit2To1 mux_1(out, PCAddResult, JumpAddress, PCSrc);
    ProgramCounter ProgramCounter_1(PCWrite, out, PCResult, Rst, Clk);
    InstructionMemory InstructionMemory_1(PCResult, Instruction);
endmodule
