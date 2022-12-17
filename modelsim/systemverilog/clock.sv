module clock(
	input logic arst,
	input logic [2:0] clk_sel,
	input logic stop_clk,
	input logic clk_in,
	output logic clk_out
);
	logic [7:0] clk_counter;

	always @(posedge arst, negedge clk_in) begin
		if(arst) clk_counter <= 8'h0;
		else if(stop_clk == 1'b0) clk_counter <= clk_counter + 8'h1;
	end

	assign clk_out = clk_counter[clk_sel];
	

endmodule