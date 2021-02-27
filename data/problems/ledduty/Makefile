
GHDL=ghdl
FLAGS="--std=08"

all: run

gold:
	@$(GHDL) -a $(FLAGS) testbench.vhd ledduty_gold.vhd
	@$(GHDL) -e $(FLAGS) ledduty_test
	@$(GHDL) -r $(FLAGS) ledduty_test --stop-time=5ms

run:
	@$(GHDL) -a $(FLAGS) testbench.vhd submission.vhd
	@$(GHDL) -e $(FLAGS) ledduty_test
	@$(GHDL) -r $(FLAGS) ledduty_test --stop-time=5ms

