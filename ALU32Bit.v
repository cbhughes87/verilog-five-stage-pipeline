`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - ALU32Bit.v
// Description - 32-Bit wide arithmetic logic unit (ALU).
//
// INPUTS:-
// ALUControl: N-Bit input control bits to select an ALU operation.
// A: 32-Bit input port A.
// B: 32-Bit input port B.
//
// OUTPUTS:-
// ALUResult: 32-Bit ALU result output.
// ZERO: 1-Bit output flag. 
//
// FUNCTIONALITY:-
// Design a 32-Bit ALU, so that it supports all arithmetic operations 
// needed by the MIPS instructions given in Labs5-8.docx document. 
//   The 'ALUResult' will output the corresponding result of the operation 
//   based on the 32-Bit inputs, 'A', and 'B'. 
//   The 'Zero' flag is high when 'ALUResult' is '0'. 
//   The 'ALUControl' signal should determine the function of the ALU 
//   You need to determine the bitwidth of the ALUControl signal based on the number of 
//   operations needed to support. 
////////////////////////////////////////////////////////////////////////////////

module ALU32Bit(ALUControl, B, A, HiLo, Lo, Hi, ALUResult, Zero, Rst, Clk, instruction10_6, Write);

	input [5:0] ALUControl; // control bits for ALU operation
                                // you need to adjust the bitwidth as needed
	input [31:0] A, B;	    // inputs
	input [63:0] HiLo;
	input [4:0] instruction10_6;
	
	input Rst, Clk;

	output reg [31:0] ALUResult, Lo, Hi;	// answer
	output reg Zero, Write;	    // Zero=1 if ALUResult == 0

    reg [63:0] intHiLo, temp;
    reg [31:0] temp1;

    always @(*) begin
    Lo = HiLo[31:0];
    Hi = HiLo[63:32];
    Zero = 0;
     if(ALUControl == 1) begin
       ALUResult <= A + B;
       Write <= 0;
     end
     else if (ALUControl == 2) begin
       ALUResult <= A-B;
       Write <= 0;
     end
     else if (ALUControl == 3) begin
       temp <= A*B;
       ALUResult <= temp[31:0];
        Write <= 0;  
      end
      else if (ALUControl == 4) begin
        intHiLo = $signed(A*B);
        temp = intHiLo + HiLo;
         Hi <= temp[63:32];
         Lo <= temp[31:0];
        Write <= 1;
      end
      else if (ALUControl == 5) begin
         intHiLo = $signed(A*B);
       temp = (HiLo) - intHiLo ;
        Hi <= temp[63:32];
        Lo <= temp[31:0];
       Write <= 1;
      end
     else if(ALUControl == 6) begin
        ALUResult <= A & B;
        Write <= 0;
     end
     else if(ALUControl == 7) begin
          ALUResult <= A | B;
          Write <= 0;
     end
     else if(ALUControl == 8 ) begin
          ALUResult <= ~(A | B);
          Write <= 0;
     end
     else if(ALUControl == 9) begin
          ALUResult <= (A^B);
          Write <= 0;
     end
     else if(ALUControl == 10) begin
      if (B[15] == 0) begin
        ALUResult <= {16'b0000000000000000, B[15:0]};
      end
      else begin
        ALUResult <= {16'b1111111111111111, B[15:0]};
      end
      Write <= 0;
     end
     else if(ALUControl == 11) begin
          ALUResult <= B << A;
          Write <= 0;
     end
     else if(ALUControl == 12 ) begin
         ALUResult <= B >> A;
         Write <= 0; 
     end
     else if(ALUControl == 13) begin
       ALUResult <= (A < B);
       Write <= 0;
     end
     else if(ALUControl == 14) begin
        if(B != 0) begin
          ALUResult <= A;
        end 
        else begin
         ALUResult <= 0;
        end
        Write <= 0;
     end
     else if(ALUControl == 15) begin
          if(B == 0) begin
            ALUResult <= A;
          end
          else begin
          ALUResult <= 0;
          end
          Write <= 0;
     end
     else if(ALUControl == 16) begin
            ALUResult <= B << 16;
            Write <= 0;
     end
     else if (ALUControl == 17)begin
       if (B[7] == 0) begin
             ALUResult <= {24'b000000000000000000000000, B[7:0]};
       end
       else begin
             ALUResult <= {24'b111111111111111111111111, B[7:0]};
       end
       Write <= 0;
     end
     else if (ALUControl == 18)begin
       if(A < {1'b0,B}) begin
         ALUResult <= 1;
       end
       else begin
         ALUResult <= 0;
         end
         Write <= 0;
     end
     else if (ALUControl == 20 )begin
       Lo <= A; 
       Hi <= HiLo[63:32];
       Write = 1;
     end
     else if (ALUControl == 19)begin
       Hi <= A;
       Lo <= HiLo[31:0];
       Write = 1;
     end
     else if (ALUControl == 21)begin
              ALUResult <= HiLo[63:32];
              Write <= 0;
      end
      else if (ALUControl == 22 )begin
             ALUResult <= HiLo[31:0];
             Write <= 0;
      end
     else if (ALUControl == 23 )begin
        ALUResult <= B << instruction10_6;
        Write <= 0;
     end
     else if (ALUControl == 24 )begin
         ALUResult <= B >> instruction10_6;
         Write <= 0;
      end
     else if(ALUControl == 25) begin
       ALUResult <= (B >> instruction10_6) | (B << (32-instruction10_6));
       Write <= 0;
     end
     else if(ALUControl == 26) begin
       ALUResult <= A + {1'b0, B};
       Write <= 0;
     end
     else if(ALUControl == 27) begin //BGEZ
        if($signed(A) >= 0) begin
         ALUResult <= 0;
         Zero <= 1;
        end
        else begin
        ALUResult <= 1;
        Zero <= 0;
        end
     end
     else if (ALUControl == 28) begin
        intHiLo = $signed(A*B);
        Hi <= intHiLo[63:32];
        Lo <= intHiLo[31:0];
         Write <= 1;  
         ALUResult <= 0;
       end
     else if (ALUControl == 29) begin
       temp1 = {16'd0, B[15:0]};
       ALUResult <= A &  temp1;
       Write <= 0;
     end
      else if(ALUControl == 30) begin
       ALUResult <= (B >> A) | (B << (32-A));
       Write <= 0;
     end
     else if(ALUControl == 31) begin
        intHiLo = (A|0) * (B|0);
        Lo <= intHiLo[31:0];
        Hi <= intHiLo[63:32];
        Write <= 1;
     end
      else if(ALUControl == 32) begin //BEQ
        if(A == B) begin
         ALUResult <= 0;
         Zero <= 1;
        end
        else begin
        ALUResult <= 1;
        Zero <= 0;
        end
     end
     else if(ALUControl == 33) begin //BNE
        if(A != B) begin
         ALUResult <= 0;
         Zero <= 1;
        end
        else begin
        ALUResult <= 1;
        Zero <= 0;
        end
     end
     else if(ALUControl == 34) begin //BGTZ
       if($signed(A) > 0) begin
        ALUResult <= 0;
        Zero <= 1;
       end
       else begin
       ALUResult <= 1;
       Zero <= 0;
       end
    end
    else if(ALUControl == 35) begin //BLEZ
      if($signed(A) <= 0) begin
       ALUResult <= 0;
       Zero <= 1;
      end
      else begin
      ALUResult <= 1;
      Zero <= 0;
      end
   end
   else if(ALUControl == 36) begin //BLTZ
     if($signed(A) < 0) begin
      ALUResult <= 0;
      Zero <= 1;
     end
     else begin
     ALUResult <= 1;
     Zero <= 0;
     end
  end
  else if(ALUControl == 37) begin
    Zero <= 1;
  end
     else begin
       ALUResult <= 0;
       Write <= 0;
     end

    end

endmodule

