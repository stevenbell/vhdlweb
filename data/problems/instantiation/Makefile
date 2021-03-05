
GHDL=ghdl
FLAGS="--std=08"

all: run

gold:
	@$(GHDL) -a $(FLAGS) testbench.vhd nand4.vhd instantiation_gold.vhd
	@$(GHDL) -e $(FLAGS) instantiation_test
	@$(GHDL) -r $(FLAGS) instantiation_test --stop-time=1us

run:
	@$(GHDL) -a $(FLAGS) testbench.vhd nand4.vhd submission.vhd
	@$(GHDL) -e $(FLAGS) instantiation_test
	@$(GHDL) -r $(FLAGS) instantiation_test --stop-time=1us

