module testbench;
	logic arst;
	logic clk_in = 1'b0;
	logic clk;
	logic [7:0] ext_irq_req;
	logic dma_req;

	logic [21:0] addr;
	logic [7:0] data_bus_in;
	logic [7:0] data_out;
	logic rd;
	logic wr;
	logic mem_io;
	logic halt;
	logic dma_ack;

	logic [2:0] clk_sel;
	logic stop_clk;
  
  logic pad_wait;
  logic ext_input;
	class C#(type a); 
   static function void check;
    a s;
    $display($typename(s));
  endfunction
  endclass
  initial begin
		ext_irq_req = {8{1'b0}};
		dma_req = 1'b0;
		stop_clk = 1'b0;
		clk_sel = 3'b000;
		data_bus_in = 8'h00;
		arst = 1'b1;
		#500ns arst = 1'b0;	

    C#(bit)::check();

		#20us $stop;
  end

	always begin
		#250ns clk_in = ~clk_in;
	end

	clock u_clock(
		.arst(arst),
		.clk_sel(clk_sel),
		.stop_clk(stop_clk),
		.clk_in(clk_in),
		.clk_out(clk)
	);

	cpu_top u_cpu_top(
		.arst(arst),
		.clk(clk),
		.ext_irq_req(ext_irq_req),
		.dma_req(dma_req),
		.addr(addr),
		.data_bus_in(data_bus_in),
		.data_out(data_out),
		.rd(rd),
		.wr(wr),
		.mem_io(mem_io),
		.halt(halt),
		.dma_ack(dma_ack),
    .pad_wait(pad_wait),
    .ext_input(ext_input)
	);



endmodule
