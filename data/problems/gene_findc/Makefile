
GHDL=/home/vhdlweb/ghdl/build/ghdl_mcode
FLAGS="--std=08"

all: run

gold:
	@$(GHDL) -a $(FLAGS) testbench.vhd gene_findc_gold.vhd
	@$(GHDL) -e $(FLAGS) test_findc
	@$(GHDL) -r $(FLAGS) test_findc --stop-time=1us

run:
	@$(GHDL) -a $(FLAGS) testbench.vhd submission.vhd
	@$(GHDL) -e $(FLAGS) test_findc
	@$(GHDL) -r $(FLAGS) test_findc --stop-time=1us

