
GHDL=/home/vhdlweb/ghdl/build/ghdl_mcode

all: run

gold:
	@$(GHDL) -a testbench.vhd add1_gold.vhd
	@$(GHDL) -e add1_test
	@$(GHDL) -r add1_test

run:
	@$(GHDL) -a testbench.vhd submission.vhd
	@$(GHDL) -e add1_test
	@$(GHDL) -r add1_test

