module testbench;
  import pa_testbench::*;

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
		arst = 1'b1;
		stop_clk = 1'b0;
		clk_sel = 3'b000;
		pins_irq_req = {8{1'b0}};
		dma_req = 1'b0;
    ext_input = 1'b0;
    pin_wait = 1'b0;

		#500ns arst = 1'b0;	

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

  memory #(_32KB) u_bios_rom(
    .ce_n(bios_rom_cs),
    .oe_n(rd),
    .we_n(1'b1),
    .address(address_bus[14:0]),
    .data_in(data_bus),
    .data_out(data_bus)
  );
  memory #(_32KB) u_bios_ram(
    .ce_n(bios_ram_cs),
    .oe_n(rd),
    .we_n(wr),
    .address(address_bus[14:0]),
    .data_in(data_bus),
    .data_out(data_bus)
  );

  wire logic real_mode_addr_space;
  wire logic peripheral_addressing;
  assign peripheral_addressing = & address_bus[14:7];
  assign real_mode_addr_space = ~| address_bus[21:16];

  assign bios_rom_cs = !(mem_io && real_mode_addr_space && !address_bus[15]);
  assign bios_ram_cs = !(mem_io && real_mode_addr_space && !peripheral_addressing && address_bus[15]);

endmodule
