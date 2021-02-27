
GHDL=ghdl
FLAGS="--std=08"

all: run

gold:
	@$(GHDL) -a $(FLAGS) testbench.vhd div2_gold.vhd
	@$(GHDL) -e $(FLAGS) div2_test
	@$(GHDL) -r $(FLAGS) div2_test --stop-time=1us

run:
	@$(GHDL) -a $(FLAGS) testbench.vhd submission.vhd
	@$(GHDL) -e $(FLAGS) div2_test
	@$(GHDL) -r $(FLAGS) div2_test --stop-time=1us

