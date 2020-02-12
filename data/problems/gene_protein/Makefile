
GHDL=/home/vhdlweb/ghdl/build/ghdl_mcode
FLAGS="--std=08"

all: run

gold:
	@$(GHDL) -a $(FLAGS) testbench.vhd gene_protein_gold.vhd
	@$(GHDL) -e $(FLAGS) gene_protein_test
	@$(GHDL) -r $(FLAGS) gene_protein_test --stop-time=1us

run:
	@$(GHDL) -a $(FLAGS) testbench.vhd submission.vhd
	@$(GHDL) -e $(FLAGS) gene_protein_test
	@$(GHDL) -r $(FLAGS) gene_protein_test --stop-time=1us

