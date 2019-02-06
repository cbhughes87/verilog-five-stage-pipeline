`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/19/2018 02:45:36 PM
// Design Name: 
// Module Name: controlerMux
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


module controlerMux(M, WB, AddController, RegDst, PCWrite, ALUOp, ALUSrc, controlMux, Mout, WBout, AddControllerout, RegDstout, PCWriteout, ALUOpout, ALUSrcout);
 input [4:0] M;
 input [1:0] WB, AddController;
 input RegDst, controlMux, PCWrite, ALUSrc;
 input [5:0] ALUOp;
 
 output reg [4:0] Mout;
 output reg [1:0] WBout, AddControllerout;
 output reg RegDstout, PCWriteout, ALUSrcout;
 output reg [5:0] ALUOpout;
 
 always@(*) begin
    if(controlMux == 0) begin
     Mout <= 0;
     WBout <= 0;
     AddControllerout <= 0;
     RegDstout <= 0;
     PCWriteout <= 0;
     ALUSrcout <= 0;
     ALUOpout <= 0;
    end
    else begin
     Mout <= M;
     WBout <= WB;
     AddControllerout <= AddController;
     RegDstout <= RegDst;
     PCWriteout <= PCWrite;
     ALUSrcout <= ALUSrc;
     ALUOpout <= ALUOp;
    end
 end
 
endmodule
