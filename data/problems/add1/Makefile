
GHDL=ghdl
FLAGS="--std=08"

all: run

gold:
	@$(GHDL) -a $(FLAGS) testbench.vhd add1_gold.vhd
	@$(GHDL) -e $(FLAGS) add1_test
	@$(GHDL) -r $(FLAGS) add1_test --stop-time=1us

run:
	@$(GHDL) -a $(FLAGS) testbench.vhd submission.vhd
	@$(GHDL) -e $(FLAGS) add1_test
	@$(GHDL) -r $(FLAGS) add1_test --stop-time=1us

