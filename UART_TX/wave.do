onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group {TB SIGNALS} /UART_TB/CLK_PERIOD
add wave -noupdate -expand -group {TB SIGNALS} -color {Orange Red} /UART_TB/CLK_TB
add wave -noupdate -expand -group {TB SIGNALS} /UART_TB/Data_Valid_TB
add wave -noupdate -expand -group {TB SIGNALS} /UART_TB/PAR_EN_TB
add wave -noupdate -expand -group {TB SIGNALS} /UART_TB/PAR_TYP_TB
add wave -noupdate -expand -group {TB SIGNALS} /UART_TB/P_DATA_TB
add wave -noupdate -expand -group {TB SIGNALS} /UART_TB/RST_TB
add wave -noupdate -expand -group {TB SIGNALS} /UART_TB/TX_OUT_TB
add wave -noupdate -expand -group {TB SIGNALS} /UART_TB/busy_TB
add wave -noupdate -expand -group {TB SIGNALS} /UART_TB/i
add wave -noupdate -expand -group {UART DUT SIGNALS} -color {Orange Red} /UART_TB/TX/CLK
add wave -noupdate -expand -group {UART DUT SIGNALS} /UART_TB/TX/Data_Valid
add wave -noupdate -expand -group {UART DUT SIGNALS} /UART_TB/TX/PAR_EN
add wave -noupdate -expand -group {UART DUT SIGNALS} /UART_TB/TX/PAR_TYP
add wave -noupdate -expand -group {UART DUT SIGNALS} /UART_TB/TX/P_DATA
add wave -noupdate -expand -group {UART DUT SIGNALS} /UART_TB/TX/RST
add wave -noupdate -expand -group {UART DUT SIGNALS} /UART_TB/TX/TX_OUT
add wave -noupdate -expand -group {UART DUT SIGNALS} /UART_TB/TX/busy
add wave -noupdate -expand -group {UART DUT SIGNALS} /UART_TB/TX/mux_sel
add wave -noupdate -expand -group {UART DUT SIGNALS} /UART_TB/TX/par_bit
add wave -noupdate -expand -group {UART DUT SIGNALS} /UART_TB/TX/ser_data
add wave -noupdate -expand -group {UART DUT SIGNALS} /UART_TB/TX/ser_done
add wave -noupdate -expand -group {UART DUT SIGNALS} /UART_TB/TX/ser_en
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 123
configure wave -valuecolwidth 38
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
WaveRestoreZoom {280672 ps} {307292 ps}
