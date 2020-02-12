
GHDL=/home/vhdlweb/ghdl/build/ghdl_mcode
FLAGS="--std=08"

all: run

gold:
	@$(GHDL) -a $(FLAGS) testbench.vhd nand3_gold.vhd
	@$(GHDL) -e $(FLAGS) nand3_test
	@$(GHDL) -r $(FLAGS) nand3_test --stop-time=1us

run:
	@$(GHDL) -a $(FLAGS) testbench.vhd submission.vhd
	@$(GHDL) -e $(FLAGS) nand3_test
	@$(GHDL) -r $(FLAGS) nand3_test --stop-time=1us

