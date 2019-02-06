`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/31/2018 02:30:15 PM
// Design Name: 
// Module Name: forward
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


module forward(Clk, Rs, Rt, EX_MEM_RegWrite, EX_MEM_RegRd, MEM_WB_RegWrite, MEM_WB_Rd, MuxA, MuxB);
    input [4:0] Rs, Rt, EX_MEM_RegRd, MEM_WB_Rd;
    input EX_MEM_RegWrite, Clk, MEM_WB_RegWrite;
    output reg [1:0] MuxA, MuxB;
    
    always @(*) begin
        MuxA = 0;
        MuxB = 0;
         if(MEM_WB_RegWrite == 1) begin
           if(Rs == MEM_WB_Rd) begin
             MuxA = 2;
           end
           if(Rt == MEM_WB_Rd) begin
             MuxB = 2;        
           end
       end
        if(EX_MEM_RegWrite == 1) begin
            if(Rs == EX_MEM_RegRd) begin
              MuxA = 1;
            end
            if (Rt == EX_MEM_RegRd) begin
             MuxB = 1;
            end
        end
       
    end


endmodule
