module mux_four_to_one (in, sel, out);

	input [3:0] in;
	input [1:0] sel;
	output out;

	assign out = in[sel[1] * 2 + sel[0]];
endmodule
