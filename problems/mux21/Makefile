
GHDL=/home/vhdlweb/ghdl/build/ghdl_mcode

all: run

gold:
	@$(GHDL) -a testbench.vhd mux21_gold.vhd
	@$(GHDL) -e mux21_test
	@$(GHDL) -r mux21_test

run:
	@$(GHDL) -a testbench.vhd submission.vhd
	@$(GHDL) -e mux21_test
	@$(GHDL) -r mux21_test

