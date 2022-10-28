
GHDL=ghdl
FLAGS="--std=08"
NETLIST=netlist.json

all: run

gold:
	@$(GHDL) -a $(FLAGS) testbench.vhd count5_gold.vhd
	@$(GHDL) -e $(FLAGS) count5_test
	@$(GHDL) -r $(FLAGS) count5_test --stop-time=1us

run:
	@$(GHDL) -a $(FLAGS) testbench.vhd submission.vhd
	@$(GHDL) -e $(FLAGS) count5_test
	@$(GHDL) -r $(FLAGS) count5_test --stop-time=1us

$(NETLIST):
	@$(GHDL) -a $(FLAGS) submission.vhd
	@yosys -m ghdl -p "ghdl $(FLAGS) count5; write_json $(NETLIST)"

