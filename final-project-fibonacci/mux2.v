//-----------------------------------------------------------------------------
// Title         : 2-1 multiplexer
// Project       : Computer Organization
//-----------------------------------------------------------------------------
// File          : mux2.v
//-----------------------------------------------------------------------------
// Description :
//   Parameterized 2-1 mux  used in the implementations of the MIPS processor
//   subset described in Ch. 5-6 of "Computer Organization and Design, 3rd ed."
//   by David Patterson & John Hennessey, Morgan Kaufmann, 2004 (COD3e).  
//
//-----------------------------------------------------------------------------

module mux2( sel, a, b, y );
    parameter bitwidth=32;
    input sel;
    input  [bitwidth-1:0] a, b;
    output [bitwidth-1:0] y;

    assign y = sel ? b : a;
endmodule
