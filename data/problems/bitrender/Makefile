
GHDL=ghdl
FLAGS="--std=08"
NETLIST=netlist.json

all: run

gold:
	@$(GHDL) -a $(FLAGS) testbench.vhd rom.vhd bitrender_gold.vhd
	@$(GHDL) -e $(FLAGS) bitrender_test
	@$(GHDL) -r $(FLAGS) bitrender_test --stop-time=10us

run:
	@$(GHDL) -a $(FLAGS) testbench.vhd rom.vhd submission.vhd
	@$(GHDL) -e $(FLAGS) bitrender_test
	@$(GHDL) -r $(FLAGS) bitrender_test --stop-time=10us

$(NETLIST):
	@$(GHDL) -a $(FLAGS) submission.vhd
	@yosys -m ghdl -p "ghdl $(FLAGS) bitrender; write_json $(NETLIST)"

