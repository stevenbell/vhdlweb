
GHDL=ghdl
FLAGS="--std=08"

all: run

gold:
	@$(GHDL) -a $(FLAGS) testbench.vhd gene_findtt_gold.vhd
	@$(GHDL) -e $(FLAGS) test_findtt
	@$(GHDL) -r $(FLAGS) test_findtt --stop-time=1us

run:
	@$(GHDL) -a $(FLAGS) testbench.vhd submission.vhd
	@$(GHDL) -e $(FLAGS) test_findtt
	@$(GHDL) -r $(FLAGS) test_findtt --stop-time=1us

