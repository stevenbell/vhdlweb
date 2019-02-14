
GHDL=/home/vhdlweb/ghdl/build/ghdl_mcode

all: run

gold:
	@$(GHDL) -a testbench.vhd nand3_gold.vhd
	@$(GHDL) -e nand3_test
	@$(GHDL) -r nand3_test

run:
	@$(GHDL) -a testbench.vhd submission.vhd
	@$(GHDL) -e nand3_test
	@$(GHDL) -r nand3_test

