`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/03/2018 02:14:09 PM
// Design Name: 
// Module Name: Controler
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


module Controler(Instruction, WB, M, ALUOp, ALUSrc, RegDst, AddController, PCWrite);
  input [31:0] Instruction;

  output reg [5:0] ALUOp;
  output reg ALUSrc, RegDst, PCWrite;
  output reg [1:0] WB, AddController;
  output reg [4:0] M;
  // M = {Branch, MemWrite, MemRead};
  // WB = {RegWrite,MEMtoReg}
  //AddController is for jump addresses
  
  always @(*) begin
         ALUOp <= 5'b00000;
         ALUSrc <= 1'b0;
         RegDst <= 1'b0;
         WB <= 2'b00;
         M <= 5'b00000;
         AddController <= 0;
         PCWrite <= 0;
   if(Instruction == 0) begin
        ALUOp <= 5'b00000;
          ALUSrc <= 1'b0;
          RegDst <= 1'b0;
          WB <= 2'b00;
          M <= 5'b00000;
   end
   else if(Instruction[31:26] == 6'b000000) begin
   if(Instruction[5:0] == 6'b011000 || Instruction[5:0] == 6'b011001) begin //MULT, MULTU
    WB <= 2'b01;
    ALUOp <= 0;
    ALUSrc <= 0;
    RegDst <= 1;
    M <= 5'b00000;
   end
   else begin
    ALUOp <= 0;
    ALUSrc <= 0;
    RegDst <= 1;
    WB <= 2'b11;
    M <= 5'b00000;
   end
    if(Instruction[25:21] ==5'b00000 && Instruction[5:0] == 6'b000010) begin //SRL
     ALUOp <= 24;
    end
    else if(Instruction[25:21] ==5'b00001 && Instruction[5:0] == 6'b000010 ) begin //ROTR
      ALUOp <= 25;
    end
    else if(Instruction[25:21] ==5'b00000 && Instruction[5:0] == 6'b000011) begin //SRA
     ALUOp <= 24;
    end
    else if(Instruction[10:6] ==5'b00000 && Instruction[5:0] == 6'b101011) begin //SLTU
      ALUOp <= 18;
     end
     else if(Instruction[10:6] ==5'b00001 && Instruction[5:0] == 6'b000110) begin //SRLV
      ALUOp <= 30;
     end
     else if (Instruction[5:0] == 6'b010001 || Instruction[5:0] == 6'b010011 || Instruction[5:0] == 6'b011000 || Instruction[5:0] == 6'b011001) begin //MTHI, MTLO, MULT, MULTU
     WB <= 2'b01;
     end
     else if(Instruction[20:11] == 0 && Instruction[5:0] == 6'b001000) begin // JR
        AddController <= 1;
        ALUOp <= 37;
        ALUSrc <= 1'b0;
        RegDst <= 1'b0;
        WB <= 2'b00;
        M <= 5'b10000;
     end
  end
   else if(Instruction[31:26] == 6'b001001) begin //ADDIU
     ALUOp <= 26;
     ALUSrc <= 1;
     RegDst <= 0;
     WB <= 2'b11;
     M <= 5'b00000;
   end
   else if(Instruction[31:26] == 6'b001000) begin //ADDI
        ALUSrc <= 1;
        ALUOp <= 1;
        RegDst <= 0;
        WB <= 2'b11;
        M <= 3'b000;
    end
    else if(Instruction[31:26] == 6'b001100) begin //ANDI
        ALUSrc <= 1;
        ALUOp <= 29;
        RegDst <= 0;
        WB <= 2'b11;
        M <= 5'b00000;
    end
    else if(Instruction[31:26] == 6'b011111 && Instruction[10:6] == 5'b11000 && Instruction[5:0] == 6'b100000) begin //SEH
            ALUOp <= 10;
            ALUSrc <= 0;
            RegDst <= 1;
            WB <= 2'b11;
            M <= 5'b00000;
        end
    else if (Instruction[31:26] == 6'b011111 && Instruction[10:6] == 5'b10000 && Instruction[5:0] == 6'b100000) begin //SEB
        ALUOp <= 17;
        ALUSrc <= 0;
        RegDst <= 1;
        WB <= 2'b11;
        M <= 5'b00000;
    end
    else if(Instruction[31:26] == 6'b001101) begin //ORI
        ALUSrc <= 1;
        ALUOp <= 7;
        RegDst <= 0;
        WB <= 2'b11;
        M <= 5'b00000;
    end
    else if(Instruction[31:26] == 6'b001110) begin //XORI
        ALUSrc <= 1;
        ALUOp <= 9;
        RegDst <= 0;
        WB <= 2'b11;
        M <= 5'b00000;
    end
    else if(Instruction[31:26] == 6'b001010) begin //SLTI
        ALUSrc <= 1;
        ALUOp <= 13;
        RegDst <= 0;
        WB <= 2'b11;
        M <= 5'b00000;
    end
    else if(Instruction[31:26] == 6'b001011) begin //SLTIU
        ALUSrc <= 0;
        ALUOp <= 18;
        RegDst <= 0;
        WB <= 2'b11;
        M <= 5'b00000;
    end
    
    //check rest with TA
    else if(Instruction[31:26] == 6'b011100 && Instruction[5:0] == 6'b000000) begin //MADD
      ALUOp <= 4;
      ALUSrc <= 0;
      RegDst <= 1'b0;
      WB <= 2'b01;
      M <= 5'b00000;
    end
    else if(Instruction[31:26] == 6'b011100 && Instruction[5:0] == 6'b000010) begin //MUL
      ALUOp <= 3;
      ALUSrc <= 0;
      RegDst <= 1;
      WB <= 2'b11;
      M <= 5'b00000;
    end
    else if(Instruction[31:26] == 6'b011100 && Instruction[5:0] == 6'b000100) begin //MSUB
          ALUOp <= 5;
          ALUSrc <= 0;
          RegDst <= 1'bx;
          WB <= 2'b01;
          M <= 5'b00000;
        end
    else if(Instruction[31:26] == 6'b100011) begin //LW
           ALUOp <= 1;
           ALUSrc <= 1'b1;
           RegDst <= 1'b0;
           WB <= 2'b10;
           M <= 5'b00001;
    end
    else if(Instruction[31:26] == 6'b101011) begin //SW
       ALUOp <= 1;
       ALUSrc <= 1'b1;
       RegDst <= 1'b0;
       WB <= 2'b0x;
       M <= 5'b00100;
    end
    else if(Instruction[31:26] == 6'b101000) begin //SB How to store just a byte though?
        ALUOp <= 1;
        ALUSrc <= 1'b1;
        RegDst <= 1'b0;
        WB <= 2'b0x;
        M <= 5'b01000;
    end
    else if(Instruction[31:26] == 6'b100000) begin //LB
        ALUOp <= 1;
        ALUSrc <= 1'b1;
        RegDst <= 1'b0;
        WB <= 2'b10;
        M <= 5'b00010;
    end
    else if(Instruction[31:26] == 6'b100001) begin //LH
       ALUOp <= 1;
       ALUSrc <= 1'b1;
       RegDst <= 1'b0;
       WB <= 2'b10;
       M <= 5'b00011;
    end
    else if(Instruction[31:26] == 6'b101001) begin //SH
        ALUOp <= 1;
        ALUSrc <= 1'b1;
        RegDst <= 1'b0;
        WB <= 2'b0x;
        M <= 5'b01100;
    end
    else if(Instruction[31:26] == 6'b001111 && Instruction[25:21] == 0) begin //Lui
        ALUOp <= 16;
        ALUSrc <= 1'b1;
        RegDst <= 1'b0;
        WB <= 2'b11;
        M <= 5'b00000;
    end
    else if(Instruction[31:26] == 6'b000001 && Instruction[20:16] == 5'b00001) begin //BGEZ        
        ALUOp <= 27;
        ALUSrc <= 1'bx;
        RegDst <= 1'b0;
        WB <= 2'b00;
        M <= 5'b10000;
    end
    else if(Instruction[31:26] == 6'b000100) begin //BEQ
        ALUOp <= 32;
        ALUSrc <= 1'b0;
        RegDst <= 1'b0;
        WB <= 2'b00;
        M <= 5'b10000;  
    end
    else if(Instruction[31:26] == 6'b000101) begin //BNE
        ALUOp <= 33;
        ALUSrc <= 1'b0;
        RegDst <= 1'b0;
        WB <= 2'b00;
        M <= 5'b10000;   
    end
    else if(Instruction[31:26] == 6'b000111 && Instruction[20:16] == 0) begin //BGTZ
        ALUOp <= 34;
        ALUSrc <= 1'b0;
        RegDst <= 1'b0;
        WB <= 2'b00;
        M <= 5'b10000;
    end
    else if(Instruction[31:26] == 6'b000110 && Instruction[20:16] == 0) begin //BLEZ
        ALUOp <= 35;
        ALUSrc <= 1'b0;
        RegDst <= 1'b0;
        WB <= 2'b00;
        M <= 5'b10000; 
    end
    else if(Instruction[31:26] == 6'b000001 && Instruction[20:16] == 0) begin //BLTZ
        ALUOp <= 36;
        ALUSrc <= 1'b0;
        RegDst <= 1'b0;
        WB <= 2'b00;
        M <= 5'b10000; 
    end
    else if(Instruction[31:26] == 6'b000010) begin //J
        ALUOp <= 37;
        ALUSrc <= 1'b0;
        RegDst <= 1'b0;
        WB <= 2'b00;
        M <= 5'b10000;
        AddController <= 2;
    end
    else if(Instruction[31:26] == 6'b000011) begin //JAL
        PCWrite <= 1;
        ALUOp <= 37;
        ALUSrc <= 1'b0;
        RegDst <= 1'b0;
        WB <= 2'b00;
        M <= 5'b10000;
        AddController <= 2;

    end

  end
  
  
endmodule
