
GHDL=ghdl
FLAGS="--std=08"

all: run

gold:
	@$(GHDL) -a $(FLAGS) testbench.vhd onehot_gold.vhd
	@$(GHDL) -e $(FLAGS) onehot_test
	@$(GHDL) -r $(FLAGS) onehot_test --stop-time=1us

run:
	@$(GHDL) -a $(FLAGS) testbench.vhd submission.vhd
	@$(GHDL) -e $(FLAGS) onehot_test
	@$(GHDL) -r $(FLAGS) onehot_test --stop-time=1us

