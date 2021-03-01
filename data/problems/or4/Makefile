
GHDL=ghdl
FLAGS="--std=08"

all: run

gold:
	@$(GHDL) -a $(FLAGS) testbench.vhd or4_gold.vhd
	@$(GHDL) -e $(FLAGS) or4_test
	@$(GHDL) -r $(FLAGS) or4_test --stop-time=1us

run:
	@$(GHDL) -a $(FLAGS) testbench.vhd submission.vhd
	@$(GHDL) -e $(FLAGS) or4_test
	@$(GHDL) -r $(FLAGS) or4_test --stop-time=1us

