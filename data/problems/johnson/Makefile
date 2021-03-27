
GHDL=ghdl
FLAGS="--std=08"
NETLIST=netlist.json

all: run

gold:
	@$(GHDL) -a $(FLAGS) testbench.vhd johnson_gold.vhd
	@$(GHDL) -e $(FLAGS) johnson_test
	@$(GHDL) -r $(FLAGS) johnson_test --stop-time=1us

run:
	@$(GHDL) -a $(FLAGS) testbench.vhd submission.vhd
	@$(GHDL) -e $(FLAGS) johnson_test
	@$(GHDL) -r $(FLAGS) johnson_test --stop-time=1us

$(NETLIST):
	@$(GHDL) -a $(FLAGS) submission.vhd
	@yosys -m ghdl -p "ghdl $(FLAGS) johnson; write_json $(NETLIST)"

