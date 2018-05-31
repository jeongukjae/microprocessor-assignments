//-----------------------------------------------------------------------------
// Title         : MIPS Single-Cycle Processor
// Project       : Computer Organization
//-----------------------------------------------------------------------------
// File          : mips_single.v
//-----------------------------------------------------------------------------
// Description :
//   "Single Cycle" implementation of the MIPS processor subset described in
//   Section 5.4 of "Computer Organization and Design, 3rd ed."
//   by David Patterson & John Hennessey, Morgan Kaufmann, 2004 (COD3e).  
//
//   It implements the equivalent of Figure 5.19 on page 309 of COD3e
//   See the figure (block diagram of MIPS datapath and control unit)
//   
//-----------------------------------------------------------------------------

module mips_single(clk, reset);
    input clk, reset;

    // instruction bus
    wire [31:0] instr;

    // break out important fields from instruction
    wire [5:0] opcode, funct;
    wire [4:0] rs, rt, rd, shamt;
    wire [15:0] immed;
    wire [31:0] extend_immed, b_offset;

    assign opcode = instr[31:26];
    assign rs = instr[25:21];
    assign rt = instr[20:16];
    assign rd = instr[15:11];
    assign shamt = instr[10:6];
    assign funct = instr[5:0];
    assign immed = instr[15:0];

    // sign-extender
    assign extend_immed = { {16{immed[15]}}, immed };
    
    // branch offset shifter
    assign b_offset = extend_immed << 2;

    // datapath signals
    wire [4:0] rfile_wn;
    wire [31:0] rfile_rd1, rfile_rd2, rfile_wd, alu_b, alu_out, b_tgt, pc_next,
                pc, pc_incr, dmem_rdata;
    
    // control signals

    wire RegWrite, Branch, PCSrc, RegDst, MemtoReg, MemRead, MemWrite, ALUSrc, Zero;
    wire [1:0] ALUOp;
    wire [2:0] Operation;

    // module instantiations

    reg32		PC(, , , );

    add32 		PCADD(, 32'd4, );

    add32 		BRADD(, , );

    reg_file	RFILE(, , , , , , , ); 

    alu 		ALU(, , , , );

    rom32 		IMEM(, );

    mem32 		DMEM(, , , , , );

    and  		BR_AND(PCSrc, Branch, Zero);

    mux2 #(5) 	RFMUX(RegDst, rt, rd, rfile_wn);

    mux2 #(32)	PCMUX(PCSrc, pc_incr, b_tgt, pc_next);

    mux2 #(32) 	ALUMUX(ALUSrc, rfile_rd2, extend_immed, alu_b);

    mux2 #(32)	WRMUX(MemtoReg, alu_out, dmem_rdata, rfile_wd);

    control_single CTL (, , , ,  , , , , );

    alu_ctl 	ALUCTL(, , );
endmodule
