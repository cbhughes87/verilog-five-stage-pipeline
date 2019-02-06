`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/10/2018 02:15:12 PM
// Design Name: 
// Module Name: ShiftLeft2
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


module ShiftLeft2(in, out);
    input [31:0] in;
    output reg [31:0] out;
    
    initial begin
        out <= 0;
    end
    
    always @(*) begin
        out <= in << 2;
     end
        
endmodule
