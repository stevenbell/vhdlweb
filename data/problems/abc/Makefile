
GHDL=ghdl
FLAGS="--std=08"
NETLIST=netlist.json


all: run

gold:
	@$(GHDL) -a $(FLAGS) testbench.vhd abc_gold.vhd
	@$(GHDL) -e $(FLAGS) abc_test
	@$(GHDL) -r $(FLAGS) abc_test --stop-time=1us

run:
	@$(GHDL) -a $(FLAGS) testbench.vhd submission.vhd
	@$(GHDL) -e $(FLAGS) abc_test
	@$(GHDL) -r $(FLAGS) abc_test --stop-time=1us

$(NETLIST):
	@$(GHDL) -a $(FLAGS) submission.vhd
	@yosys -m ghdl -p "ghdl $(FLAGS) abc; write_json $(NETLIST)"

