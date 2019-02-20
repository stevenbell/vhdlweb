
GHDL=/home/vhdlweb/ghdl/build/ghdl_mcode
FLAGS="--std=08"

all: run

gold:
	@$(GHDL) -a $(FLAGS) testbench.vhd lfsr4_gold.vhd
	@$(GHDL) -e $(FLAGS) lfsr4_test
	@$(GHDL) -r $(FLAGS) lfsr4_test --stop-time=1us

run:
	@$(GHDL) -a $(FLAGS) testbench.vhd submission.vhd
	@$(GHDL) -e $(FLAGS) lfsr4_test
	@$(GHDL) -r $(FLAGS) lfsr4_test --stop-time=1us

