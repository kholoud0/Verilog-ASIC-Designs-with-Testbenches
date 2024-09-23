vlib work
vlog *.*v
vsim -voptargs=+acc work.RX_TB
do wave.do
run -all
