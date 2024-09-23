onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /RX_TB/uut/RX_IN
add wave -noupdate /RX_TB/uut/Prescale
add wave -noupdate /RX_TB/uut/CLK
add wave -noupdate /RX_TB/uut/RST
add wave -noupdate /RX_TB/uut/PAR_TYP
add wave -noupdate /RX_TB/uut/PAR_EN
add wave -noupdate /RX_TB/uut/P_DATA
add wave -noupdate /RX_TB/uut/data_valid
add wave -noupdate /RX_TB/uut/deser_en
add wave -noupdate /RX_TB/uut/sampled_bit
add wave -noupdate /RX_TB/uut/enable
add wave -noupdate /RX_TB/uut/bit_cnt
add wave -noupdate /RX_TB/uut/edge_cnt
add wave -noupdate /RX_TB/uut/par_chk_en
add wave -noupdate /RX_TB/uut/par_err
add wave -noupdate /RX_TB/uut/stp_chk_en
add wave -noupdate /RX_TB/uut/stp_err
add wave -noupdate /RX_TB/uut/strt_chk_en
add wave -noupdate /RX_TB/uut/strt_glitch
add wave -noupdate /RX_TB/uut/dat_samp_en
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
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
WaveRestoreZoom {0 ps} {1 ns}
