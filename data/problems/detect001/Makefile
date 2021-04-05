
GHDL=ghdl
FLAGS="--std=08"
NETLIST=netlist.json

all: run

gold:
	@$(GHDL) -a $(FLAGS) testbench.vhd detect001_gold.vhd
	@$(GHDL) -e $(FLAGS) detect001_test
	@$(GHDL) -r $(FLAGS) detect001_test --stop-time=1us

run:
	@$(GHDL) -a $(FLAGS) testbench.vhd submission.vhd
	@$(GHDL) -e $(FLAGS) detect001_test
	@$(GHDL) -r $(FLAGS) detect001_test --stop-time=1us

$(NETLIST):
	@$(GHDL) -a $(FLAGS) submission.vhd
	@yosys -m ghdl -p "ghdl $(FLAGS) detect001; write_json $(NETLIST)"

