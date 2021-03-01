
GHDL=ghdl
FLAGS="--std=08"

all: run

gold:
	@$(GHDL) -a $(FLAGS) testbench.vhd mux1bit_gold.vhd
	@$(GHDL) -e $(FLAGS) mux1bit_test
	@$(GHDL) -r $(FLAGS) mux1bit_test --stop-time=1us

run:
	@$(GHDL) -a $(FLAGS) testbench.vhd submission.vhd
	@$(GHDL) -e $(FLAGS) mux1bit_test
	@$(GHDL) -r $(FLAGS) mux1bit_test --stop-time=1us

