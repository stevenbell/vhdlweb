
GHDL=/home/vhdlweb/ghdl/build/ghdl_mcode
FLAGS="--std=08"

all: run

gold:
	@$(GHDL) -a $(FLAGS) testbench.vhd gene_findtt_gold.vhd
	@$(GHDL) -e $(FLAGS) gene_findtt_test
	@$(GHDL) -r $(FLAGS) gene_findtt_test --stop-time=1us

run:
	@$(GHDL) -a $(FLAGS) testbench.vhd submission.vhd
	@$(GHDL) -e $(FLAGS) gene_findtt_test
	@$(GHDL) -r $(FLAGS) gene_findtt_test --stop-time=1us

