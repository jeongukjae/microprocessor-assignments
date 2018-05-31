module mux_four_to_one_tb;
	reg [3:0] in;
	reg [1:0] sel;
	wire out;

	mux_four_to_one mux1 (.in(in), .sel(sel), .out(out));

	initial begin
		sel = 2'b00;
		in = 4'b0000;
		#10 in = 4'b0001;
		#10 in = 4'b0010;
		#10 in = 4'b0011;
		#10 in = 4'b0100;
		#10 in = 4'b0101;
		#10 in = 4'b0110;
		#10 in = 4'b0111;
		#10 in = 4'b1000;
		#10 in = 4'b1001;
		#10 in = 4'b1010;
		#10 in = 4'b1011;
		#10 in = 4'b1100;
		#10 in = 4'b1101;
		#10 in = 4'b1110;
		#10 in = 4'b1111;

		#10 sel = 2'b01;
		in = 4'b0000;
		#10 in = 4'b0001;
		#10 in = 4'b0010;
		#10 in = 4'b0011;
		#10 in = 4'b0100;
		#10 in = 4'b0101;
		#10 in = 4'b0110;
		#10 in = 4'b0111;
		#10 in = 4'b1000;
		#10 in = 4'b1001;
		#10 in = 4'b1010;
		#10 in = 4'b1011;
		#10 in = 4'b1100;
		#10 in = 4'b1101;
		#10 in = 4'b1110;
		#10 in = 4'b1111;

		#10 sel = 2'b10;
		in = 4'b0000;
		#10 in = 4'b0001;
		#10 in = 4'b0010;
		#10 in = 4'b0011;
		#10 in = 4'b0100;
		#10 in = 4'b0101;
		#10 in = 4'b0110;
		#10 in = 4'b0111;
		#10 in = 4'b1000;
		#10 in = 4'b1001;
		#10 in = 4'b1010;
		#10 in = 4'b1011;
		#10 in = 4'b1100;
		#10 in = 4'b1101;
		#10 in = 4'b1110;
		#10 in = 4'b1111;

		#10 sel = 2'b11;
		in = 4'b0000;
		#10 in = 4'b0001;
		#10 in = 4'b0010;
		#10 in = 4'b0011;
		#10 in = 4'b0100;
		#10 in = 4'b0101;
		#10 in = 4'b0110;
		#10 in = 4'b0111;
		#10 in = 4'b1000;
		#10 in = 4'b1001;
		#10 in = 4'b1010;
		#10 in = 4'b1011;
		#10 in = 4'b1100;
		#10 in = 4'b1101;
		#10 in = 4'b1110;
		#10 in = 4'b1111;
	end

	initial begin
		$dumpfile("41_mux.vcd");
		$dumpvars(0, mux_four_to_one_tb);
		$monitor($time, ": %b & %b => out", in, sel, out);
	end

endmodule
