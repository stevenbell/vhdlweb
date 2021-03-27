
GHDL=ghdl
FLAGS="--std=08"
NETLIST=netlist.json

all: run

gold:
	@$(GHDL) -a $(FLAGS) testbench.vhd onehot_gold.vhd
	@$(GHDL) -e $(FLAGS) onehot_test
	@$(GHDL) -r $(FLAGS) onehot_test --stop-time=1us

run:
	@$(GHDL) -a $(FLAGS) testbench.vhd submission.vhd
	@$(GHDL) -e $(FLAGS) onehot_test
	@$(GHDL) -r $(FLAGS) onehot_test --stop-time=1us

$(NETLIST):
	@$(GHDL) -a $(FLAGS) submission.vhd
	@yosys -m ghdl -p "ghdl $(FLAGS) onehot; write_json $(NETLIST)"

