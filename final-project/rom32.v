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
          5'd0 : data_out = { 6'd35, 5'd0, 5'd2, 16'd4            };  // lw $2, 4($0)     
          5'd1 : data_out = {                                     };  // lw $3, 8($0)    
          5'd2 : data_out = {                                     };  // lw $4, 20($0)   
          5'd3 : data_out = {                                     };  // add $5, $0, $0  
          5'd4 : data_out = { 6'd0, 5'd5, 5'd2, 5'd5, 5'd0, 6'd32 };  //  
          5'd5 : data_out = {                                     };  // slt $6, $4, $5  
          5'd6 : data_out = { 6'd4, 5'd6, 5'd0, -16'd3            };  // beq $6, $0, -3 
          5'd7 : data_out = {                                     };  // add $7, $3, $2
          5'd8 : data_out = {                                     };  // add $7, $5, $7
          5'd9 : data_out = { 6'd43, 5'd0, 5'd7, 16'd0            };  // 
          // add more cases here as desired
          default data_out = 32'hxxxx;
      endcase
      $display($time, " reading data: rom32[%h] => %h", address, data_out);
    end
  end 
endmodule

