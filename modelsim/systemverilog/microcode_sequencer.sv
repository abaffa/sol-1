import pa_microcode::*;

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
  
  output logic [1:0] ctrl_typ,
  output logic [6:0] ctrl_offset
);

  assign ctrl_typ = {control_word[bitpos_typ1], control_word[bitpos_typ0]};
  assign ctrl_offset = {
    control_word[bitpos_offset_6],
    control_word[bitpos_offset_5],
    control_word[bitpos_offset_4],
    control_word[bitpos_offset_3],
    control_word[bitpos_offset_2],
    control_word[bitpos_offset_1],
    control_word[bitpos_offset_0]
  };

  logic [13:0] u_address;
  logic final_condition;
  logic fetch_u_address;
  logic trap_u_address;
  logic cond_flag_src;
  logic [1:0] u_zf_in_src, u_cf_in_src;
  logic u_sf_in_src, u_of_in_src;
  logic cond_invert;
  logic [3:0] cond_sel;
  logic u_escape;


  always_comb begin
    logic zf_muxed, cf_muxed, sf_muxed, of_muxed;
    logic condition;
    
    zf_muxed = cond_flag_src ? u_flags[0] : alu_flags[0];
    cf_muxed = cond_flag_src ? u_flags[1] : alu_flags[1];
    sf_muxed = cond_flag_src ? u_flags[2] : alu_flags[2];
    of_muxed = cond_flag_src ? u_flags[3] : alu_flags[3];

    case(cond_sel)
      4'b0000: begin
        condition = zf_muxed;
      end
      4'b0001: begin
        condition = cf_muxed;
      end
      4'b0010: begin
        condition = sf_muxed;
      end
      4'b0011: begin
        condition = of_muxed;
      end
      4'b0100: begin
        condition = sf_muxed ^ of_muxed;
      end
      4'b0101: begin
        condition = (sf_muxed ^ of_muxed) | zf_muxed;
      end
      4'b0110: begin
        condition = cf_muxed | zf_muxed;
      end
      4'b0111: begin
        condition = dma_req;
      end
      4'b1000: begin
        condition = cpu_status[pa_microcode::CPU_STATUS_MODE_POS];
      end
      4'b1001: begin
        condition = WAIT;
      end
      4'b1010: begin
        condition = int_pending;
      end
      4'b1011: begin
        condition = ext_input;
      end
      4'b1100: begin
        condition = cpu_status[pa_microcode::CPU_STATUS_DIR_POS];
      end
      4'b1101: begin
        condition = cpu_status[pa_microcode::CPU_STATUS_DISPLAYREG_LOAD_POS];
      end
      4'b1110: condition = 1'b0;
      4'b1111: condition = 1'b0;
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
    case(ctrl_typ)
      2'b00:
        u_address <= u_address + ctrl_offset;
      2'b01:
        if(final_condition == 1'b1) u_address <= u_address + ctrl_offset;
        else u_address <= u_address + 14'b1;
      2'b10:
        if(any_interruption == 1'b1) u_address <= trap_u_address;
        else u_address <= fetch_u_address;
      2'b11:
        u_address <= {{6{1'b0}}, ir};
    endcase

  end
  




endmodule
