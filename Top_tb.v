`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/16/2018 11:39:16 AM
// Design Name: 
// Module Name: Top_tb
//50/50 Sarah Wiltbank, Christopher Hughes
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
// Group memebers Christopher Hughes and Sarah Wiltbank
// Percent effort 50/50
//////////////////////////////////////////////////////////////////////////////////


module Top_tb();
    reg Clk, Rst;
    wire [31:0] PCAddResult, PCMux, Hi, Lo, WriteData, ALUResult;
    
    Top top_1(Rst, Clk, PCAddResult, PCMux, Hi, Lo, WriteData, ALUResult);
        
    
    initial begin
        Clk <= 0;
        forever #10 Clk <= ~Clk;   
    end
    
    initial begin
        Rst <= 1;
        #15 Rst <= 0;
        
    end

endmodule
