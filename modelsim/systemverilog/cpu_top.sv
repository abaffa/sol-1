import pa_microcode::*;

module cpu_top(
  input logic arst,
  input logic clk,
  input logic [7:0] data_in,
  input logic [7:0] irq_in,
  input logic dma_req,
  input logic WAIT,
  input logic ext_input,
  
  output logic [21:0] addr,
  output logic [7:0] data_out,
  output logic rd,
  output logic wr,
  output logic mem_io,
  output logic halt,
  output logic dma_ack
);

  logic [7:0] ah, al;
  logic [7:0] bh, bl;
  logic [7:0] ch, cl;
  logic [7:0] dh, dl;

  logic [7:0] pch, pcl;
  logic [7:0] sph, spl;
  logic [7:0] ssph, sspl;
  logic [7:0] bph, bpl;
  logic [7:0] sih, sil;
  logic [7:0] dih, dil;

  logic [7:0] marh, marl;
  logic [7:0] mdrh, mdrl;
  logic [7:0] tdrh, tdrl;
  logic [7:0] irq_masks;

  logic [7:0] ir;
  logic [7:0] ptb;
  logic [7:0] cpu_status;
  logic [7:0] alu_flags;

  logic [7:0] k_bus;
  logic [7:0] w_bus;
  logic [7:0] y_bus; 
  logic [7:0] x_bus; 
  logic [7:0] z_bus; 

  logic [3:0] alu_op;
  logic [7:0] alu_out;
  logic alu_zf;
  logic alu_cf;
  logic alu_sf;
  logic alu_of;
  logic alu_final_cf;
  logic int_pending;
  logic any_interruption;
  logic [CONTROL_WORD_WIDTH - 1 : 0] control_word;
  logic [7:0] u_flags;
  logic alu_cf_out_invert;
  logic alu_cf_in;

  logic int_request;
  
  always_comb begin
    logic cf_muxed;
    case(control_word[CF_IN_SRC])
      2'b00: cf_muxed = 1'b1;
      2'b01: cf_muxed = alu_flags[1];
      2'b10: cf_muxed = u_flags[1];
      2'b11: cf_muxed = 1'b0;
    endcase
    alu_cf_in = cf_muxed ^ ALU_CF_IN_INVERT;
  end
  alu u_alu(
    .a(x_bus),
    .b(y_bus),
    .cf_in(alu_cf_in),
    .sel(alu_op),
    .mode(ALU_MODE),
    .alu_out(alu_out),
    .cf_out(alu_cf)
  );
  assign alu_zf = ~|alu_out;
  assign alu_final_cf = alu_cf_out_invert ^ alu_cf;
  assign alu_sf = z_bus[7];
  assign alu_of = (z_bus[7] ^ x_bus[7]) & ~((x_bus[7] ^ y_bus[7]) ^ ~(alu_op[0] & alu_op[3] & ~(alu_op[2] | alu_op[1])));
  
  assign int_pending = int_request & cpu_status[1];
  assign any_interruption = dma_req | int_pending;
  
  always_comb begin
    
  end

  microcode_sequencer u_microcode_sequencer(
    .arst(arst),
    .clk(clk),
    .ir(ir),
    .alu_flags(alu_flags),
    .cpu_status(cpu_status),
    .any_interruption(any_interruption),
    .alu_out(alu_out),
    .z_bus(z_bus),
    .alu_of(alu_of),
    .alu_final_cf(alu_final_cf),
    .dma_req(dma_req),
    .WAIT(WAIT),
    .int_pending(int_pending),
    .ext_input(ext_input),
    .u_flags(u_flags),
    .control_word(control_word)   
  );

  always @(posedge arst, posedge clk) begin
    if(arst == 1'b1) begin
      addr <= 22'h0;
      data_out <= 'z;
      rd <= 1'b0;
      wr <= 1'b0;
      mem_io <= 1'b0;
      dma_ack <= 1'b0;
      halt <= 1'b0;
    end
    else begin
      
    end
  end




endmodule
