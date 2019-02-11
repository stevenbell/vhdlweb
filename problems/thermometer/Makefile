
GHDL=/home/vhdlweb/ghdl/build/ghdl_mcode

all: run

gold:
	@$(GHDL) -a testbench.vhd thermometer_gold.vhd
	@$(GHDL) -e thermometer_test
	@$(GHDL) -r thermometer_test

run:
	@$(GHDL) -a testbench.vhd submission.vhd
	@$(GHDL) -e thermometer_test
	@$(GHDL) -r thermometer_test

