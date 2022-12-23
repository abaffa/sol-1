onerror {resume}
quietly virtual function -install /testbench/u_cpu_top/u_microcode_sequencer -env /testbench/#INITIAL#39(#ublk#0#41) { &{/testbench/u_cpu_top/u_microcode_sequencer/u_address[13], /testbench/u_cpu_top/u_microcode_sequencer/u_address[12], /testbench/u_cpu_top/u_microcode_sequencer/u_address[11], /testbench/u_cpu_top/u_microcode_sequencer/u_address[10], /testbench/u_cpu_top/u_microcode_sequencer/u_address[9], /testbench/u_cpu_top/u_microcode_sequencer/u_address[8], /testbench/u_cpu_top/u_microcode_sequencer/u_address[7], /testbench/u_cpu_top/u_microcode_sequencer/u_address[6] }} u_address_high
quietly virtual function -install /testbench/u_cpu_top/u_microcode_sequencer -env /testbench/#INITIAL#39(#ublk#0#41) { &{/testbench/u_cpu_top/u_microcode_sequencer/u_address[5], /testbench/u_cpu_top/u_microcode_sequencer/u_address[4], /testbench/u_cpu_top/u_microcode_sequencer/u_address[3], /testbench/u_cpu_top/u_microcode_sequencer/u_address[2], /testbench/u_cpu_top/u_microcode_sequencer/u_address[1], /testbench/u_cpu_top/u_microcode_sequencer/u_address[0] }} u_address_cycle
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /testbench/clk
add wave -noupdate /testbench/arst
add wave -noupdate /testbench/u_clock/stop_clk
add wave -noupdate /testbench/u_clock/stop_clk_req
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/ctrl_typ
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/ctrl_offset
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/ctrl_cond_invert
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/ctrl_cond_flag_src
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/ctrl_cond_sel
add wave -noupdate /testbench/u_cpu_top/u_microcode_sequencer/u_address_high
add wave -noupdate /testbench/u_cpu_top/u_microcode_sequencer/u_address_cycle
add wave -noupdate -radix hexadecimal -childformat {{{/testbench/u_cpu_top/u_microcode_sequencer/u_address[13]} -radix hexadecimal} {{/testbench/u_cpu_top/u_microcode_sequencer/u_address[12]} -radix hexadecimal} {{/testbench/u_cpu_top/u_microcode_sequencer/u_address[11]} -radix hexadecimal} {{/testbench/u_cpu_top/u_microcode_sequencer/u_address[10]} -radix hexadecimal} {{/testbench/u_cpu_top/u_microcode_sequencer/u_address[9]} -radix hexadecimal} {{/testbench/u_cpu_top/u_microcode_sequencer/u_address[8]} -radix hexadecimal} {{/testbench/u_cpu_top/u_microcode_sequencer/u_address[7]} -radix hexadecimal} {{/testbench/u_cpu_top/u_microcode_sequencer/u_address[6]} -radix hexadecimal} {{/testbench/u_cpu_top/u_microcode_sequencer/u_address[5]} -radix hexadecimal} {{/testbench/u_cpu_top/u_microcode_sequencer/u_address[4]} -radix hexadecimal} {{/testbench/u_cpu_top/u_microcode_sequencer/u_address[3]} -radix hexadecimal} {{/testbench/u_cpu_top/u_microcode_sequencer/u_address[2]} -radix hexadecimal} {{/testbench/u_cpu_top/u_microcode_sequencer/u_address[1]} -radix hexadecimal} {{/testbench/u_cpu_top/u_microcode_sequencer/u_address[0]} -radix hexadecimal}} -subitemconfig {{/testbench/u_cpu_top/u_microcode_sequencer/u_address[13]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/u_microcode_sequencer/u_address[12]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/u_microcode_sequencer/u_address[11]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/u_microcode_sequencer/u_address[10]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/u_microcode_sequencer/u_address[9]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/u_microcode_sequencer/u_address[8]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/u_microcode_sequencer/u_address[7]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/u_microcode_sequencer/u_address[6]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/u_microcode_sequencer/u_address[5]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/u_microcode_sequencer/u_address[4]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/u_microcode_sequencer/u_address[3]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/u_microcode_sequencer/u_address[2]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/u_microcode_sequencer/u_address[1]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/u_microcode_sequencer/u_address[0]} {-height 15 -radix hexadecimal}} /testbench/u_cpu_top/u_microcode_sequencer/u_address
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
add wave -noupdate -radix hexadecimal -childformat {{{/testbench/u_cpu_top/u_alu/a[7]} -radix hexadecimal} {{/testbench/u_cpu_top/u_alu/a[6]} -radix hexadecimal} {{/testbench/u_cpu_top/u_alu/a[5]} -radix hexadecimal} {{/testbench/u_cpu_top/u_alu/a[4]} -radix hexadecimal} {{/testbench/u_cpu_top/u_alu/a[3]} -radix hexadecimal} {{/testbench/u_cpu_top/u_alu/a[2]} -radix hexadecimal} {{/testbench/u_cpu_top/u_alu/a[1]} -radix hexadecimal} {{/testbench/u_cpu_top/u_alu/a[0]} -radix hexadecimal}} -subitemconfig {{/testbench/u_cpu_top/u_alu/a[7]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/u_alu/a[6]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/u_alu/a[5]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/u_alu/a[4]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/u_alu/a[3]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/u_alu/a[2]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/u_alu/a[1]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/u_alu/a[0]} {-height 15 -radix hexadecimal}} /testbench/u_cpu_top/u_alu/a
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/u_alu/b
add wave -noupdate -radix hexadecimal -childformat {{{/testbench/u_cpu_top/u_alu/alu_out[7]} -radix hexadecimal} {{/testbench/u_cpu_top/u_alu/alu_out[6]} -radix hexadecimal} {{/testbench/u_cpu_top/u_alu/alu_out[5]} -radix hexadecimal} {{/testbench/u_cpu_top/u_alu/alu_out[4]} -radix hexadecimal} {{/testbench/u_cpu_top/u_alu/alu_out[3]} -radix hexadecimal} {{/testbench/u_cpu_top/u_alu/alu_out[2]} -radix hexadecimal} {{/testbench/u_cpu_top/u_alu/alu_out[1]} -radix hexadecimal} {{/testbench/u_cpu_top/u_alu/alu_out[0]} -radix hexadecimal}} -subitemconfig {{/testbench/u_cpu_top/u_alu/alu_out[7]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/u_alu/alu_out[6]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/u_alu/alu_out[5]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/u_alu/alu_out[4]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/u_alu/alu_out[3]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/u_alu/alu_out[2]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/u_alu/alu_out[1]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/u_alu/alu_out[0]} {-height 15 -radix hexadecimal}} /testbench/u_cpu_top/u_alu/alu_out
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/u_alu/cf_in
add wave -noupdate /testbench/u_cpu_top/u_alu/alu_cf_out
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/alu_final_cf
add wave -noupdate -radix hexadecimal -childformat {{{/testbench/u_cpu_top/u_alu/op[3]} -radix hexadecimal} {{/testbench/u_cpu_top/u_alu/op[2]} -radix hexadecimal} {{/testbench/u_cpu_top/u_alu/op[1]} -radix hexadecimal} {{/testbench/u_cpu_top/u_alu/op[0]} -radix hexadecimal}} -subitemconfig {{/testbench/u_cpu_top/u_alu/op[3]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/u_alu/op[2]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/u_alu/op[1]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/u_alu/op[0]} {-height 15 -radix hexadecimal}} /testbench/u_cpu_top/u_alu/op
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/u_alu/mode
add wave -noupdate -radix hexadecimal -childformat {{{/testbench/u_cpu_top/ctrl_alu_cf_in_src[1]} -radix hexadecimal} {{/testbench/u_cpu_top/ctrl_alu_cf_in_src[0]} -radix hexadecimal}} -subitemconfig {{/testbench/u_cpu_top/ctrl_alu_cf_in_src[1]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/ctrl_alu_cf_in_src[0]} {-height 15 -radix hexadecimal}} /testbench/u_cpu_top/ctrl_alu_cf_in_src
add wave -noupdate -radix hexadecimal -childformat {{{/testbench/u_cpu_top/ctrl_cf_in_src[2]} -radix hexadecimal} {{/testbench/u_cpu_top/ctrl_cf_in_src[1]} -radix hexadecimal} {{/testbench/u_cpu_top/ctrl_cf_in_src[0]} -radix hexadecimal}} -subitemconfig {{/testbench/u_cpu_top/ctrl_cf_in_src[2]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/ctrl_cf_in_src[1]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/ctrl_cf_in_src[0]} {-height 15 -radix hexadecimal}} /testbench/u_cpu_top/ctrl_cf_in_src
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/ctrl_alu_cf_in_invert
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/ctrl_alu_cf_out_invert
add wave -noupdate /testbench/u_cpu_top/ah
add wave -noupdate /testbench/u_cpu_top/al
add wave -noupdate /testbench/u_cpu_top/bh
add wave -noupdate /testbench/u_cpu_top/bl
add wave -noupdate /testbench/u_cpu_top/ch
add wave -noupdate /testbench/u_cpu_top/cl
add wave -noupdate /testbench/u_cpu_top/dh
add wave -noupdate /testbench/u_cpu_top/dl
add wave -noupdate /testbench/u_cpu_top/sph
add wave -noupdate /testbench/u_cpu_top/spl
add wave -noupdate /testbench/u_cpu_top/ssph
add wave -noupdate /testbench/u_cpu_top/sspl
add wave -noupdate /testbench/u_cpu_top/bph
add wave -noupdate /testbench/u_cpu_top/bpl
add wave -noupdate /testbench/u_cpu_top/sih
add wave -noupdate /testbench/u_cpu_top/sil
add wave -noupdate /testbench/u_cpu_top/dih
add wave -noupdate /testbench/u_cpu_top/dil
add wave -noupdate -radix hexadecimal -childformat {{{/testbench/u_cpu_top/u_flags[7]} -radix hexadecimal} {{/testbench/u_cpu_top/u_flags[6]} -radix hexadecimal} {{/testbench/u_cpu_top/u_flags[5]} -radix hexadecimal} {{/testbench/u_cpu_top/u_flags[4]} -radix hexadecimal} {{/testbench/u_cpu_top/u_flags[3]} -radix hexadecimal} {{/testbench/u_cpu_top/u_flags[2]} -radix hexadecimal} {{/testbench/u_cpu_top/u_flags[1]} -radix hexadecimal} {{/testbench/u_cpu_top/u_flags[0]} -radix hexadecimal}} -subitemconfig {{/testbench/u_cpu_top/u_flags[7]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/u_flags[6]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/u_flags[5]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/u_flags[4]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/u_flags[3]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/u_flags[2]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/u_flags[1]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/u_flags[0]} {-height 15 -radix hexadecimal}} /testbench/u_cpu_top/u_flags
add wave -noupdate -expand /testbench/u_cpu_top/cpu_flags
add wave -noupdate -radix hexadecimal /testbench/bios_rom_cs
add wave -noupdate -radix hexadecimal -childformat {{{/testbench/u_cpu_top/ir[7]} -radix hexadecimal} {{/testbench/u_cpu_top/ir[6]} -radix hexadecimal} {{/testbench/u_cpu_top/ir[5]} -radix hexadecimal} {{/testbench/u_cpu_top/ir[4]} -radix hexadecimal} {{/testbench/u_cpu_top/ir[3]} -radix hexadecimal} {{/testbench/u_cpu_top/ir[2]} -radix hexadecimal} {{/testbench/u_cpu_top/ir[1]} -radix hexadecimal} {{/testbench/u_cpu_top/ir[0]} -radix hexadecimal}} -subitemconfig {{/testbench/u_cpu_top/ir[7]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/ir[6]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/ir[5]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/ir[4]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/ir[3]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/ir[2]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/ir[1]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/ir[0]} {-height 15 -radix hexadecimal}} /testbench/u_cpu_top/ir
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/ctrl_ir_wrt
add wave -noupdate -radix hexadecimal -childformat {{{/testbench/u_cpu_top/cpu_status[7]} -radix hexadecimal} {{/testbench/u_cpu_top/cpu_status[6]} -radix hexadecimal} {{/testbench/u_cpu_top/cpu_status[5]} -radix hexadecimal} {{/testbench/u_cpu_top/cpu_status[4]} -radix hexadecimal} {{/testbench/u_cpu_top/cpu_status[3]} -radix hexadecimal} {{/testbench/u_cpu_top/cpu_status[2]} -radix hexadecimal} {{/testbench/u_cpu_top/cpu_status[1]} -radix hexadecimal} {{/testbench/u_cpu_top/cpu_status[0]} -radix hexadecimal}} -subitemconfig {{/testbench/u_cpu_top/cpu_status[7]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/cpu_status[6]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/cpu_status[5]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/cpu_status[4]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/cpu_status[3]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/cpu_status[2]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/cpu_status[1]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/cpu_status[0]} {-height 15 -radix hexadecimal}} /testbench/u_cpu_top/cpu_status
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
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/ctrl_escape
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/ctrl_u_zf_in_src
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/ctrl_u_cf_in_src
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/ctrl_u_sf_in_src
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/ctrl_u_of_in_src
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/ctrl_shift_src
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/ctrl_zbus_src
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/ctrl_alu_a_src
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/ctrl_alu_op
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/ctrl_alu_mode
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/ctrl_zf_in_src
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
add wave -noupdate -radix hexadecimal -childformat {{{/testbench/u_cpu_top/mdr_to_pagetable_data[15]} -radix hexadecimal} {{/testbench/u_cpu_top/mdr_to_pagetable_data[14]} -radix hexadecimal} {{/testbench/u_cpu_top/mdr_to_pagetable_data[13]} -radix hexadecimal} {{/testbench/u_cpu_top/mdr_to_pagetable_data[12]} -radix hexadecimal} {{/testbench/u_cpu_top/mdr_to_pagetable_data[11]} -radix hexadecimal} {{/testbench/u_cpu_top/mdr_to_pagetable_data[10]} -radix hexadecimal} {{/testbench/u_cpu_top/mdr_to_pagetable_data[9]} -radix hexadecimal} {{/testbench/u_cpu_top/mdr_to_pagetable_data[8]} -radix hexadecimal} {{/testbench/u_cpu_top/mdr_to_pagetable_data[7]} -radix hexadecimal} {{/testbench/u_cpu_top/mdr_to_pagetable_data[6]} -radix hexadecimal} {{/testbench/u_cpu_top/mdr_to_pagetable_data[5]} -radix hexadecimal} {{/testbench/u_cpu_top/mdr_to_pagetable_data[4]} -radix hexadecimal} {{/testbench/u_cpu_top/mdr_to_pagetable_data[3]} -radix hexadecimal} {{/testbench/u_cpu_top/mdr_to_pagetable_data[2]} -radix hexadecimal} {{/testbench/u_cpu_top/mdr_to_pagetable_data[1]} -radix hexadecimal} {{/testbench/u_cpu_top/mdr_to_pagetable_data[0]} -radix hexadecimal}} -subitemconfig {{/testbench/u_cpu_top/mdr_to_pagetable_data[15]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/mdr_to_pagetable_data[14]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/mdr_to_pagetable_data[13]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/mdr_to_pagetable_data[12]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/mdr_to_pagetable_data[11]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/mdr_to_pagetable_data[10]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/mdr_to_pagetable_data[9]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/mdr_to_pagetable_data[8]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/mdr_to_pagetable_data[7]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/mdr_to_pagetable_data[6]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/mdr_to_pagetable_data[5]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/mdr_to_pagetable_data[4]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/mdr_to_pagetable_data[3]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/mdr_to_pagetable_data[2]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/mdr_to_pagetable_data[1]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/mdr_to_pagetable_data[0]} {-height 15 -radix hexadecimal}} /testbench/u_cpu_top/mdr_to_pagetable_data
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/bus_rd
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/bus_wr
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/bus_mem_io
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/irq_clear
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/u_microcode_sequencer/arst
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/u_microcode_sequencer/clk
add wave -noupdate -radix hexadecimal -childformat {{{/testbench/u_cpu_top/u_microcode_sequencer/ir[7]} -radix hexadecimal} {{/testbench/u_cpu_top/u_microcode_sequencer/ir[6]} -radix hexadecimal} {{/testbench/u_cpu_top/u_microcode_sequencer/ir[5]} -radix hexadecimal} {{/testbench/u_cpu_top/u_microcode_sequencer/ir[4]} -radix hexadecimal} {{/testbench/u_cpu_top/u_microcode_sequencer/ir[3]} -radix hexadecimal} {{/testbench/u_cpu_top/u_microcode_sequencer/ir[2]} -radix hexadecimal} {{/testbench/u_cpu_top/u_microcode_sequencer/ir[1]} -radix hexadecimal} {{/testbench/u_cpu_top/u_microcode_sequencer/ir[0]} -radix hexadecimal}} -subitemconfig {{/testbench/u_cpu_top/u_microcode_sequencer/ir[7]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/u_microcode_sequencer/ir[6]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/u_microcode_sequencer/ir[5]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/u_microcode_sequencer/ir[4]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/u_microcode_sequencer/ir[3]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/u_microcode_sequencer/ir[2]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/u_microcode_sequencer/ir[1]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/u_microcode_sequencer/ir[0]} {-height 15 -radix hexadecimal}} /testbench/u_cpu_top/u_microcode_sequencer/ir
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/u_microcode_sequencer/cpu_status
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/u_microcode_sequencer/alu_out
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/u_microcode_sequencer/z_bus
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/u_microcode_sequencer/alu_of
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/u_microcode_sequencer/alu_final_cf
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/u_microcode_sequencer/dma_req
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/u_microcode_sequencer/_wait
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/u_microcode_sequencer/int_pending
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/u_microcode_sequencer/ext_input
add wave -noupdate -radix hexadecimal -childformat {{{/testbench/u_cpu_top/u_microcode_sequencer/u_flags[7]} -radix hexadecimal} {{/testbench/u_cpu_top/u_microcode_sequencer/u_flags[6]} -radix hexadecimal} {{/testbench/u_cpu_top/u_microcode_sequencer/u_flags[5]} -radix hexadecimal} {{/testbench/u_cpu_top/u_microcode_sequencer/u_flags[4]} -radix hexadecimal} {{/testbench/u_cpu_top/u_microcode_sequencer/u_flags[3]} -radix hexadecimal} {{/testbench/u_cpu_top/u_microcode_sequencer/u_flags[2]} -radix hexadecimal} {{/testbench/u_cpu_top/u_microcode_sequencer/u_flags[1]} -radix hexadecimal} {{/testbench/u_cpu_top/u_microcode_sequencer/u_flags[0]} -radix hexadecimal}} -subitemconfig {{/testbench/u_cpu_top/u_microcode_sequencer/u_flags[7]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/u_microcode_sequencer/u_flags[6]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/u_microcode_sequencer/u_flags[5]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/u_microcode_sequencer/u_flags[4]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/u_microcode_sequencer/u_flags[3]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/u_microcode_sequencer/u_flags[2]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/u_microcode_sequencer/u_flags[1]} {-height 15 -radix hexadecimal} {/testbench/u_cpu_top/u_microcode_sequencer/u_flags[0]} {-height 15 -radix hexadecimal}} /testbench/u_cpu_top/u_microcode_sequencer/u_flags
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
add wave -noupdate -radix hexadecimal /testbench/u_cpu_top/u_microcode_sequencer/final_condition
add wave -noupdate -radix hexadecimal /testbench/clk
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {208205 ps} 0}
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
WaveRestoreZoom {0 ps} {5920267 ps}
