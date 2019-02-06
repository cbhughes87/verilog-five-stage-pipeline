`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/22/2018 11:48:37 AM
// Design Name: 
// Module Name: Branch
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


module Branch(branch, zero, PCSrc);
    input branch, zero;
    output reg PCSrc;
    
    always @(*) begin
        if(branch == 1 && zero == 1) begin
            PCSrc <= 1;
        end
        else begin
            PCSrc <= 0; 
        end
    end
endmodule
