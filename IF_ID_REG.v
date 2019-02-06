`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/17/2018 02:40:20 PM
// Design Name: 
// Module Name: IF_ID_REG
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


module IF_ID_REG(Clk, Rst, PCSrc, IF_ID_Write, addIn, addOut, IMin, IMout);
    input Clk, Rst, IF_ID_Write, PCSrc;
    input [31:0] addIn, IMin;
    
    output reg [31:0] addOut, IMout;
    
    always @ (posedge Clk) begin
      addOut = 0;
      IMout = 0;
        if(IF_ID_Write == 1 && PCSrc == 0) begin
          addOut <= addIn;
          IMout <= IMin;
        end
    end
endmodule
