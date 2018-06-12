module mips_single_tb;
	reg clk, reset;
  integer i;

	mips_single mips (clk, reset);

  initial begin
    reset = 1;
    clk = 1;
    #2 clk = ~clk;
    for (i = 0; i < 200; i = i + 1) begin
      #2 clk = ~clk; reset = 0;
    end
  end

  initial begin
		$dumpfile("final-project-fibonacci.vcd");
		$dumpvars(0, mips_single_tb);
  end
endmodule
