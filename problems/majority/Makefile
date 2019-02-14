
GHDL=/home/vhdlweb/ghdl/build/ghdl_mcode

all: run

gold:
	@$(GHDL) -a testbench.vhd majority_gold.vhd
	@$(GHDL) -e majority_test
	@$(GHDL) -r majority_test

run:
	@$(GHDL) -a testbench.vhd submission.vhd
	@$(GHDL) -e majority_test
	@$(GHDL) -r majority_test

