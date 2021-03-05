
GHDL=ghdl
FLAGS="--std=08"

all: run

gold:
	@$(GHDL) -a $(FLAGS) testbench.vhd thing1.vhd thing2.vhd structural1_gold.vhd
	@$(GHDL) -e $(FLAGS) structural1_test
	@$(GHDL) -r $(FLAGS) structural1_test --stop-time=1us

run:
	@$(GHDL) -a $(FLAGS) testbench.vhd thing1.vhd thing2.vhd submission.vhd
	@$(GHDL) -e $(FLAGS) structural1_test
	@$(GHDL) -r $(FLAGS) structural1_test --stop-time=1us

