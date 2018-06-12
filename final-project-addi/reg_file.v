//-----------------------------------------------------------------------------
// Title         : Register File (32 32-bit registers)
// Project       : Computer Organization
//-----------------------------------------------------------------------------
// File          : reg_file.v
//-----------------------------------------------------------------------------
// Description :
//   Behavioral model of the register file  used in the implementations of the MIPS
//   processor subset described in Ch. 5-6 of "Computer Organization and Design, 3rd ed."
//   by David Patterson & John Hennessey, Morgan Kaufmann, 2004 (COD3e).  
//
//   It implements the function specified in Fig 5-7 on p. 295 of COD3e.
//
//-----------------------------------------------------------------------------

module reg_file(clk, RegWrite, RN1, RN2, WN, RD1, RD2, WD);
  input clk;
  input RegWrite;
  input [4:0] RN1, RN2, WN;
  input [31:0] WD;
  output [31:0] RD1, RD2;

  reg [31:0] RD1, RD2;
  reg [31:0] file_array [31:1];

  always @(RN1 or file_array[RN1])
  begin   
    if (RN1 == 0) RD1 = 32'd0;
    else RD1 = file_array[RN1];
    $display($time, " reg_file[%d] => %d (Port 1)", RN1, RD1);
  end

  always @(RN2 or file_array[RN2])
  begin
    if (RN2 == 0) RD2 = 32'd0;
    else RD2 = file_array[RN2];
    $display($time, " reg_file[%d] => %d (Port 2)", RN2, RD2);
  end

  always @(posedge clk) 
    if (RegWrite && (WN != 0))
    begin
      file_array[WN] <= WD;
      $display($time, " reg_file[%d] <= %d (Write)", WN, WD);
    end
  
  initial begin
    $dumpfile("final-project-addi.vcd");
    $dumpvars(1, file_array[1],
      file_array[2],
      file_array[3],
      file_array[4],
      file_array[5],
      file_array[6],
      file_array[7],
      file_array[8],
      file_array[9],
      file_array[10],
      file_array[11],
      file_array[12],
      file_array[13],
      file_array[14],
      file_array[15],
      file_array[16],
      file_array[17],
      file_array[18],
      file_array[19],
      file_array[20],
      file_array[21],
      file_array[22],
      file_array[23],
      file_array[24],
      file_array[25],
      file_array[26],
      file_array[27],
      file_array[28],
      file_array[29],
      file_array[30],
      file_array[31]);
  end
endmodule

