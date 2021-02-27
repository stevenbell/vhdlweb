
GHDL=ghdl
FLAGS="--std=08"

all: run

gold:
	@$(GHDL) -a $(FLAGS) testbench.vhd hsosc.vhd ledblink_gold.vhd
	@$(GHDL) -e $(FLAGS) ledblink_test
	@$(GHDL) -r $(FLAGS) ledblink_test --stop-time=2000us

run:
	@$(GHDL) -a $(FLAGS) testbench.vhd hsosc.vhd submission.vhd
	@$(GHDL) -e $(FLAGS) ledblink_test
	@$(GHDL) -r $(FLAGS) ledblink_test --stop-time=2000us

