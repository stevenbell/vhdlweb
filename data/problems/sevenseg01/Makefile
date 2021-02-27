
GHDL=ghdl
FLAGS="--std=08"

all: run

gold:
	@$(GHDL) -a $(FLAGS) testbench.vhd sevenseg01_gold.vhd
	@$(GHDL) -e $(FLAGS) sevenseg01_test
	@$(GHDL) -r $(FLAGS) sevenseg01_test --stop-time=1us

run:
	@$(GHDL) -a $(FLAGS) testbench.vhd submission.vhd
	@$(GHDL) -e $(FLAGS) sevenseg01_test
	@$(GHDL) -r $(FLAGS) sevenseg01_test --stop-time=1us

