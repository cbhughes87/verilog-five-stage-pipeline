`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/08/2018 02:21:16 PM
// Design Name: 
// Module Name: Mux4Bit2To1
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


module Mux32Bit3to1(out, inA, inB,inC, sel);

    output reg [31:0] out;
    
    input [31:0] inA, inB, inC;
    input [1:0] sel;

    always@(*) begin
    //out = 0;
	if(sel == 0) begin
	 out <= inA;
	end
	else if(sel == 1) begin
	 out <= inB;
	end 
	else if(sel == 2) begin
	 out <= inC;
	end

    end
endmodule
