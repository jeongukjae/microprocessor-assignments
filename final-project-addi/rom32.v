//-----------------------------------------------------------------------------
// Title         : Read-Only Memory (Instruction ROM)
// Project       : Computer Organization
//-----------------------------------------------------------------------------
// File          : rom32.v
//-----------------------------------------------------------------------------
// Description :
//   Behavioral model of a read-only memory used in the implementations of the MIPS
//   processor subset described in Ch. 5-6 of "Computer Organization and Design, 3rd ed."
//   by David Patterson & John Hennessey, Morgan Kaufmann, 2004 (COD3e).  
//
//   Note the use of the Verilog concatenation operator to specify different
//   instruction fields in each memory element.
//
//-----------------------------------------------------------------------------

module rom32(address, data_out);
  input  [31:0] address;
  output [31:0] data_out;
  reg    [31:0] data_out;

  parameter BASE_ADDRESS = 25'd0; // address that applies to this memory

  wire [4:0] mem_offset;
  wire address_select;

  assign mem_offset = address[6:2];  // drop 2 LSBs to get word offset

  assign address_select = (address[31:7] == BASE_ADDRESS);  // address decoding

  always @(address_select or mem_offset)
  begin
    if ((address % 4) != 0) $display($time, " rom32 error: unaligned address %d", address);
    if (address_select == 1)
    begin
      case (mem_offset) 
          5'd0  : data_out = { 6'd35, 5'd0, 5'd2, 16'd4            };  // lw $2, 4($0) # $2은 몇번째 항인지 세기 위해 쓴다.
          5'd1  : data_out = { 6'd8, 5'd2, 5'd6, 16'd10            };  // addi $2, $6, 10 # 11 만들기
          5'd2  : data_out = { 6'd35, 5'd0, 5'd3, 16'd0            };  // lw $3, 0($0) # $3 = $2번째 항
          5'd3  : data_out = { 6'd35, 5'd0, 5'd4, 16'd4            };  // lw $4, 4($0) # $4 = $2 + 1번째 항
          5'd4  : data_out = { 6'd0, 5'd3, 5'd4, 5'd5, 5'd0, 6'd32 };  // add $5, $3, $4
          5'd5  : data_out = { 6'd8, 5'd4, 5'd3, 16'd0             };  // addi $3, $4, 0
          5'd6  : data_out = { 6'd8, 5'd5, 5'd4, 16'd0             };  // addi $4, $5, 0
          5'd7  : data_out = { 6'd8, 5'd2, 5'd2, 16'd1             };  // addi $2, $2, 1
          5'd8  : data_out = { 6'd0, 5'd6, 5'd2, 5'd7, 5'd0, 6'd42 };  // slt $7, $6, $2
          5'd9  : data_out = { 6'd4, 5'd7, 5'd0, -16'd6            };  // beq $7, $0, -6
          5'd10 : data_out = { 6'd43, 5'd0, 5'd3, 16'd0            };  // sw $7, 0($0)
          default data_out = 32'hxxxx;
      endcase
      $display($time, " reading data: rom32[%h] => %h", address, data_out);
    end
  end 
endmodule

