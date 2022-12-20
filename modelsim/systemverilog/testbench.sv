module testbench;
	logic arst;
	logic [2:0] clk_sel;
	logic stop_clk;

  initial begin
		stop_clk = 1'b1;
		clk_sel = 3'b000;
		arst = 1'b1;
		#500ns arst = 1'b0;	

		#20us $stop;
  end

  sol1_top u_sol1_top(
    .*
  );




endmodule
