
GHDL=/home/vhdlweb/ghdl/build/ghdl_mcode
FLAGS="--std=08"

all: run

gold:
	@$(GHDL) -a $(FLAGS) testbench.vhd sevenseg.vhd dddd_gold.vhd
	@$(GHDL) -e $(FLAGS) dddd_test
	@$(GHDL) -r $(FLAGS) dddd_test --stop-time=1us

run:
	@$(GHDL) -a $(FLAGS) testbench.vhd sevenseg.vhd submission.vhd
	@$(GHDL) -e $(FLAGS) dddd_test
	@$(GHDL) -r $(FLAGS) dddd_test --stop-time=1us

