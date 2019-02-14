
GHDL=/home/vhdlweb/ghdl/build/ghdl_mcode

all: run

gold:
	@$(GHDL) -a testbench.vhd saturatingadd_gold.vhd
	@$(GHDL) -e saturatingadd_test
	@$(GHDL) -r saturatingadd_test

run:
	@$(GHDL) -a testbench.vhd submission.vhd
	@$(GHDL) -e saturatingadd_test
	@$(GHDL) -r saturatingadd_test

