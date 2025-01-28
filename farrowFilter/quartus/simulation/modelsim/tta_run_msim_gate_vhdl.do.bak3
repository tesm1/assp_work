transcript on
if {[file exists gate_work]} {
	vdel -lib gate_work -all
}
vlib gate_work
vmap work gate_work

vcom -93 -work work {tta.vho}

vcom -93 -work work {/home/user/work/v2farrow/quartus/../../../testbench/clkgen.vhdl}
vcom -93 -work work {/home/user/work/v2farrow/quartus/../../../testbench/testbench.vhdl}

vsim -t 1ps +transport_int_delays +transport_path_delays -sdftyp /testbench/power_tb=tta_vhd.sdo -L altera -L cycloneiii -L gate_work -L work -voptargs="+acc"  testbench

add wave *
view structure
view signals
run 30 us
