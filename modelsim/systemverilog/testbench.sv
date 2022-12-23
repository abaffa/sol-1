module testbench;
  import pa_testbench::*;

	logic arst;
	logic stop_clk_req;
  logic clk;
	logic halt;
	logic dma_req;
	logic dma_ack;
	logic [7:0] pins_irq_req;
  logic pin_wait;
  logic ext_input;

// Bus
	wire logic [21:0] address_bus;
	wire logic [7:0] data_bus;
	wire logic rd;
	wire logic wr;
	wire logic mem_io;

// Chip selects
  logic bios_ram_cs;
  logic bios_rom_cs;
  logic uart0_cs;
  logic uart1_cs;
  logic rtc_cs;
  logic pio0_cs;
  logic pio1_cs;
  logic ide_cs;
  logic timer_cs;
  logic bios_config_cs;

  // Address decoding support wires
  wire logic inside_real_mode_addr_space;
  wire logic addr_bus_7_to_14_alltrue;
  wire logic peripheral_access;

  initial begin
    // Load bios code into rom
    static int fp = $fopen("../software/bios.obj", "rb");
    if(!fp) $fatal("Failed to open bios.obj");
    if(!$fread(testbench.u_bios_rom.mem, fp)) $fatal("Failed to read bios.obj");
    $display("OK.");

    // Start CPU...
    arst = 1'b1;
		stop_clk_req = 1'b0;
		pins_irq_req = 8'h00;
		dma_req = 1'b0;
    ext_input = 1'b0;
    pin_wait = 1'b0;
		#100ns arst = 1'b0;	

		#600us $stop;
  end

	clock u_clock(
		.arst(arst),
		.stop_clk_req(stop_clk_req),
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


  assign addr_bus_7_to_14_alltrue = & address_bus[14:7];
  assign inside_real_mode_addr_space = ~| address_bus[21:16];
  assign peripheral_access = addr_bus_7_to_14_alltrue && address_bus[15] && mem_io;

  assign bios_rom_cs    = !(mem_io && inside_real_mode_addr_space && !address_bus[15]);
  assign bios_ram_cs    = !(mem_io && inside_real_mode_addr_space && !addr_bus_7_to_14_alltrue && address_bus[15]);
  assign uart0_cs       = peripheral_access ? !(address_bus[6:4] == 3'b000) : 1'b1;
  assign uart1_cs       = peripheral_access ? !(address_bus[6:4] == 3'b001) : 1'b1;
  assign rtc_cs         = peripheral_access ? !(address_bus[6:4] == 3'b010) : 1'b1;
  assign pio0_cs        = peripheral_access ? !(address_bus[6:4] == 3'b011) : 1'b1;
  assign pio1_cs        = peripheral_access ? !(address_bus[6:4] == 3'b100) : 1'b1;
  assign ide_cs         = peripheral_access ? !(address_bus[6:4] == 3'b101) : 1'b1;
  assign timer_cs       = peripheral_access ? !(address_bus[6:4] == 3'b110) : 1'b1;
  assign bios_config_cs = peripheral_access ? !(address_bus[6:4] == 3'b111) : 1'b1;

endmodule
