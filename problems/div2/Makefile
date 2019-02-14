
GHDL=/home/vhdlweb/ghdl/build/ghdl_mcode

all: run

gold:
	@$(GHDL) -a testbench.vhd div2_gold.vhd
	@$(GHDL) -e div2_test
	@$(GHDL) -r div2_test

run:
	@$(GHDL) -a testbench.vhd submission.vhd
	@$(GHDL) -e div2_test
	@$(GHDL) -r div2_test

