
GHDL=/home/vhdlweb/ghdl/build/ghdl_mcode
FLAGS="--std=08"

all: run

gold:
	@$(GHDL) -a $(FLAGS) testbench.vhd abc_gold.vhd
	@$(GHDL) -e $(FLAGS) abc_test
	@$(GHDL) -r $(FLAGS) abc_test --stop-time=1us

run:
	#if grep "use std.textio.all" submission.vhd > /dev/null; then \
	#echo "ERROR: Don't use std.textio.all"; \
	#sed -i 's/use std.textio.all;//g' submission.vhd; fi
	@$(GHDL) -a $(FLAGS) testbench.vhd submission.vhd
	@$(GHDL) -e $(FLAGS) abc_test
	@$(GHDL) -r $(FLAGS) abc_test --stop-time=1us
