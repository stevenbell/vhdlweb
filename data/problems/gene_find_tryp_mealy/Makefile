
GHDL=/home/vhdlweb/ghdl/build/ghdl_mcode
FLAGS="--std=08"

all: run

gold:
	@$(GHDL) -a $(FLAGS) testbench.vhd gene_find_tryp_gold.vhd
	@$(GHDL) -e $(FLAGS) test_find_tryp
	@$(GHDL) -r $(FLAGS) test_find_tryp --stop-time=1us

run:
	@$(GHDL) -a $(FLAGS) testbench.vhd submission.vhd
	@$(GHDL) -e $(FLAGS) test_find_tryp
	@$(GHDL) -r $(FLAGS) test_find_tryp --stop-time=1us

