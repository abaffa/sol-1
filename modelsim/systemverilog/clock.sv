module clock(
	input logic arst,
	input logic [2:0] clk_sel,
	input logic stop_clk,
	output logic clk_out
);
  logic clk;
	logic [7:0] clk_counter;

  initial begin
    clk = 1'b0;
    forever #1us clk = ~clk;
  end

	always @(negedge clk, posedge arst) begin
    if(arst) clk_counter <= 8'h1; // clock starts HIGH so that control bits can be written on the first falling edge.
		else if(!stop_clk) clk_counter <= clk_counter + 8'h1;
	end

	assign clk_out = clk_counter[clk_sel];
	

endmodule
