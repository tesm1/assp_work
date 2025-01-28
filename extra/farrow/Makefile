CC = tcecc
CFLAGS = -O3

# source files
SOURCE_FILE=source.c
TCEASM_SOURCE_FILE=my_program.tceasm

# compilation/dissassebly result files
TPEF_FILE=program.tpef
TCEASM_FILE=program.tceasm

# processor files
ADF_FILE=processor.adf
BEM_FILE=processor.bem
IDF_FILE=processor.idf


PROCESSOR_NAME=myProssu
MIF_FORMAT=mif
OUTPUT_DIR=hdl_filesV3


# default target
all: assemble generate_bits



# ------------------ compiling program ------------------

# $(TPEF_FILE): $(TCEASM_SOURCE_FILE) $(ADF_FILE)
# 	@echo "\n[*] Compiling program"
# 	$(CC) $(CFLAGS) -a $(ADF_FILE) -o $@ $<


$(TPEF_FILE):  $(ADF_FILE) $(TCEASM_SOURCE_FILE)
	@echo "\n[*] Compiling from assembly"
	tceasm -o $@ $^


$(TCEASM_FILE): $(ADF_FILE) $(TPEF_FILE)
	@echo "\n[*] Disassembling program"
	tcedisasm -n -o $@ $^



# -------------- generating processor files --------------

$(BEM_FILE):
	@echo "\n[*] Creating BEM"
	createbem $(ADF_FILE)


$(OUTPUT_DIR): $(BEM_FILE) $(ADF_FILE) $(IDF_FILE)
	@echo "\n[*] Generating vhdl files"
	generateprocessor -b $(BEM_FILE) -e $(PROCESSOR_NAME) -l 'vhdl' -i $(IDF_FILE) -o $@ $(ADF_FILE)



# -------------- main build targets --------------

.PHONY: tpef
tpef: $(TPEF_FILE)

.PHONY: assemble
assemble: $(ADF_FILE) $(TCEASM_SOURCE_FILE)
	tceasm -o $(TPEF_FILE) $^

.PHONY: disassemble
disassemble: $(TCEASM_FILE)

.PHONY: generate_bits
generate_bits: $(OUTPUT_DIR) $(BEM_FILE) $(TPEF_FILE) $(ADF_FILE)
	@echo "\n[*] Generating mif files"
	generatebits -e $(PROCESSOR_NAME) -b $(BEM_FILE) -d -w 4 -p $(TPEF_FILE) -x $(OUTPUT_DIR) -f $(MIF_FORMAT) -o $(MIF_FORMAT) $(ADF_FILE)

.PHONY: cycles
cycles: $(TPEF_FILE) $(ADF_FILE)
	ttasim -a $(ADF_FILE) -p $(TPEF_FILE) -e"run; puts [info proc cycles]; quit"



# Clean up
.PHONY: clean
clean:
	@echo "\n[*] Cleaning generated files..."
	rm -rf $(BEM_FILE) $(OUTPUT_DIR) *.mif
	rm -f $(TPEF_FILE) $(TCEASM_FILE)




