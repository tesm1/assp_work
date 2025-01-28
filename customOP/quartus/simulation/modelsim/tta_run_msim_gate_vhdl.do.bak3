transcript on
if {[file exists gate_work]} {
	vdel -lib gate_work -all
}
vlib gate_work
vmap work gate_work

vcom -93 -work work {tta.vho}

vcom -93 -work work {/home/user/work/customOP/quartus/../../../testbench/testbench.vhdl}
vcom -93 -work work {/home/user/work/customOP/quartus/../../../testbench/clkgen.vhdl}

vsim -t 1ps +transport_int_delays +transport_path_delays -sdftyp /testbench/power_tb=tta_vhd.sdo -L altera -L cycloneiii -L gate_work -L work -voptargs="+acc"  beeench

source tta_dump_all_vcd_nodes.tcl
add wave *
view structure
view signals
run 30 sec
