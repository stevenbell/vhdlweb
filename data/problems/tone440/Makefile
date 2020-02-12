
GHDL=/home/vhdlweb/ghdl/build/ghdl_mcode
FLAGS="--std=08"

all: run

gold:
	@$(GHDL) -a $(FLAGS) testbench.vhd tone440_gold.vhd
	@$(GHDL) -e $(FLAGS) tone440_test
	@$(GHDL) -r $(FLAGS) tone440_test --stop-time=10ms

run:
	@$(GHDL) -a $(FLAGS) testbench.vhd submission.vhd
	@$(GHDL) -e $(FLAGS) tone440_test
	@$(GHDL) -r $(FLAGS) tone440_test --stop-time=10ms

