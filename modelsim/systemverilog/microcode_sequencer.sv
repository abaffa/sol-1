import pa_microcode::*;

module microcode_sequencer(
  input logic arst,
  input logic clk,
  input logic [7:0] ir,
  input logic [7:0] alu_flags,
  input logic [7:0] cpu_status,
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
  output logic [6:0] ctrl_offset,
  output logic ctrl_cond_invert,
  output logic ctrl_cond_flag_src,
  output logic [3:0] ctrl_cond_sel,
  output logic ctrl_escape,
  output logic [1:0] ctrl_u_zf_in_src,
  output logic [1:0] ctrl_u_cf_in_src,
  output logic ctrl_u_sf_in_src,
  output logic ctrl_u_of_in_src,
  output logic ctrl_ir_wrt,
  output logic ctrl_status_flags_wrt,
  output logic [2:0] ctrl_shift_msb_src,
  output logic [1:0] ctrl_zbus_in_src_0,
  output logic [5:0] ctrl_alu_a_src,
  output logic [3:0] ctrl_alu_op,
  output logic ctrl_alu_mode,
  output logic [1:0] ctrl_alu_cf_in_src,
  output logic ctrl_alu_cf_in_invert,
  output logic ctrl_alu_cf_out_invert,
  output logic [1:0] ctrl_zf_in_src,
  output logic [2:0] ctrl_cf_in_src,
  output logic [1:0] ctrl_sf_in_src,
  output logic [2:0] ctrl_of_in_src,
  output logic ctrl_rd,
  output logic ctrl_wr,
  output logic [2:0] ctrl_alu_b_src,
  output logic ctrl_display_reg_load, // used during fetch to select and load register display
  output logic ctrl_dl_wrt,
  output logic ctrl_dh_wrt,
  output logic ctrl_cl_wrt,
  output logic ctrl_ch_wrt,
  output logic ctrl_bl_wrt,
  output logic ctrl_bh_wrt,
  output logic ctrl_al_wrt,
  output logic ctrl_ah_wrt,
  output logic ctrl_mdr_in_src,
  output logic ctrl_mdr_out_src,
  output logic ctrl_mdr_out_en,			// must invert before sending
  output logic ctrl_mdr_l_wrt,			
  output logic ctrl_mdr_h_wrt,
  output logic ctrl_tdr_l_wrt,
  output logic ctrl_tdr_h_wrt,
  output logic ctrl_di_l_wrt,
  output logic ctrl_di_h_wrt,
  output logic ctrl_si_l_wrt,
  output logic ctrl_si_h_wrt,
  output logic ctrl_mar_l_wrt,
  output logic ctrl_mar_h_wrt,
  output logic ctrl_bp_l_wrt,
  output logic ctrl_bp_h_wrt,
  output logic ctrl_pc_l_wrt,
  output logic ctrl_pc_h_wrt,
  output logic ctrl_sp_l_wrt,
  output logic ctrl_sp_h_wrt,
  output logic ctrl_gl_wrt,
  output logic ctrl_gh_wrt,
  output logic ctrl_int_vector_wrt,
  output logic ctrl_mask_flags_wrt,		// wrt signals are also active low
  output logic ctrl_mar_in_src,
  output logic ctrl_int_ack,		      // active high
  output logic ctrl_clear_all_ints,
  output logic ctrl_ptb_wrt,
  output logic ctrl_page_table_we, 
  output logic ctrl_mdr_to_pagetable_data_buffer,
  output logic ctrl_force_user_ptb,   // goes to board as page_table_addr_source via or gate
  output logic [7:0] ctrl_immy
);
  logic [CONTROL_WORD_WIDTH - 1:0] control_word;
  logic any_interruption;

  assign any_interruption = dma_req | int_pending;

  assign ctrl_typ = control_word[bitpos_typ1 : bitpos_typ0];
  assign ctrl_offset = control_word[bitpos_offset_6 : bitpos_offset_0];
  assign ctrl_cond_invert = control_word[bitpos_cond_invert];
  assign ctrl_cond_flag_src = control_word[bitpos_cond_flag_src];
  assign ctrl_cond_sel = control_word[bitpos_cond_sel_3 : bitpos_cond_sel_0];
  assign ctrl_escape = control_word[bitpos_escape];
  assign ctrl_u_zf_in_src = control_word[bitpos_u_zf_in_src_1 : bitpos_u_zf_in_src_0];
  assign ctrl_u_cf_in_src = control_word[bitpos_u_cf_in_src_1 : bitpos_u_cf_in_src_0];
  assign ctrl_u_sf_in_src = control_word[bitpos_u_sf_in_src];
  assign ctrl_u_of_in_src = control_word[bitpos_u_of_in_src];
  assign ctrl_ir_wrt = control_word[bitpos_ir_wrt];
  assign ctrl_status_flags_wrt = control_word[bitpos_status_flags_wrt];
  assign ctrl_shift_msb_src = control_word[bitpos_shift_msb_src_2 : bitpos_shift_msb_src_0];
  assign ctrl_zbus_in_src = control_word[bitpos_zbus_in_src_1 : bitpos_zbus_in_src_0];
  assign ctrl_alu_a_src = control_word[bitpos_alu_a_src_5 : bitpos_alu_a_src_0];
  assign ctrl_alu_op = control_word[bitpos_alu_op_3 : bitpos_alu_op_0];
  assign ctrl_alu_mode = control_word[bitpos_alu_mode];
  assign ctrl_alu_cf_in_src = control_word[bitpos_alu_cf_in_src_1 : bitpos_alu_cf_in_src_0];
  assign ctrl_alu_cf_in_invert = control_word[bitpos_alu_cf_in_invert];
  assign ctrl_alu_cf_out_invert = control_word[bitpos_alu_cf_out_invert];
  assign ctrl_zf_in_src = control_word[bitpos_zf_in_src_1 : bitpos_zf_in_src_0];
  assign ctrl_cf_in_src = control_word[bitpos_cf_in_src_2 : bitpos_cf_in_src_0];
  assign ctrl_sf_in_src = control_word[bitpos_sf_in_src_1 : bitpos_sf_in_src_0];
  assign ctrl_of_in_src = control_word[bitpos_of_in_src_2 : bitpos_of_in_src_0];
  assign ctrl_rd = control_word[bitpos_rd];
  assign ctrl_wr = control_word[bitpos_wr];
  assign ctrl_alu_b_src = control_word[bitpos_alu_b_src_2 : bitpos_alu_b_src_0];
  assign ctrl_display_reg_load = control_word[bitpos_display_reg_load]; // used during fetch to select and load register display
  assign ctrl_dl_wrt = control_word[bitpos_dl_wrt];
  assign ctrl_dh_wrt = control_word[bitpos_dh_wrt];
  assign ctrl_cl_wrt = control_word[bitpos_cl_wrt];
  assign ctrl_ch_wrt = control_word[bitpos_ch_wrt];
  assign ctrl_bl_wrt = control_word[bitpos_bl_wrt];
  assign ctrl_bh_wrt = control_word[bitpos_bh_wrt];
  assign ctrl_al_wrt = control_word[bitpos_al_wrt];
  assign ctrl_ah_wrt = control_word[bitpos_ah_wrt];
  assign ctrl_mdr_in_src = control_word[bitpos_mdr_in_src];
  assign ctrl_mdr_out_src = control_word[bitpos_mdr_out_src];
  assign ctrl_mdr_out_en = control_word[bitpos_mdr_out_en];			// must invert before sending
  assign ctrl_mdr_l_wrt = control_word[bitpos_mdr_l_wrt];			
  assign ctrl_mdr_h_wrt = control_word[bitpos_mdr_h_wrt];
  assign ctrl_tdr_l_wrt = control_word[bitpos_tdr_l_wrt];
  assign ctrl_tdr_h_wrt = control_word[bitpos_tdr_h_wrt];
  assign ctrl_di_l_wrt = control_word[bitpos_di_l_wrt];
  assign ctrl_di_h_wrt = control_word[bitpos_di_h_wrt];
  assign ctrl_si_l_wrt = control_word[bitpos_si_l_wrt];
  assign ctrl_si_h_wrt = control_word[bitpos_si_h_wrt];
  assign ctrl_mar_l_wrt = control_word[bitpos_mar_l_wrt];
  assign ctrl_mar_h_wrt = control_word[bitpos_mar_h_wrt];
  assign ctrl_bp_l_wrt = control_word[bitpos_bp_l_wrt];
  assign ctrl_bp_h_wrt = control_word[bitpos_bp_h_wrt];
  assign ctrl_pc_l_wrt = control_word[bitpos_pc_l_wrt];
  assign ctrl_pc_h_wrt = control_word[bitpos_pc_h_wrt];
  assign ctrl_sp_l_wrt = control_word[bitpos_sp_l_wrt];
  assign ctrl_sp_h_wrt = control_word[bitpos_sp_h_wrt];
  assign ctrl_gl_wrt = control_word[bitpos_gl_wrt];
  assign ctrl_gh_wrt = control_word[bitpos_gh_wrt];
  assign ctrl_int_vector_wrt = control_word[bitpos_int_vector_wrt];
  assign ctrl_mask_flags_wrt = control_word[bitpos_mask_flags_wrt];		// wrt signals are also active low
  assign ctrl_mar_in_src = control_word[bitpos_mar_in_src];
  assign ctrl_int_ack = control_word[bitpos_int_ack];		      // active high
  assign ctrl_clear_all_ints = control_word[bitpos_clear_all_ints];
  assign ctrl_ptb_wrt = control_word[bitpos_ptb_wrt];
  assign ctrl_page_table_we = control_word[bitpos_page_table_we]; 
  assign ctrl_mdr_to_pagetable_data_buffer = control_word[bitpos_mdr_to_pagetable_data_buffer];
  assign ctrl_force_user_ptb = control_word[bitpos_force_user_ptb];   // goes to board as page_table_addr_source via or gate
  assign ctrl_immy = control_word[bitpos_immy_7 : bitpos_immy_0];

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
        condition = cpu_status[pa_microcode::bitpos_cpu_status_mode];
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
        condition = fu_getStatusField(bitpos_cpu_status_dir);
      end
      4'b1101: begin
        condition = cpu_status[bitpos_cpu_status_displayreg_load];
      end
      4'b1110: condition = 1'b0;
      4'b1111: condition = 1'b0;
    endcase

    final_condition = condition ^ cond_invert;
  end

  function logic fu_getStatusField(logic [7:0] field);
    return cpu_status[field];
  endfunction
  
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
