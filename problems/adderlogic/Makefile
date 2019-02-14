
GHDL=/home/vhdlweb/ghdl/build/ghdl_mcode

all: run

gold:
	@$(GHDL) -a testbench.vhd adderlogic_gold.vhd
	@$(GHDL) -e adderlogic_test
	@$(GHDL) -r adderlogic_test

run:
	@$(GHDL) -a testbench.vhd submission.vhd
	@$(GHDL) -e adderlogic_test
	@$(GHDL) -r adderlogic_test

