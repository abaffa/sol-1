module testbench;
	logic arst;
	logic [2:0] clk_sel;
	logic stop_clk;
  logic clk;
	logic halt;
	logic dma_req;
	logic dma_ack;
	logic [7:0] pins_irq_req;
  logic pin_wait;
  logic ext_input;

	wire logic [21:0] address_bus;
	wire logic [7:0] data_bus;
	wire logic rd;
	wire logic wr;
	wire logic mem_io;

  logic bios_ram_cs;
  logic bios_rom_cs;

  initial begin
		stop_clk = 1'b0;
		clk_sel = 3'b000;
		arst = 1'b1;
		#500ns arst = 1'b0;	

		pins_irq_req = {8{1'b0}};
		dma_req = 1'b0;
    ext_input = 1'b0;
    pin_wait = 1'b0;

		#20us $stop;
  end

	clock u_clock(
		.arst(arst),
		.clk_sel(clk_sel),
		.stop_clk(stop_clk),
		.clk_out(clk)
	);

	cpu_top u_cpu_top(
		.arst(arst),
		.clk(clk),
		.pins_irq_req(pins_irq_req),
		.dma_req(dma_req),
		.address_bus(address_bus),
		.data_bus_in(data_bus),
		.data_bus_out(data_bus),
		.rd(rd),
		.wr(wr),
		.mem_io(mem_io),
		.halt(halt),
		.dma_ack(dma_ack),
    .pin_wait(pin_wait),
    .ext_input(ext_input)
	);

  ram u_ram(
    .ce_n(bios_ram_cs),
    .oe_n(rd),
    .we_n(wr),
    .address(address_bus),
    .data_in(data_bus),
    .data_out(data_bus)
  );




endmodule
