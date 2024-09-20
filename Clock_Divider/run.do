vlib work
vlog *.*v
vsim -voptargs=+acc work.tb_clock_divider
do wave.do
run -all
