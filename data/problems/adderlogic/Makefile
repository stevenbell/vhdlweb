
GHDL=ghdl
FLAGS="--std=08"

all: run

gold:
	@$(GHDL) -a $(FLAGS) testbench.vhd adderlogic_gold.vhd
	@$(GHDL) -e $(FLAGS) adderlogic_test
	@$(GHDL) -r $(FLAGS) adderlogic_test --stop-time=1us

run:
	@$(GHDL) -a $(FLAGS) testbench.vhd submission.vhd
	@$(GHDL) -e $(FLAGS) adderlogic_test
	@$(GHDL) -r $(FLAGS) adderlogic_test --stop-time=1us

