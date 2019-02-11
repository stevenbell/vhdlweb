
GHDL=/home/vhdlweb/ghdl/build/ghdl_mcode

all: run

gold:
	@$(GHDL) -a testbench.vhd abc_gold.vhd
	@$(GHDL) -e abc_test
	@$(GHDL) -r abc_test

run:
	@$(GHDL) -a testbench.vhd submission.vhd
	@$(GHDL) -e abc_test
	@$(GHDL) -r abc_test

