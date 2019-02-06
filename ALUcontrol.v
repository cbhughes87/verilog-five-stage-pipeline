`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/08/2018 02:49:30 PM
// Design Name: 
// Module Name: ALUcontrol
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


module ALUcontrol(ALUOp, SignEx, out);
    input [5:0] SignEx;
    input [5:0] ALUOp;
    
    output reg [5:0] out;
    
    always @ (*) begin
       
        if(ALUOp == 0) begin
            if (SignEx == 6'b100000) begin //ADD
                out <= 1;
            end
            else if (SignEx == 6'b100001) begin //ADDU
                out <= 26;
            end
            else if(SignEx == 6'b100010) begin //SUB
                out <= 2;
            end
            else if(SignEx == 6'b011000) begin //MULT
                out <= 28;
            end
            else if(SignEx == 6'b011001) begin //MULTU
               out <= 31;
            end
            else if(SignEx == 6'b100100) begin //AND
                out <= 6;
            end
            else if(SignEx == 6'b100101) begin //OR
                out <= 7;
            end
            else if (SignEx == 6'b100111) begin //NOR
                out <= 8;
            end
            else if (SignEx == 6'b100110) begin //XOR
                out <= 9;
            end
            else if (SignEx == 6'b000100) begin //SLLV
                out <= 11;
            end 
            else if (SignEx == 6'b000000 ) begin //SLL
                out <= 23;
            end
            else if (SignEx == 6'b000011 || SignEx == 6'b000111) begin //SRA, SRAV 
                out <= 12;
            end
            else if(SignEx == 6'b000110) begin //SRLV or ROTRV
                out <= 12;
            end
            else if(SignEx == 6'b000010) begin //SRL or ROTR
                out <= 25;
            end
            else if(SignEx == 6'b101010) begin //SLT
                out <= 13;
            end
            else if (SignEx == 6'b001011) begin //MOVN
                out <= 14;
            end
            else if (SignEx == 6'b001010) begin //MOVZ
                out <= 15;
            end
            else if (SignEx == 6'b010001) begin //MTHI
                out <= 19;
            end
            else if (SignEx == 6'b010011) begin //MTLO
                out <= 20;
            end
            else if(SignEx == 6'b010000) begin //MFHI
                out <= 21;
            end
            else if(SignEx == 6'b010010) begin //MFLO
                out <= 22;
            end
            else begin
                out <= 0;
            end
        end
        else begin
            out <= ALUOp;
        end
        
    
    end
    
endmodule
