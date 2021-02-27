
GHDL=ghdl
FLAGS="--std=08"

all: run

gold:
	@$(GHDL) -a $(FLAGS) testbench_gold.vhd testbench.vhd
	@$(GHDL) -e $(FLAGS) passcode_test
	@$(GHDL) -r $(FLAGS) passcode_test --stop-time=1ms

run:
	@$(GHDL) -a $(FLAGS) testbench.vhd submission.vhd # Testbench is actually DUT here
	@$(GHDL) -e $(FLAGS) passcode_test
	@$(GHDL) -r $(FLAGS) passcode_test --stop-time=1ms

