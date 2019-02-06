`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Lab D2L group 38, bench 28 
//Team Members: Christopher Hughes, Sarah Wiltbank
//Percent Effort: Christopher 50/50 Sarah
//
//
//ECE369A - Computer Architecture
// Laboratory  1
// Module - InstructionMemory.v
// Description - 32-Bit wide instruction memory.
//
// INPUT:-
// Address: 32-Bit address input port.
//
// OUTPUT:-
// Instruction: 32-Bit output port.
//
// FUNCTIONALITY:-
// Similar to the DataMemory, this module should also be byte-addressed
// (i.e., ignore bits 0 and 1 of 'Address'). All of the instructions will be 
// hard-coded into the instruction memory, so there is no need to write to the 
// InstructionMemory.  The contents of the InstructionMemory is the machine 
// language program to be run on your MIPS processor.
//
//
//we will store the machine code for a code written in C later. for now initialize 
//each entry to be its index * 3 (memory[i] = i * 3;)
//all you need to do is give an address as input and read the contents of the 
//address on your output port. 
// 
//Using a 32bit address you will index into the memory, output the contents of that specific 
//address. for data memory we are using 1K word of storage space. for the instruction memory 
//you may assume smaller size for practical purpose. you can use 128 words as the size and 
//hardcode the values.  in this case you need 7 bits to index into the memory. 
//
//be careful with the least two significant bits of the 32bit address. those help us index 
//into one of the 4 bytes in a word. therefore you will need to use bit [8-2] of the input address. 


////////////////////////////////////////////////////////////////////////////////

module InstructionMemory(Address, Instruction); 

    input [31:0] Address;        // Input Address 

    output reg [31:0] Instruction;    // Instruction at memory location Address
  
    reg[31:0] memory [0:395];
    
    initial begin
       memory[0] = 32'h23bdfffc;	//	main:		addi	$sp, $sp, -4
    memory[1] = 32'hafbf0000;    //            sw    $ra, 0($sp)
    memory[2] = 32'h34040000;    //            ori    $a0, $zero, 0
    memory[3] = 32'h34050010;    //            ori    $a1, $zero, 16
    memory[4] = 32'h34060410;    //            ori    $a2, $zero, 1040
    memory[5] = 32'h0c00001a;    //            jal    vbsme
    memory[6] = 32'h0c00000a;    //            jal    print_result
    memory[7] = 32'h8fbf0000;    //            lw    $ra, 0($sp)
    memory[8] = 32'h23bd0004;    //            addi    $sp, $sp, 4
    memory[9] = 32'h03e00008;    //            jr    $ra
    memory[10] = 32'h00402020;    //    print_result:    add    $a0, $v0, $zero
    memory[11] = 32'h34020001;    //            ori    $v0, $zero, 1
    memory[12] = 32'h00000000;    //            nop
    memory[13] = 32'h34040450;    //            ori    $a0, $zero, 1104
    memory[14] = 32'h34020004;    //            ori    $v0, $zero, 4
    memory[15] = 32'h00000000;    //            nop
    memory[16] = 32'h00602020;    //            add    $a0, $v1, $zero
    memory[17] = 32'h34020001;    //            ori    $v0, $zero, 1
    memory[18] = 32'h00000000;    //            nop
    memory[19] = 32'h34040450;    //            ori    $a0, $zero, 1104
    memory[20] = 32'h34020004;    //            ori    $v0, $zero, 4
    memory[21] = 32'h00000000;    //            nop
    memory[22] = 32'h34040450;    //            ori    $a0, $zero, 1104
    memory[23] = 32'h34020004;    //            ori    $v0, $zero, 4
    memory[24] = 32'h00000000;    //            nop
    memory[25] = 32'h03e00008;    //            jr    $ra
    memory[26] = 32'h34020000;    //    vbsme:        ori    $v0, $zero, 0
    memory[27] = 32'h34030000;    //            ori    $v1, $zero, 0
    memory[28] = 32'h23bdfffc;    //            addi    $sp, $sp, -4
    memory[29] = 32'hafbf0000;    //            sw    $ra, 0($sp)
    memory[30] = 32'h34100000;    //            ori    $s0, $zero, 0
    memory[31] = 32'h34110000;    //            ori    $s1, $zero, 0
    memory[32] = 32'h0c00003c;    //            jal    calcRightEdge
    memory[33] = 32'h0c000040;    //            jal    calcBottomEdge
    memory[34] = 32'h34140fa0;    //            ori    $s4, $zero, 4000
    memory[35] = 32'h0c00004a;    //            jal    SAD
    memory[36] = 32'h0c000044;    //            jal    checkEnd
    memory[37] = 32'h08000026;    //            j    ShiftRight
    memory[38] = 32'h22100001;    //    ShiftRight:    addi    $s0, $s0, 1
    memory[39] = 32'h0c00004a;    //            jal    SAD
    memory[40] = 32'h0c000044;    //            jal    checkEnd
    memory[41] = 32'h00000000;    //            nop
    memory[42] = 32'h08000036;    //            j    ShiftUpRight
    memory[43] = 32'h22310001;    //    ShiftDown:    addi    $s1, $s1, 1
    memory[44] = 32'h0c00004a;    //            jal    SAD
    memory[45] = 32'h0c000044;    //            jal    checkEnd
    memory[46] = 32'h00000000;    //            nop
    memory[47] = 32'h08000030;    //            j    ShiftDownLeft
    memory[48] = 32'h2210ffff;    //    ShiftDownLeft:    addi    $s0, $s0, -1
    memory[49] = 32'h22310001;    //            addi    $s1, $s1, 1
    memory[50] = 32'h0c00004a;    //            jal    SAD
    memory[51] = 32'h1233fff4;    //            beq    $s1, $s3, ShiftRight
    memory[52] = 32'h1200fff8;    //            beq    $s0, $zero, ShiftDown
    memory[53] = 32'h08000030;    //            j    ShiftDownLeft
    memory[54] = 32'h22100001;    //    ShiftUpRight:    addi    $s0, $s0, 1
    memory[55] = 32'h2231ffff;    //            addi    $s1, $s1, -1
    memory[56] = 32'h0c00004a;    //            jal    SAD
    memory[57] = 32'h1212fff3;    //            beq    $s0, $s2, ShiftDown
    memory[58] = 32'h1220ffed;    //            beq    $s1, $zero, ShiftRight
    memory[59] = 32'h08000036;    //            j    ShiftUpRight
    memory[60] = 32'h8c880004;    //    calcRightEdge:    lw    $t0, 4($a0)
    memory[61] = 32'h8c89000c;    //            lw    $t1, 12($a0)
    memory[62] = 32'h01099022;    //            sub    $s2, $t0, $t1
    memory[63] = 32'h00000000;    //            nop
    memory[64] = 32'h8c880000;    //    calcBottomEdge:    lw    $t0, 0($a0)
    memory[65] = 32'h8c890008;    //            lw    $t1, 8($a0)
    memory[66] = 32'h01099822;    //            sub    $s3, $t0, $t1
    memory[67] = 32'h00000000;    //            nop
    memory[68] = 32'h16120004;    //    checkEnd:    bne    $s0, $s2, notEnd
    memory[69] = 32'h16330003;    //            bne    $s1, $s3, notEnd
    memory[70] = 32'h8fbf0000;    //            lw    $ra, 0($sp)
    memory[71] = 32'h23bd0004;    //            addi    $sp, $sp, 4
    memory[72] = 32'h03e00008;    //            jr    $ra
    memory[73] = 32'h00000000;    //    notEnd:        nop
    memory[74] = 32'h22150000;    //    SAD:        addi    $s5, $s0, 0
    memory[75] = 32'h22360000;    //            addi    $s6, $s1, 0
    memory[76] = 32'h34170000;    //            ori    $s7, $zero, 0
    memory[77] = 32'h23bdfffc;    //            addi    $sp, $sp, -4
    memory[78] = 32'hafbf0000;    //            sw    $ra, 0($sp)
    memory[79] = 32'h0c000061;    //            jal    calcSAD
    memory[80] = 32'h08000051;    //            j    shiftRightSAD
    memory[81] = 32'h22b50001;    //    shiftRightSAD:    addi    $s5, $s5, 1
    memory[82] = 32'h0c000061;    //            jal    calcSAD
    memory[83] = 32'h08000054;    //            j    checkRightSAD
    memory[84] = 32'h8c88000c;    //    checkRightSAD:    lw    $t0, 12($a0)
    memory[85] = 32'h02084020;    //            add    $t0, $s0, $t0
    memory[86] = 32'h2108ffff;    //            addi    $t0, $t0, -1
    memory[87] = 32'h11150001;    //            beq    $t0, $s5, checkBottomSAD
    memory[88] = 32'h08000051;    //            j    shiftRightSAD
    memory[89] = 32'h8c880008;    //    checkBottomSAD:    lw    $t0, 8($a0)
    memory[90] = 32'h02284020;    //            add    $t0, $s1, $t0
    memory[91] = 32'h2108ffff;    //            addi    $t0, $t0, -1
    memory[92] = 32'h1116001a;    //            beq    $t0, $s6, EndSAD
    memory[93] = 32'h22d60001;    //            addi    $s6, $s6, 1
    memory[94] = 32'h22150000;    //            addi    $s5, $s0, 0
    memory[95] = 32'h0c000061;    //            jal    calcSAD
    memory[96] = 32'h08000051;    //            j    shiftRightSAD
    memory[97] = 32'h02b04022;    //    calcSAD:    sub    $t0, $s5, $s0
    memory[98] = 32'h02d14822;    //            sub    $t1, $s6, $s1
    memory[99] = 32'h8c8a000c;    //            lw    $t2, 12($a0)
    memory[100] = 32'h71495002;    //            mul    $t2, $t2, $t1
    memory[101] = 32'h01484020;    //            add    $t0, $t2, $t0
    memory[102] = 32'h00084080;    //            sll    $t0, $t0, 2
    memory[103] = 32'h01064020;    //            add    $t0, $t0, $a2
    memory[104] = 32'h8d190000;    //            lw    $t9, 0($t0)
    memory[105] = 32'h8c880004;    //            lw    $t0, 4($a0)
    memory[106] = 32'h71164002;    //            mul    $t0, $t0, $s6
    memory[107] = 32'h01154020;    //            add    $t0, $t0, $s5
    memory[108] = 32'h00084080;    //            sll    $t0, $t0, 2
    memory[109] = 32'h01054020;    //            add    $t0, $t0, $a1
    memory[110] = 32'h8d180000;    //            lw    $t8, 0($t0)
    memory[111] = 32'h0319402a;    //            slt    $t0, $t8, $t9
    memory[112] = 32'h11000003;    //            beq    $t0, $zero, SUM
    memory[113] = 32'h03384022;    //            sub    $t0, $t9, $t8
    memory[114] = 32'h02e8b820;    //            add    $s7, $s7, $t0
    memory[115] = 32'h00000000;    //            nop
    memory[116] = 32'h03194022;    //    SUM:        sub    $t0, $t8, $t9
    memory[117] = 32'h02e8b820;    //            add    $s7, $s7, $t0
    memory[118] = 32'h00000000;    //            nop
    memory[119] = 32'h8fbf0000;    //    EndSAD:        lw    $ra, 0($sp)
    memory[120] = 32'h23bd0004;    //            addi    $sp, $sp, 4
    memory[121] = 32'h0297402a;    //            slt    $t0, $s4, $s7
    memory[122] = 32'h11000001;    //            beq    $t0, $zero, updateSAD
    memory[123] = 32'h00000000;    //            nop
    memory[124] = 32'h02e0a020;    //    updateSAD:    add    $s4, $s7, $zero
    memory[125] = 32'h02201020;    //            add    $v0, $s1, $zero
    memory[126] = 32'h02001820;    //            add    $v1, $s0, $zero
    memory[127] = 32'h00000000;    //            nop

    end
    
    always @ (*) begin
        Instruction <= memory[Address>> 2];
    end

endmodule