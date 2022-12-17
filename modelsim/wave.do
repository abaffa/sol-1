onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /testbench/arst
add wave -noupdate /testbench/clk_in
add wave -noupdate /testbench/clk
add wave -noupdate /testbench/irq_in
add wave -noupdate /testbench/dma_req
add wave -noupdate /testbench/addr
add wave -noupdate /testbench/data_in
add wave -noupdate /testbench/data_out
add wave -noupdate /testbench/rd
add wave -noupdate /testbench/wr
add wave -noupdate /testbench/mem_io
add wave -noupdate /testbench/halt
add wave -noupdate /testbench/dma_ack
add wave -noupdate /testbench/clk_sel
add wave -noupdate /testbench/stop_clk
add wave -noupdate -divider {New Divider}
add wave -noupdate /testbench/u_cpu_top/arst
add wave -noupdate /testbench/u_cpu_top/clk
add wave -noupdate /testbench/u_cpu_top/data_in
add wave -noupdate /testbench/u_cpu_top/irq_in
add wave -noupdate /testbench/u_cpu_top/dma_req
add wave -noupdate /testbench/u_cpu_top/addr
add wave -noupdate /testbench/u_cpu_top/data_out
add wave -noupdate /testbench/u_cpu_top/rd
add wave -noupdate /testbench/u_cpu_top/wr
add wave -noupdate /testbench/u_cpu_top/mem_io
add wave -noupdate /testbench/u_cpu_top/halt
add wave -noupdate /testbench/u_cpu_top/dma_ack
add wave -noupdate /testbench/u_cpu_top/AH
add wave -noupdate /testbench/u_cpu_top/AL
add wave -noupdate /testbench/u_cpu_top/BH
add wave -noupdate /testbench/u_cpu_top/BL
add wave -noupdate /testbench/u_cpu_top/CH
add wave -noupdate /testbench/u_cpu_top/CL
add wave -noupdate /testbench/u_cpu_top/DH
add wave -noupdate /testbench/u_cpu_top/DL
add wave -noupdate /testbench/u_cpu_top/PCH
add wave -noupdate /testbench/u_cpu_top/PCL
add wave -noupdate /testbench/u_cpu_top/SPH
add wave -noupdate /testbench/u_cpu_top/SPL
add wave -noupdate /testbench/u_cpu_top/SSPH
add wave -noupdate /testbench/u_cpu_top/SSPL
add wave -noupdate /testbench/u_cpu_top/BPH
add wave -noupdate /testbench/u_cpu_top/BPL
add wave -noupdate /testbench/u_cpu_top/SIH
add wave -noupdate /testbench/u_cpu_top/SIL
add wave -noupdate /testbench/u_cpu_top/DIH
add wave -noupdate /testbench/u_cpu_top/DIL
add wave -noupdate /testbench/u_cpu_top/MARH
add wave -noupdate /testbench/u_cpu_top/MARL
add wave -noupdate /testbench/u_cpu_top/MDRH
add wave -noupdate /testbench/u_cpu_top/MDRL
add wave -noupdate /testbench/u_cpu_top/TDRH
add wave -noupdate /testbench/u_cpu_top/TDRL
add wave -noupdate /testbench/u_cpu_top/IRQ_MASKS
add wave -noupdate /testbench/u_cpu_top/IR
add wave -noupdate /testbench/u_cpu_top/PTB
add wave -noupdate /testbench/u_cpu_top/STATUS
add wave -noupdate /testbench/u_cpu_top/MSW
add wave -noupdate /testbench/u_cpu_top/k_bus
add wave -noupdate /testbench/u_cpu_top/w_bus
add wave -noupdate /testbench/u_cpu_top/y_bus
add wave -noupdate /testbench/u_cpu_top/x_bus
add wave -noupdate /testbench/u_cpu_top/z_bus
add wave -noupdate /testbench/u_cpu_top/alu_c_out
add wave -noupdate /testbench/u_cpu_top/control_word
add wave -noupdate -divider {New Divider}
add wave -noupdate /testbench/u_cpu_top/u_microcode_sequencer/arst
add wave -noupdate /testbench/u_cpu_top/u_microcode_sequencer/clk
add wave -noupdate /testbench/u_cpu_top/u_microcode_sequencer/ir
add wave -noupdate /testbench/u_cpu_top/u_microcode_sequencer/alu_flags
add wave -noupdate /testbench/u_cpu_top/u_microcode_sequencer/status
add wave -noupdate /testbench/u_cpu_top/u_microcode_sequencer/control_word
add wave -noupdate /testbench/u_cpu_top/u_microcode_sequencer/u_address
add wave -noupdate /testbench/u_cpu_top/u_microcode_sequencer/next1
add wave -noupdate /testbench/u_cpu_top/u_microcode_sequencer/next0
add wave -noupdate /testbench/u_cpu_top/u_microcode_sequencer/u_offset
add wave -noupdate /testbench/u_cpu_top/u_microcode_sequencer/final_condition
add wave -noupdate /testbench/u_cpu_top/u_microcode_sequencer/fetch_u_address
add wave -noupdate /testbench/u_cpu_top/u_microcode_sequencer/trap_u_address
add wave -noupdate /testbench/u_cpu_top/u_microcode_sequencer/any_interruption
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {6667 ns} 0}
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
WaveRestoreZoom {0 ns} {21525 ns}
