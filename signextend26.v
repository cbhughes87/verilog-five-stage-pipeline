`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - SignExtension.v
// Description - Sign extension module.
////////////////////////////////////////////////////////////////////////////////
module signextend26(in, out);

    /* A 16-Bit input word */
    input [25:0] in;
    
    /* A 32-Bit output word */
    output reg [31:0] out;
    
	always@(*) begin
	if(in[25] == 1) begin
	  out <= {6'b111111, in};
	  end
	else begin
	  out <= {6'b000000, in};
	end
	end

endmodule
