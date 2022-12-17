module microcode_sequencer(
  input logic arst,
  input logic clk,
  input logic [7:0] ir,
  input logic [7:0] alu_flags,
  input logic [7:0] cpu_status,
  input logic any_interruption,
  input logic [7:0] alu_out,
  input logic [7:0] z_bus,
  input logic alu_of,
  input logic alu_final_cf,
  input logic dma_req,
  input logic WAIT,
  input logic int_pending,
  input logic ext_input,
  
  output logic [7:0] u_flags,
  output logic [pa_microcode::CONTROL_WORD_WIDTH - 1 : 0] control_word
);

  logic [13:0] u_address;
  logic next1, next0;
  logic [13:0] u_offset;
  logic final_condition;
  logic fetch_u_address;
  logic trap_u_address;
  logic cond_flag_src;
  logic [1:0] u_zf_in_src, u_cf_in_src;
  logic u_sf_in_src, u_of_in_src;
  logic cond_invert;
  logic [3:0] cond_sel;
  logic u_escape;

  assign next0 = control_word[0];
  assign next1 = control_word[1];
  assign u_escape = control_word[pa_microcode::U_ROM1 + 7];

  always_comb begin
    logic zf_muxed, cf_muxed, sf_muxed, of_muxed;
    logic condition;
    
    zf_muxed = cond_flag_src ? u_flags[0] : alu_flags[0];
    cf_muxed = cond_flag_src ? u_flags[1] : alu_flags[1];
    sf_muxed = cond_flag_src ? u_flags[2] : alu_flags[2];
    of_muxed = cond_flag_src ? u_flags[3] : alu_flags[3];

    case(cond_sel)
      3'b0000: begin
        condition = zf_muxed;
      end
      3'b0001: begin
        condition = cf_muxed;
      end
      3'b0010: begin
        condition = sf_muxed;
      end
      3'b0011: begin
        condition = of_muxed;
      end
      3'b0100: begin
        condition = sf_muxed ^ of_muxed;
      end
      3'b0101: begin
        condition = (sf_muxed ^ of_muxed) | zf_muxed;
      end
      3'b0110: begin
        condition = cf_muxed | zf_muxed;
      end
      3'b0111: begin
        condition = dma_req;
      end
      3'b1000: begin
        condition = cpu_status[pa_microcode::CPU_STATUS_MODE_POS];
      end
      3'b1001: begin
        condition = WAIT;
      end
      3'b1010: begin
        condition = int_pending;
      end
      3'b1011: begin
        condition = ext_input;
      end
      3'b1100: begin
        condition = cpu_status[pa_microcode::CPU_STATUS_DIR_POS];
      end
      3'b1101: begin
        condition = cpu_status[pa_microcode::CPU_STATUS_DISPLAYREG_LOAD_POS];
      end
      3'b1110: condition = 1'b0;
      3'b1111: condition = 1'b0;
    endcase

    final_condition = condition ^ cond_invert;
  end

  // DFF for u_flags register
  always_ff @(posedge clk) begin
    // u_zf
    case(u_zf_in_src)
      2'b00: u_flags[0] <= u_flags[0];
      2'b01: u_flags[0] <= alu_flags[0];
      2'b10: u_flags[0] <= alu_flags[0] & u_flags[0];
      2'b11: u_flags[0] <= u_flags[0];
    endcase
    // u_cf
    case(u_cf_in_src)
      2'b00: u_flags[1] <= u_flags[1];
      2'b01: u_flags[1] <= alu_final_cf;
      2'b10: u_flags[1] <= alu_out[0];
      2'b11: u_flags[1] <= alu_out[7];
    endcase
    // u_sf
    case(u_sf_in_src)
      1'b0: u_flags[2] <= u_flags[2];
      1'b1: u_flags[2] <= z_bus[7];
    endcase
    // u_of
    case(u_of_in_src)
      1'b0: u_flags[3] <= u_flags[3];
      1'b1: u_flags[3] <= alu_of;
    endcase
  end

  always_ff @(posedge clk, posedge arst) begin
    case({next1, next0})
      2'b00:
        u_address <= u_address + u_offset;
      2'b01:
        if(final_condition == 1'b1) u_address <= u_address + u_offset;
        else u_address <= u_address + 14'b1;
      2'b10:
        if(any_interruption == 1'b1) u_address <= trap_u_address;
        else u_address <= fetch_u_address;
      2'b11:
        u_address <= {{6{1'b0}}, ir};
    endcase

  end
  




endmodule
