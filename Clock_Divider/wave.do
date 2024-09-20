onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_clock_divider/REF_CLK_PERIOD
add wave -noupdate -color Yellow /tb_clock_divider/tb_clk_en
add wave -noupdate -color Magenta /tb_clock_divider/tb_div_clk
add wave -noupdate /tb_clock_divider/tb_div_ratio
add wave -noupdate /tb_clock_divider/tb_ref_clk
add wave -noupdate -color Cyan /tb_clock_divider/tb_rst_n
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {13 ps} 0}
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
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {132 ps}
