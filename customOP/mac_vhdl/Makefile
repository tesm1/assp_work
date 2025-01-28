# Makefile for GHDL and GTKWave

# Variables
DESIGN = my_mac

DESIGN_FILE = $(DESIGN).vhdl
TESTBENCH = $(DESIGN)_tb
TESTBENCH_FILE = $(TESTBENCH).vhd
SRC = $(DESIGN_FILE) $(TESTBENCH_FILE)
TB = $(TESTBENCH)

WAVE = $(TB).ghw
VCD = $(TB).vcd
FLAGS = --std=08


# Default target
all: run


# Debugging target to check files
debug:
	@echo "Design file: $(DESIGN_FILE)"
	@echo "Testbench file: $(TESTBENCH_FILE)"
	@echo "Source files: $(SRC)"
	@echo "Testbench name: $(TB)"
	@echo "Library Flags: $(LIB_FLAGS)"

# Analyze design and testbench files
analyze:
	ghdl -a $(FLAGS) $(LIB_FLAGS) $(SRC)

# Elaborate the testbench
elaborate: analyze
	ghdl -e $(FLAGS) $(LIB_FLAGS) $(TB)

# Run the simulation and generate a waveform file (GHW)
simulate: elaborate
	ghdl -r $(FLAGS) $(LIB_FLAGS) $(TB) --wave=$(WAVE) --stop-time=1ms

# Run the simulation and generate a waveform file (VCD)
simulate-vcd: elaborate
	ghdl -r $(FLAGS) $(LIB_FLAGS) $(TB) --vcd=$(VCD) --stop-time=1ms

# Open the waveform file with GTKWave
view: simulate
	gtkwave $(WAVE)

view-vcd: simulate-vcd
	gtkwave $(VCD)

# Clean generated files
clean:
	rm -f *.o *.cf $(WAVE) $(VCD) $(TB)

# Shortcut for running the entire flow
run: simulate view
run-vcd: simulate-vcd view-vcd

.PHONY: all analyze elaborate simulate simulate-vcd view view-vcd clean run run-vcd debug
