onerror {resume}
quietly virtual function -install /testbench/u_cpu_top/u_microcode_sequencer -env /testbench/#INITIAL#38(#ublk#178839128#38) { &{/testbench/u_cpu_top/u_microcode_sequencer/u_address[5], /testbench/u_cpu_top/u_microcode_sequencer/u_address[4], /testbench/u_cpu_top/u_microcode_sequencer/u_address[3], /testbench/u_cpu_top/u_microcode_sequencer/u_address[2], /testbench/u_cpu_top/u_microcode_sequencer/u_address[1], /testbench/u_cpu_top/u_microcode_sequencer/u_address[0] }} u_cycle
quietly WaveActivateNextPane {} 0
add wave -noupdate /testbench/arst
add wave -noupdate /testbench/stop_clk_req
add wave -noupdate /testbench/u_clock/stop_clk
add wave -noupdate /testbench/clk
add wave -noupdate /testbench/pins_irq_req
add wave -noupdate /testbench/dma_ack
add wave -noupdate /testbench/dma_req
add wave -noupdate /testbench/rd
add wave -noupdate /testbench/wr
add wave -noupdate /testbench/mem_io
add wave -noupdate /testbench/address_bus
add wave -noupdate /testbench/data_bus
add wave -noupdate -divider {== IDE ==}
add wave -noupdate /testbench/u_ide/address
add wave -noupdate /testbench/u_ide/arst
add wave -noupdate -radix unsigned /testbench/u_ide/byteCounter
add wave -noupdate /testbench/u_ide/ce_n
add wave -noupdate /testbench/u_ide/command
add wave -noupdate /testbench/u_ide/currentState
add wave -noupdate /testbench/u_ide/nextState
add wave -noupdate /testbench/u_ide/data_in
add wave -noupdate /testbench/u_ide/data_out
add wave -noupdate /testbench/u_ide/LBA
add wave -noupdate /testbench/u_ide/mem
add wave -noupdate /testbench/u_ide/oe_n
add wave -noupdate /testbench/u_ide/registers
add wave -noupdate -radix unsigned -childformat {{{/testbench/u_ide/status[7]} -radix unsigned} {{/testbench/u_ide/status[6]} -radix unsigned} {{/testbench/u_ide/status[5]} -radix unsigned} {{/testbench/u_ide/status[4]} -radix unsigned} {{/testbench/u_ide/status[3]} -radix unsigned} {{/testbench/u_ide/status[2]} -radix unsigned} {{/testbench/u_ide/status[1]} -radix unsigned} {{/testbench/u_ide/status[0]} -radix unsigned}} -subitemconfig {{/testbench/u_ide/status[7]} {-radix unsigned} {/testbench/u_ide/status[6]} {-radix unsigned} {/testbench/u_ide/status[5]} {-radix unsigned} {/testbench/u_ide/status[4]} {-radix unsigned} {/testbench/u_ide/status[3]} {-radix unsigned} {/testbench/u_ide/status[2]} {-radix unsigned} {/testbench/u_ide/status[1]} {-radix unsigned} {/testbench/u_ide/status[0]} {-radix unsigned}} /testbench/u_ide/status
add wave -noupdate /testbench/u_ide/we_n
add wave -noupdate -divider {== CS ==}
add wave -noupdate /testbench/bios_config_cs
add wave -noupdate /testbench/bios_ram_cs
add wave -noupdate /testbench/bios_rom_cs
add wave -noupdate /testbench/ide_cs
add wave -noupdate /testbench/pio0_cs
add wave -noupdate /testbench/pio1_cs
add wave -noupdate /testbench/rtc_cs
add wave -noupdate /testbench/timer_cs
add wave -noupdate /testbench/uart0_cs
add wave -noupdate /testbench/uart1_cs
add wave -noupdate -divider {== MICROCODE ==}
add wave -noupdate /testbench/u_cpu_top/ctrl_cond_flag_src
add wave -noupdate /testbench/u_cpu_top/ctrl_cond_invert
add wave -noupdate /testbench/u_cpu_top/ctrl_cond_sel
add wave -noupdate /testbench/u_cpu_top/u_microcode_sequencer/ir
add wave -noupdate /testbench/u_cpu_top/u_microcode_sequencer/u_cycle
add wave -noupdate /testbench/u_cpu_top/u_microcode_sequencer/u_address
add wave -noupdate /testbench/u_cpu_top/u_microcode_sequencer/u_flags
add wave -noupdate /testbench/u_cpu_top/u_microcode_sequencer/any_interruption
add wave -noupdate /testbench/u_cpu_top/u_microcode_sequencer/final_condition
add wave -noupdate /testbench/u_cpu_top/u_microcode_sequencer/int_pending
add wave -noupdate -divider {== CPU TOP ==}
add wave -noupdate /testbench/u_cpu_top/cpu_flags
add wave -noupdate /testbench/u_cpu_top/cpu_status
add wave -noupdate /testbench/u_cpu_top/bus_tristate
add wave -noupdate /testbench/u_cpu_top/mdrl
add wave -noupdate /testbench/u_cpu_top/mdrh
add wave -noupdate /testbench/u_cpu_top/marl
add wave -noupdate /testbench/u_cpu_top/marh
add wave -noupdate /testbench/u_cpu_top/pcl
add wave -noupdate /testbench/u_cpu_top/pch
add wave -noupdate /testbench/u_cpu_top/ptb
add wave -noupdate /testbench/u_cpu_top/spl
add wave -noupdate /testbench/u_cpu_top/sph
add wave -noupdate /testbench/u_cpu_top/sspl
add wave -noupdate /testbench/u_cpu_top/ssph
add wave -noupdate /testbench/u_cpu_top/al
add wave -noupdate /testbench/u_cpu_top/ah
add wave -noupdate -divider {== ALU ==}
add wave -noupdate /testbench/u_cpu_top/ctrl_alu_a_src
add wave -noupdate /testbench/u_cpu_top/ctrl_alu_b_src
add wave -noupdate /testbench/u_cpu_top/ctrl_alu_cf_in_invert
add wave -noupdate /testbench/u_cpu_top/ctrl_alu_cf_in_src
add wave -noupdate /testbench/u_cpu_top/ctrl_alu_cf_out_invert
add wave -noupdate /testbench/u_cpu_top/ctrl_alu_mode
add wave -noupdate /testbench/u_cpu_top/ctrl_alu_op
add wave -noupdate /testbench/u_cpu_top/w_bus
add wave -noupdate /testbench/u_cpu_top/x_bus
add wave -noupdate /testbench/u_cpu_top/k_bus
add wave -noupdate /testbench/u_cpu_top/y_bus
add wave -noupdate /testbench/u_cpu_top/z_bus
add wave -noupdate /testbench/u_cpu_top/alu_out
add wave -noupdate /testbench/u_cpu_top/alu_zf
add wave -noupdate /testbench/u_cpu_top/alu_cf_in
add wave -noupdate /testbench/u_cpu_top/alu_cf_out
add wave -noupdate /testbench/u_cpu_top/alu_final_cf
add wave -noupdate /testbench/u_cpu_top/alu_of
add wave -noupdate /testbench/u_cpu_top/alu_sf
add wave -noupdate -divider {== REGISTERS ==}
add wave -noupdate /testbench/u_cpu_top/al
add wave -noupdate /testbench/u_cpu_top/ah
add wave -noupdate /testbench/u_cpu_top/bl
add wave -noupdate /testbench/u_cpu_top/bh
add wave -noupdate /testbench/u_cpu_top/bpl
add wave -noupdate /testbench/u_cpu_top/bph
add wave -noupdate /testbench/u_cpu_top/cl
add wave -noupdate /testbench/u_cpu_top/ch
add wave -noupdate /testbench/u_cpu_top/dl
add wave -noupdate /testbench/u_cpu_top/dh
add wave -noupdate /testbench/u_cpu_top/dil
add wave -noupdate /testbench/u_cpu_top/dih
add wave -noupdate /testbench/u_cpu_top/gl
add wave -noupdate /testbench/u_cpu_top/gh
add wave -noupdate /testbench/u_cpu_top/sil
add wave -noupdate /testbench/u_cpu_top/sih
add wave -noupdate /testbench/u_cpu_top/tdrl
add wave -noupdate /testbench/u_cpu_top/tdrh
add wave -noupdate /testbench/u_cpu_top/irq_clear
add wave -noupdate /testbench/u_cpu_top/irq_dff
add wave -noupdate /testbench/u_cpu_top/irq_masks
add wave -noupdate /testbench/u_cpu_top/irq_request
add wave -noupdate /testbench/u_cpu_top/irq_status
add wave -noupdate /testbench/u_cpu_top/irq_vector
add wave -noupdate /testbench/u_cpu_top/mdr_to_pagetable_data
add wave -noupdate /testbench/u_cpu_top/pagetable_addr_source
add wave -noupdate -divider {== CONTROL ==}
add wave -noupdate /testbench/u_cpu_top/ctrl_ah_wrt
add wave -noupdate /testbench/u_cpu_top/ctrl_al_wrt
add wave -noupdate /testbench/u_cpu_top/ctrl_bh_wrt
add wave -noupdate /testbench/u_cpu_top/ctrl_bl_wrt
add wave -noupdate /testbench/u_cpu_top/ctrl_bp_h_wrt
add wave -noupdate /testbench/u_cpu_top/ctrl_bp_l_wrt
add wave -noupdate /testbench/u_cpu_top/ctrl_cf_in_src
add wave -noupdate /testbench/u_cpu_top/ctrl_ch_wrt
add wave -noupdate /testbench/u_cpu_top/ctrl_cl_wrt
add wave -noupdate /testbench/u_cpu_top/ctrl_clear_all_ints
add wave -noupdate /testbench/u_cpu_top/ctrl_cond_flag_src
add wave -noupdate /testbench/u_cpu_top/ctrl_cond_invert
add wave -noupdate -expand /testbench/u_cpu_top/ctrl_cond_sel
add wave -noupdate /testbench/u_cpu_top/ctrl_dh_wrt
add wave -noupdate /testbench/u_cpu_top/ctrl_di_h_wrt
add wave -noupdate /testbench/u_cpu_top/ctrl_di_l_wrt
add wave -noupdate /testbench/u_cpu_top/ctrl_display_reg_load
add wave -noupdate /testbench/u_cpu_top/ctrl_dl_wrt
add wave -noupdate /testbench/u_cpu_top/ctrl_escape
add wave -noupdate /testbench/u_cpu_top/ctrl_force_user_ptb
add wave -noupdate /testbench/u_cpu_top/ctrl_gh_wrt
add wave -noupdate /testbench/u_cpu_top/ctrl_gl_wrt
add wave -noupdate /testbench/u_cpu_top/ctrl_immy
add wave -noupdate /testbench/u_cpu_top/ctrl_int_ack
add wave -noupdate /testbench/u_cpu_top/ctrl_int_vector_wrt
add wave -noupdate /testbench/u_cpu_top/ctrl_ir_wrt
add wave -noupdate /testbench/u_cpu_top/ctrl_irq_masks_wrt
add wave -noupdate /testbench/u_cpu_top/ctrl_mar_h_wrt
add wave -noupdate /testbench/u_cpu_top/ctrl_mar_in_src
add wave -noupdate /testbench/u_cpu_top/ctrl_mar_l_wrt
add wave -noupdate /testbench/u_cpu_top/ctrl_mdr_h_wrt
add wave -noupdate /testbench/u_cpu_top/ctrl_mdr_in_src
add wave -noupdate /testbench/u_cpu_top/ctrl_mdr_l_wrt
add wave -noupdate /testbench/u_cpu_top/ctrl_mdr_out_en
add wave -noupdate /testbench/u_cpu_top/ctrl_mdr_out_src
add wave -noupdate /testbench/u_cpu_top/ctrl_mdr_to_pagetable_data_en
add wave -noupdate /testbench/u_cpu_top/ctrl_of_in_src
add wave -noupdate /testbench/u_cpu_top/ctrl_offset
add wave -noupdate /testbench/u_cpu_top/ctrl_page_table_we
add wave -noupdate /testbench/u_cpu_top/ctrl_pc_h_wrt
add wave -noupdate /testbench/u_cpu_top/ctrl_pc_l_wrt
add wave -noupdate /testbench/u_cpu_top/ctrl_ptb_wrt
add wave -noupdate /testbench/u_cpu_top/ctrl_rd
add wave -noupdate /testbench/u_cpu_top/ctrl_sf_in_src
add wave -noupdate /testbench/u_cpu_top/ctrl_shift_src
add wave -noupdate /testbench/u_cpu_top/ctrl_si_h_wrt
add wave -noupdate /testbench/u_cpu_top/ctrl_si_l_wrt
add wave -noupdate /testbench/u_cpu_top/ctrl_sp_h_wrt
add wave -noupdate /testbench/u_cpu_top/ctrl_sp_l_wrt
add wave -noupdate /testbench/u_cpu_top/ctrl_status_wrt
add wave -noupdate /testbench/u_cpu_top/ctrl_tdr_h_wrt
add wave -noupdate /testbench/u_cpu_top/ctrl_tdr_l_wrt
add wave -noupdate /testbench/u_cpu_top/ctrl_typ
add wave -noupdate /testbench/u_cpu_top/ctrl_u_cf_in_src
add wave -noupdate /testbench/u_cpu_top/ctrl_u_of_in_src
add wave -noupdate /testbench/u_cpu_top/ctrl_u_sf_in_src
add wave -noupdate /testbench/u_cpu_top/ctrl_u_zf_in_src
add wave -noupdate /testbench/u_cpu_top/ctrl_wr
add wave -noupdate /testbench/u_cpu_top/ctrl_zbus_src
add wave -noupdate /testbench/u_cpu_top/ctrl_zf_in_src
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {30026345726 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 190
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
WaveRestoreZoom {29985329935 ps} {30190408881 ps}
bookmark add wave bookmark0 {{8339320171 ps} {8349290586 ps}} 16
bookmark add wave bookmark1 {{8307101692 ps} {8389800233 ps}} 0
bookmark add wave bookmark2 {{27041948331 ps} {27046366383 ps}} 24
