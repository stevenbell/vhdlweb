
GHDL=/home/vhdlweb/ghdl/build/ghdl_mcode
FLAGS="--std=08"

all: run

gold:
	@$(GHDL) -a $(FLAGS) testbench_gold.vhd testbench.vhd
	@$(GHDL) -e $(FLAGS) adder_test
	@$(GHDL) -r $(FLAGS) adder_test --stop-time=1us

run:
	@$(GHDL) -a $(FLAGS) testbench.vhd submission.vhd # Testbench is actually DUT here
	@$(GHDL) -e $(FLAGS) adder_test
	@$(GHDL) -r $(FLAGS) adder_test --stop-time=1us

