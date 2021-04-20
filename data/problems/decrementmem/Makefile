
GHDL=ghdl
FLAGS="--std=08"
NETLIST=netlist.json

all: run

gold:
	@$(GHDL) -a $(FLAGS) testbench.vhd decrementmem_gold.vhd
	@$(GHDL) -e $(FLAGS) decrementmem_test
	@$(GHDL) -r $(FLAGS) decrementmem_test --stop-time=10us

run:
	@$(GHDL) -a $(FLAGS) testbench.vhd submission.vhd
	@$(GHDL) -e $(FLAGS) decrementmem_test
	@$(GHDL) -r $(FLAGS) decrementmem_test --stop-time=10us

$(NETLIST):
	@$(GHDL) -a $(FLAGS) submission.vhd
	@yosys -m ghdl -p "ghdl $(FLAGS) decrementmem; write_json $(NETLIST)"

