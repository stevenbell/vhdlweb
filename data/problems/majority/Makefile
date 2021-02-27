
GHDL=ghdl
FLAGS="--std=08"

all: run

gold:
	@$(GHDL) -a $(FLAGS) testbench.vhd majority_gold.vhd
	@$(GHDL) -e $(FLAGS) majority_test
	@$(GHDL) -r $(FLAGS) majority_test --stop-time=1us

run:
	@$(GHDL) -a $(FLAGS) testbench.vhd submission.vhd
	@$(GHDL) -e $(FLAGS) majority_test
	@$(GHDL) -r $(FLAGS) majority_test --stop-time=1us

