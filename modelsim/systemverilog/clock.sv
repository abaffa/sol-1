module clock(
	input logic arst,
	input logic [2:0] clk_sel,
	input logic stop_clk,
	output logic clk_out
);
  logic clk;
	logic [7:0] clk_counter;

  initial begin
    clk = 0;
    clk_counter = '0;
    forever #1us clk = ~clk;
  end

	always @(negedge clk) begin
		if(!stop_clk) clk_counter <= clk_counter + 8'h1;
	end

	assign clk_out = clk_counter[clk_sel];
	

endmodule
