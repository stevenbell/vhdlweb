
GHDL=ghdl
FLAGS="--std=08"

all: run

gold:
	@$(GHDL) -a $(FLAGS) testbench.vhd thermometer_gold.vhd
	@$(GHDL) -e $(FLAGS) thermometer_test
	@$(GHDL) -r $(FLAGS) thermometer_test --stop-time=1us

run:
	@$(GHDL) -a $(FLAGS) testbench.vhd submission.vhd
	@$(GHDL) -e $(FLAGS) thermometer_test
	@$(GHDL) -r $(FLAGS) thermometer_test --stop-time=1us

