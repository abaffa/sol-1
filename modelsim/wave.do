onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /testbench/u_bios_rom/MEM_SIZE
add wave -noupdate /testbench/u_bios_rom/ce_n
add wave -noupdate /testbench/u_bios_rom/oe_n
add wave -noupdate /testbench/u_bios_rom/we_n
add wave -noupdate /testbench/u_bios_rom/address
add wave -noupdate /testbench/u_bios_rom/data_in
add wave -noupdate /testbench/u_bios_rom/data_out
add wave -noupdate /testbench/u_bios_rom/mem
add wave -noupdate -radix hexadecimal /testbench/arst
add wave -noupdate -radix hexadecimal /testbench/clk_sel
add wave -noupdate -radix hexadecimal /testbench/stop_clk
add wave -noupdate -radix hexadecimal /testbench/clk
add wave -noupdate -radix hexadecimal /testbench/halt
add wave -noupdate -radix hexadecimal /testbench/dma_req
add wave -noupdate -radix hexadecimal /testbench/dma_ack
add wave -noupdate -radix hexadecimal /testbench/pins_irq_req
add wave -noupdate -radix hexadecimal /testbench/pin_wait
add wave -noupdate -radix hexadecimal /testbench/ext_input
add wave -noupdate -radix hexadecimal -childformat {{{/testbench/address_bus[21]} -radix hexadecimal} {{/testbench/address_bus[20]} -radix hexadecimal} {{/testbench/address_bus[19]} -radix hexadecimal} {{/testbench/address_bus[18]} -radix hexadecimal} {{/testbench/address_bus[17]} -radix hexadecimal} {{/testbench/address_bus[16]} -radix hexadecimal} {{/testbench/address_bus[15]} -radix hexadecimal} {{/testbench/address_bus[14]} -radix hexadecimal} {{/testbench/address_bus[13]} -radix hexadecimal} {{/testbench/address_bus[12]} -radix hexadecimal} {{/testbench/address_bus[11]} -radix hexadecimal} {{/testbench/address_bus[10]} -radix hexadecimal} {{/testbench/address_bus[9]} -radix hexadecimal} {{/testbench/address_bus[8]} -radix hexadecimal} {{/testbench/address_bus[7]} -radix hexadecimal} {{/testbench/address_bus[6]} -radix hexadecimal} {{/testbench/address_bus[5]} -radix hexadecimal} {{/testbench/address_bus[4]} -radix hexadecimal} {{/testbench/address_bus[3]} -radix hexadecimal} {{/testbench/address_bus[2]} -radix hexadecimal} {{/testbench/address_bus[1]} -radix hexadecimal} {{/testbench/address_bus[0]} -radix hexadecimal}} -subitemconfig {{/testbench/address_bus[21]} {-height 15 -radix hexadecimal} {/testbench/address_bus[20]} {-height 15 -radix hexadecimal} {/testbench/address_bus[19]} {-height 15 -radix hexadecimal} {/testbench/address_bus[18]} {-height 15 -radix hexadecimal} {/testbench/address_bus[17]} {-height 15 -radix hexadecimal} {/testbench/address_bus[16]} {-height 15 -radix hexadecimal} {/testbench/address_bus[15]} {-height 15 -radix hexadecimal} {/testbench/address_bus[14]} {-height 15 -radix hexadecimal} {/testbench/address_bus[13]} {-height 15 -radix hexadecimal} {/testbench/address_bus[12]} {-height 15 -radix hexadecimal} {/testbench/address_bus[11]} {-height 15 -radix hexadecimal} {/testbench/address_bus[10]} {-height 15 -radix hexadecimal} {/testbench/address_bus[9]} {-height 15 -radix hexadecimal} {/testbench/address_bus[8]} {-height 15 -radix hexadecimal} {/testbench/address_bus[7]} {-height 15 -radix hexadecimal} {/testbench/address_bus[6]} {-height 15 -radix hexadecimal} {/testbench/address_bus[5]} {-height 15 -radix hexadecimal} {/testbench/address_bus[4]} {-height 15 -radix hexadecimal} {/testbench/address_bus[3]} {-height 15 -radix hexadecimal} {/testbench/address_bus[2]} {-height 15 -radix hexadecimal} {/testbench/address_bus[1]} {-height 15 -radix hexadecimal} {/testbench/address_bus[0]} {-height 15 -radix hexadecimal}} /testbench/address_bus
add wave -noupdate -radix hexadecimal /testbench/data_bus
add wave -noupdate -radix hexadecimal /testbench/rd
add wave -noupdate -radix hexadecimal /testbench/wr
add wave -noupdate -radix hexadecimal /testbench/mem_io
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/ctrl_mdr_l_wrt
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/ctrl_mdr_h_wrt
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/marl
add wave -noupdate -radix hexadecimal -childformat {{{/testbench/u_cpu_top/marh[7]} -radix hexadecimal} {{/testbench/u_cpu_top/marh[6]} -radix hexadecimal} {{/testbench/u_cpu_top/marh[5]} -radix hexadecimal} {{/testbench/u_cpu_top/marh[4]} -radix hexadecimal} {{/testbench/u_cpu_top/marh[3]} -radix hexadecimal} {{/testbench/u_cpu_top/marh[2]} -radix hexadecimal} {{/testbench/u_cpu_top/marh[1]} -radix hexadecimal} {{/testbench/u_cpu_top/marh[0]} -radix hexadecimal}} -subitemconfig {{/testbench/u_cpu_top/marh[7]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/marh[6]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/marh[5]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/marh[4]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/marh[3]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/marh[2]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/marh[1]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/marh[0]} {-height 15 -radix hexadecimal}} /testbench/u_cpu_top/marh
add wave -noupdate -radix hexadecimal -childformat {{{/testbench/u_cpu_top/mdrl[7]} -radix hexadecimal} {{/testbench/u_cpu_top/mdrl[6]} -radix hexadecimal} {{/testbench/u_cpu_top/mdrl[5]} -radix hexadecimal} {{/testbench/u_cpu_top/mdrl[4]} -radix hexadecimal} {{/testbench/u_cpu_top/mdrl[3]} -radix hexadecimal} {{/testbench/u_cpu_top/mdrl[2]} -radix hexadecimal} {{/testbench/u_cpu_top/mdrl[1]} -radix hexadecimal} {{/testbench/u_cpu_top/mdrl[0]} -radix hexadecimal}} -subitemconfig {{/testbench/u_cpu_top/mdrl[7]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/mdrl[6]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/mdrl[5]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/mdrl[4]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/mdrl[3]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/mdrl[2]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/mdrl[1]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/mdrl[0]} {-height 15 -radix hexadecimal}} /testbench/u_cpu_top/mdrl
add wave -noupdate -radix hexadecimal -childformat {{{/testbench/u_cpu_top/mdrh[7]} -radix hexadecimal} {{/testbench/u_cpu_top/mdrh[6]} -radix hexadecimal} {{/testbench/u_cpu_top/mdrh[5]} -radix hexadecimal} {{/testbench/u_cpu_top/mdrh[4]} -radix hexadecimal} {{/testbench/u_cpu_top/mdrh[3]} -radix hexadecimal} {{/testbench/u_cpu_top/mdrh[2]} -radix hexadecimal} {{/testbench/u_cpu_top/mdrh[1]} -radix hexadecimal} {{/testbench/u_cpu_top/mdrh[0]} -radix hexadecimal}} -subitemconfig {{/testbench/u_cpu_top/mdrh[7]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/mdrh[6]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/mdrh[5]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/mdrh[4]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/mdrh[3]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/mdrh[2]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/mdrh[1]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/mdrh[0]} {-height 15 -radix hexadecimal}} /testbench/u_cpu_top/mdrh
add wave -noupdate -radix hexadecimal -childformat {{{/testbench/u_cpu_top/pcl[7]} -radix hexadecimal} {{/testbench/u_cpu_top/pcl[6]} -radix hexadecimal} {{/testbench/u_cpu_top/pcl[5]} -radix hexadecimal} {{/testbench/u_cpu_top/pcl[4]} -radix hexadecimal} {{/testbench/u_cpu_top/pcl[3]} -radix hexadecimal} {{/testbench/u_cpu_top/pcl[2]} -radix hexadecimal} {{/testbench/u_cpu_top/pcl[1]} -radix hexadecimal} {{/testbench/u_cpu_top/pcl[0]} -radix hexadecimal}} -subitemconfig {{/testbench/u_cpu_top/pcl[7]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/pcl[6]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/pcl[5]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/pcl[4]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/pcl[3]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/pcl[2]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/pcl[1]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/pcl[0]} {-height 15 -radix hexadecimal}} /testbench/u_cpu_top/pcl
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/pch
add wave -noupdate /testbench/u_cpu_top/u_alu/a
add wave -noupdate /testbench/u_cpu_top/u_alu/b
add wave -noupdate /testbench/u_cpu_top/u_alu/cf_in
add wave -noupdate -radix binary /testbench/u_cpu_top/u_alu/op
add wave -noupdate /testbench/u_cpu_top/u_alu/mode
add wave -noupdate /testbench/u_cpu_top/u_alu/alu_out
add wave -noupdate /testbench/u_cpu_top/u_alu/cf_out
add wave -noupdate -radix hexadecimal /testbench/bios_ram_cs
add wave -noupdate -radix hexadecimal /testbench/bios_rom_cs
add wave -noupdate -radix hexadecimal /testbench/addr_bus_7_to_14_alltrue
add wave -noupdate -radix hexadecimal /testbench/peripheral_access
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/arst
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/clk
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/data_bus_in
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/pins_irq_req
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/dma_req
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/pin_wait
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/ext_input
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/address_bus
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/data_bus_out
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/rd
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/wr
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/mem_io
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/halt
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/dma_ack
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/ir
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/ptb
add wave -noupdate -radix hexadecimal -childformat {{{/testbench/u_cpu_top/cpu_status[7]} -radix hexadecimal} {{/testbench/u_cpu_top/cpu_status[6]} -radix hexadecimal} {{/testbench/u_cpu_top/cpu_status[5]} -radix hexadecimal} {{/testbench/u_cpu_top/cpu_status[4]} -radix hexadecimal} {{/testbench/u_cpu_top/cpu_status[3]} -radix hexadecimal} {{/testbench/u_cpu_top/cpu_status[2]} -radix hexadecimal} {{/testbench/u_cpu_top/cpu_status[1]} -radix hexadecimal} {{/testbench/u_cpu_top/cpu_status[0]} -radix hexadecimal}} -subitemconfig {{/testbench/u_cpu_top/cpu_status[7]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/cpu_status[6]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/cpu_status[5]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/cpu_status[4]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/cpu_status[3]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/cpu_status[2]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/cpu_status[1]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/cpu_status[0]} {-height 15 -radix hexadecimal}} /testbench/u_cpu_top/cpu_status
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/alu_flags
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/irq_masks
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/irq_status
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/irq_vector
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/x_bus
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/w_bus
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/y_bus
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/k_bus
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/z_bus
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/alu_out
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/alu_zf
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/alu_cf
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/alu_sf
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/alu_of
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/alu_final_cf
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/u_flags
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/alu_cf_in
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/irq_request
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/irq_dff
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/ctrl_typ
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/ctrl_offset
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/ctrl_cond_invert
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/ctrl_cond_flag_src
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/ctrl_cond_sel
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/ctrl_escape
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/ctrl_u_zf_in_src
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/ctrl_u_cf_in_src
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/ctrl_u_sf_in_src
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/ctrl_u_of_in_src
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/ctrl_ir_wrt
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/ctrl_shift_src
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/ctrl_zbus_src
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/ctrl_alu_a_src
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/ctrl_alu_op
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/ctrl_alu_mode
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/ctrl_alu_cf_in_src
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/ctrl_alu_cf_in_invert
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/ctrl_alu_cf_out_invert
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/ctrl_zf_in_src
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/ctrl_cf_in_src
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/ctrl_sf_in_src
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/ctrl_of_in_src
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/ctrl_rd
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/ctrl_wr
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/ctrl_alu_b_src
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/ctrl_display_reg_load
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/ctrl_dl_wrt
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/ctrl_dh_wrt
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/ctrl_cl_wrt
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/ctrl_ch_wrt
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/ctrl_bl_wrt
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/ctrl_bh_wrt
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/ctrl_al_wrt
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/ctrl_ah_wrt
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/ctrl_mdr_in_src
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/ctrl_mdr_out_src
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/ctrl_mdr_out_en
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/ctrl_tdr_l_wrt
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/ctrl_tdr_h_wrt
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/ctrl_di_l_wrt
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/ctrl_di_h_wrt
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/ctrl_si_l_wrt
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/ctrl_si_h_wrt
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/ctrl_mar_l_wrt
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/ctrl_mar_h_wrt
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/ctrl_bp_l_wrt
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/ctrl_bp_h_wrt
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/ctrl_pc_l_wrt
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/ctrl_pc_h_wrt
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/ctrl_sp_l_wrt
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/ctrl_sp_h_wrt
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/ctrl_gl_wrt
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/ctrl_gh_wrt
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/ctrl_int_vector_wrt
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/ctrl_irq_masks_wrt
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/ctrl_mar_in_src
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/ctrl_int_ack
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/ctrl_clear_all_ints
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/ctrl_ptb_wrt
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/ctrl_page_table_we
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/ctrl_mdr_to_pagetable_data_en
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/ctrl_force_user_ptb
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/ctrl_immy
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/pagetable_addr_source
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/bus_tristate
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/int_pending
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/mdr_to_pagetable_data
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/bus_rd
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/bus_wr
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/bus_mem_io
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/irq_clear
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/u_microcode_sequencer/arst
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/u_microcode_sequencer/clk
add wave -noupdate -radix hexadecimal -childformat {{{/testbench/u_cpu_top/u_microcode_sequencer/ir[7]} -radix hexadecimal} {{/testbench/u_cpu_top/u_microcode_sequencer/ir[6]} -radix hexadecimal} {{/testbench/u_cpu_top/u_microcode_sequencer/ir[5]} -radix hexadecimal} {{/testbench/u_cpu_top/u_microcode_sequencer/ir[4]} -radix hexadecimal} {{/testbench/u_cpu_top/u_microcode_sequencer/ir[3]} -radix hexadecimal} {{/testbench/u_cpu_top/u_microcode_sequencer/ir[2]} -radix hexadecimal} {{/testbench/u_cpu_top/u_microcode_sequencer/ir[1]} -radix hexadecimal} {{/testbench/u_cpu_top/u_microcode_sequencer/ir[0]} -radix hexadecimal}} -subitemconfig {{/testbench/u_cpu_top/u_microcode_sequencer/ir[7]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/u_microcode_sequencer/ir[6]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/u_microcode_sequencer/ir[5]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/u_microcode_sequencer/ir[4]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/u_microcode_sequencer/ir[3]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/u_microcode_sequencer/ir[2]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/u_microcode_sequencer/ir[1]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/u_microcode_sequencer/ir[0]} {-height 15 -radix hexadecimal}} /testbench/u_cpu_top/u_microcode_sequencer/ir
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/u_microcode_sequencer/alu_flags
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/u_microcode_sequencer/cpu_status
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/u_microcode_sequencer/alu_out
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/u_microcode_sequencer/z_bus
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/u_microcode_sequencer/alu_of
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/u_microcode_sequencer/alu_final_cf
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/u_microcode_sequencer/dma_req
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/u_microcode_sequencer/_wait
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/u_microcode_sequencer/int_pending
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/u_microcode_sequencer/ext_input
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/u_microcode_sequencer/u_flags
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/u_microcode_sequencer/ctrl_typ
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/u_microcode_sequencer/ctrl_offset
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/u_microcode_sequencer/ctrl_cond_invert
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/u_microcode_sequencer/ctrl_cond_flag_src
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/u_microcode_sequencer/ctrl_cond_sel
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/u_microcode_sequencer/ctrl_escape
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/u_microcode_sequencer/ctrl_u_zf_in_src
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/u_microcode_sequencer/ctrl_u_cf_in_src
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/u_microcode_sequencer/ctrl_u_sf_in_src
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/u_microcode_sequencer/ctrl_u_of_in_src
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/u_microcode_sequencer/ctrl_ir_wrt
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/u_microcode_sequencer/ctrl_shift_src
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/u_microcode_sequencer/ctrl_zbus_src
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/u_microcode_sequencer/ctrl_alu_a_src
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/u_microcode_sequencer/ctrl_alu_op
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/u_microcode_sequencer/ctrl_alu_mode
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/u_microcode_sequencer/ctrl_alu_cf_in_src
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/u_microcode_sequencer/ctrl_alu_cf_in_invert
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/u_microcode_sequencer/ctrl_alu_cf_out_invert
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/u_microcode_sequencer/ctrl_zf_in_src
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/u_microcode_sequencer/ctrl_cf_in_src
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/u_microcode_sequencer/ctrl_sf_in_src
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/u_microcode_sequencer/ctrl_of_in_src
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/u_microcode_sequencer/ctrl_rd
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/u_microcode_sequencer/ctrl_wr
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/u_microcode_sequencer/ctrl_alu_b_src
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/u_microcode_sequencer/ctrl_display_reg_load
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/u_microcode_sequencer/ctrl_dl_wrt
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/u_microcode_sequencer/ctrl_dh_wrt
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/u_microcode_sequencer/ctrl_cl_wrt
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/u_microcode_sequencer/ctrl_ch_wrt
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/u_microcode_sequencer/ctrl_bl_wrt
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/u_microcode_sequencer/ctrl_bh_wrt
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/u_microcode_sequencer/ctrl_al_wrt
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/u_microcode_sequencer/ctrl_ah_wrt
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/u_microcode_sequencer/ctrl_mdr_in_src
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/u_microcode_sequencer/ctrl_mdr_out_src
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/u_microcode_sequencer/ctrl_mdr_out_en
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/u_microcode_sequencer/ctrl_mdr_l_wrt
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/u_microcode_sequencer/ctrl_mdr_h_wrt
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/u_microcode_sequencer/ctrl_tdr_l_wrt
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/u_microcode_sequencer/ctrl_tdr_h_wrt
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/u_microcode_sequencer/ctrl_di_l_wrt
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/u_microcode_sequencer/ctrl_di_h_wrt
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/u_microcode_sequencer/ctrl_si_l_wrt
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/u_microcode_sequencer/ctrl_si_h_wrt
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/u_microcode_sequencer/ctrl_mar_l_wrt
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/u_microcode_sequencer/ctrl_mar_h_wrt
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/u_microcode_sequencer/ctrl_bp_l_wrt
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/u_microcode_sequencer/ctrl_bp_h_wrt
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/u_microcode_sequencer/ctrl_pc_l_wrt
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/u_microcode_sequencer/ctrl_pc_h_wrt
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/u_microcode_sequencer/ctrl_sp_l_wrt
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/u_microcode_sequencer/ctrl_sp_h_wrt
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/u_microcode_sequencer/ctrl_gl_wrt
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/u_microcode_sequencer/ctrl_gh_wrt
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/u_microcode_sequencer/ctrl_int_vector_wrt
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/u_microcode_sequencer/ctrl_irq_masks_wrt
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/u_microcode_sequencer/ctrl_mar_in_src
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/u_microcode_sequencer/ctrl_int_ack
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/u_microcode_sequencer/ctrl_clear_all_ints
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/u_microcode_sequencer/ctrl_ptb_wrt
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/u_microcode_sequencer/ctrl_page_table_we
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/u_microcode_sequencer/ctrl_mdr_to_pagetable_data_en
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/u_microcode_sequencer/ctrl_force_user_ptb
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/u_microcode_sequencer/ctrl_immy
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/u_microcode_sequencer/any_interruption
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/u_microcode_sequencer/ucode_roms
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/u_microcode_sequencer/control_word
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/u_microcode_sequencer/control_word_n
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/u_microcode_sequencer/u_address
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/u_microcode_sequencer/final_condition
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/u_microcode_sequencer/cond_flag_src
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/u_microcode_sequencer/u_zf_in_src
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/u_microcode_sequencer/u_cf_in_src
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/u_microcode_sequencer/u_sf_in_src
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/u_microcode_sequencer/u_of_in_src
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/u_microcode_sequencer/cond_invert
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/u_microcode_sequencer/cond_sel
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/u_microcode_sequencer/u_escape
add wave -noupdate -radix hexadecimal /testbench/u_bios_rom/mem
add wave -noupdate -radix hexadecimal /testbench/u_bios_rom/ce_n
add wave -noupdate -radix hexadecimal /testbench/u_bios_rom/oe_n
add wave -noupdate -radix hexadecimal /testbench/clk
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {12781940 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {105105 ns}
