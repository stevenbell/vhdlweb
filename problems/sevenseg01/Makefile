
GHDL=/home/vhdlweb/ghdl/build/ghdl_mcode

all: run

gold:
	@$(GHDL) -a testbench.vhd sevenseg01_gold.vhd
	@$(GHDL) -e sevenseg01_test
	@$(GHDL) -r sevenseg01_test

run:
	@$(GHDL) -a testbench.vhd submission.vhd
	@$(GHDL) -e sevenseg01_test
	@$(GHDL) -r sevenseg01_test

