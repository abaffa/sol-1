onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /testbench/arst
add wave -noupdate /testbench/clk
add wave -noupdate /testbench/u_ide/currentState
add wave -noupdate /testbench/u_ide/nextState
add wave -noupdate /testbench/ce_n
add wave -noupdate /testbench/oe_n
add wave -noupdate /testbench/we_n
add wave -noupdate /testbench/address
add wave -noupdate /testbench/data
add wave -noupdate /testbench/u_ide/data_in
add wave -noupdate /testbench/u_ide/data_out
add wave -noupdate /testbench/u_ide/LBA
add wave -noupdate /testbench/u_ide/byteCounter
add wave -noupdate /testbench/u_ide/mem
add wave -noupdate -expand /testbench/u_ide/registers
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1140837105 ps} 0}
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
WaveRestoreZoom {1130129794 ps} {1206835275 ps}
