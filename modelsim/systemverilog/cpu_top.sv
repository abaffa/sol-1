import pa_microcode::*;

module cpu_top(
  input logic arst,
  input logic clk,
  input logic [7:0] data_in,
  input logic [7:0] ext_irq_req,
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
// General registers
  logic [7:0] ah, al;
  logic [7:0] bh, bl;
  logic [7:0] ch, cl;
  logic [7:0] dh, dl;
  logic [7:0] pch, pcl;
  logic [7:0] sph, spl;
  logic [7:0] bph, bpl;
  logic [7:0] sih, sil;
  logic [7:0] dih, dil;
  
// System registers
  logic [7:0] ir;
  logic [7:0] ptb;
  logic [7:0] cpu_status;
  logic [7:0] alu_flags;
  logic [7:0] ssph, sspl;
  logic [7:0] marh, marl;
  logic [7:0] mdrh, mdrl;
  logic [7:0] tdrh, tdrl;
  logic [7:0] irq_masks;
  logic [7:0] irq_status;
  logic [7:0] irq_vector;
  
// Buses
  logic [7:0] k_bus;
  logic [7:0] w_bus;
  logic [7:0] y_bus; 
  logic [7:0] x_bus; 
  logic [7:0] z_bus; 

// ALU
  logic [7:0] alu_out;
  logic alu_zf;
  logic alu_cf;
  logic alu_sf;
  logic alu_of;
  logic alu_final_cf;
  logic int_pending;
  logic [7:0] u_flags;
  logic alu_cf_in;
  logic int_request;
// IRQ requests after passing through their corresponding DFFs
  logic [7:0] irq_dff;
  
// control word fields
  logic [1:0] ctrl_typ;
  logic [6:0] ctrl_offset;
  logic ctrl_cond_invert;
  logic ctrl_cond_flag_src;
  logic [3:0] ctrl_cond_sel;
  logic ctrl_escape;
  logic [1:0] ctrl_u_zf_in_src;
  logic [1:0] ctrl_u_cf_in_src;
  logic ctrl_u_sf_in_src;
  logic ctrl_u_of_in_src;
  logic ctrl_ir_wrt;
  logic ctrl_status_flags_wrt;
  logic [2:0] ctrl_shift_msb_src;
  logic [1:0] ctrl_zbus_in_src_0;
  logic [5:0] ctrl_alu_a_src;
  logic [3:0] ctrl_alu_op;
  logic ctrl_alu_mode;
  logic [1:0] ctrl_alu_cf_in_src;
  logic ctrl_alu_cf_in_invert;
  logic ctrl_alu_cf_out_invert;
  logic [1:0] ctrl_zf_in_src;
  logic [2:0] ctrl_cf_in_src;
  logic [1:0] ctrl_sf_in_src;
  logic [2:0] ctrl_of_in_src;
  logic ctrl_rd;
  logic ctrl_wr;
  logic [2:0] ctrl_alu_b_src;
  logic ctrl_display_reg_load; // used during fetch to select and load register display
  logic ctrl_dl_wrt;
  logic ctrl_dh_wrt;
  logic ctrl_cl_wrt;
  logic ctrl_ch_wrt;
  logic ctrl_bl_wrt;
  logic ctrl_bh_wrt;
  logic ctrl_al_wrt;
  logic ctrl_ah_wrt;
  logic ctrl_mdr_in_src;
  logic ctrl_mdr_out_src;
  logic ctrl_mdr_out_en;			// must invert before sending
  logic ctrl_mdr_l_wrt;			
  logic ctrl_mdr_h_wrt;
  logic ctrl_tdr_l_wrt;
  logic ctrl_tdr_h_wrt;
  logic ctrl_di_l_wrt;
  logic ctrl_di_h_wrt;
  logic ctrl_si_l_wrt;
  logic ctrl_si_h_wrt;
  logic ctrl_mar_l_wrt;
  logic ctrl_mar_h_wrt;
  logic ctrl_bp_l_wrt;
  logic ctrl_bp_h_wrt;
  logic ctrl_pc_l_wrt;
  logic ctrl_pc_h_wrt;
  logic ctrl_sp_l_wrt;
  logic ctrl_sp_h_wrt;
  logic ctrl_gl_wrt;
  logic ctrl_gh_wrt;
  logic ctrl_int_vector_wrt;
  logic ctrl_irq_masks_wrt;		// wrt signals are also active low
  logic ctrl_mar_in_src;
  logic ctrl_int_ack;		      // active high
  logic ctrl_clear_all_ints;
  logic ctrl_ptb_wrt;
  logic ctrl_page_table_we; 
  logic ctrl_mdr_to_pagetable_data_buffer;
  logic ctrl_force_user_ptb;   // goes to board as page_table_addr_source via or gate
  logic [7:0] ctrl_immy;

  always_comb begin
    logic cf_muxed;
    case(ctrl_cf_in_src)
      2'b00: cf_muxed = 1'b1;
      2'b01: cf_muxed = alu_flags[1];
      2'b10: cf_muxed = u_flags[1];
      2'b11: cf_muxed = 1'b0;
    endcase
    alu_cf_in = cf_muxed ^ ctrl_alu_cf_in_invert;
  end
  alu u_alu(
    .a(x_bus),
    .b(y_bus),
    .cf_in(alu_cf_in),
    .op(ctrl_alu_op),
    .mode(ctrl_alu_mode),
    .alu_out(alu_out),
    .cf_out(alu_cf)
  );
  assign alu_zf = ~|alu_out;
  assign alu_final_cf = ctrl_alu_cf_out_invert ^ alu_cf;
  assign alu_sf = z_bus[7];
  assign alu_of = (z_bus[7] ^ x_bus[7]) & ~((x_bus[7] ^ y_bus[7]) ^ ~(ctrl_alu_op[0] & ctrl_alu_op[3] & ~(ctrl_alu_op[2] | ctrl_alu_op[1])));
  
  assign int_pending = int_request & cpu_status[1];
  
// Interrupts
  logic [7:0] irq_clear;
  for(genvar i = 0; i < 8; i++) begin
    assign irq_clear[i] = ctrl_int_ack && irq_vector[3:1] == i;
    always_ff @(posedge ext_irq_req[i], posedge ctrl_clear_all_ints, posedge irq_clear[i]) begin
      if(ctrl_clear_all_ints == 1'b1 || irq_clear[i] == 1'b1) irq_dff[i] <= 1'b0;
      else irq_dff[i] <= 1'b1;
    end
  end
  always_ff @(posedge clk) begin
    irq_status <= irq_dff;
  end
  // IRQ Handling Block
  always_ff @(posedge clk) begin
    logic [7:0] irqs_masked;
    logic [2:0] irq_encoded;
    logic irq_req;

    irqs_masked = irq_status & irq_masks;
    irq_req = |irqs_masked; // Check if any IRQ is requested
    if(irqs_masked[0] == 1'b1) irq_encoded = 000;
    else if(irqs_masked[1] == 1'b1) irq_encoded = 3'b001;
    else if(irqs_masked[2] == 1'b1) irq_encoded = 3'b010;
    else if(irqs_masked[3] == 1'b1) irq_encoded = 3'b011;
    else if(irqs_masked[4] == 1'b1) irq_encoded = 3'b100;
    else if(irqs_masked[5] == 1'b1) irq_encoded = 3'b101;
    else if(irqs_masked[6] == 1'b1) irq_encoded = 3'b110;
    else if(irqs_masked[7] == 1'b1) irq_encoded = 3'b111;
    
    if(ctrl_int_vector_wrt == 1'b0) begin
      irq_vector <= {4'b0000, irq_encoded[2:0], 1'b0};
    end
  end

// Registers Block
  always_ff @(posedge clk) begin
    if(ctrl_irq_masks_wrt == 1'b0) irq_masks <= z_bus;
  end

// Microcode Sequencer
  microcode_sequencer u_microcode_sequencer(
    .arst(arst),
    .clk(clk),
    .ir(ir),
    .alu_flags(alu_flags),
    .cpu_status(cpu_status),
    .alu_out(alu_out),
    .z_bus(z_bus),
    .alu_of(alu_of),
    .alu_final_cf(alu_final_cf),
    .dma_req(dma_req),
    .WAIT(WAIT),
    .int_pending(int_pending),
    .ext_input(ext_input),
    .u_flags(u_flags),
    // control word fields
    .*
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
