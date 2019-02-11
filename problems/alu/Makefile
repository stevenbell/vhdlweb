
GHDL=/home/vhdlweb/ghdl/build/ghdl_mcode

all: run

gold:
	@$(GHDL) -a testbench.vhd alu_gold.vhd
	@$(GHDL) -e alu_test
	@$(GHDL) -r alu_test

run:
	@$(GHDL) -a testbench.vhd submission.vhd
	@$(GHDL) -e alu_test
	@$(GHDL) -r alu_test

