onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -height 20 /testbench/arst
add wave -noupdate -height 20 /testbench/clk
add wave -noupdate -height 20 /testbench/ce_n
add wave -noupdate -height 20 /testbench/oe_n
add wave -noupdate -height 20 /testbench/we_n
add wave -noupdate -height 20 /testbench/address
add wave -noupdate -height 20 /testbench/data
add wave -noupdate -height 20 /testbench/val
add wave -noupdate -height 20 /testbench/u_ide/byteCounter
add wave -noupdate -height 20 /testbench/u_ide/command
add wave -noupdate -height 20 /testbench/u_ide/status
add wave -noupdate -height 20 /testbench/u_ide/currentState
add wave -noupdate -height 20 /testbench/u_ide/nextState
add wave -noupdate -height 20 /testbench/u_ide/LBA
add wave -noupdate -height 20 -expand /testbench/u_ide/registers
add wave -noupdate -height 20 /testbench/u_ide/mem
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {53876494 ps} 0}
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
WaveRestoreZoom {43382568 ps} {91585439 ps}
