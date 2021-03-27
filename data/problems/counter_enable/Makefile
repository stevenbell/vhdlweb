
GHDL=ghdl
FLAGS="--std=08"
NETLIST=netlist.json

all: run

gold:
	@$(GHDL) -a $(FLAGS) testbench.vhd counter_enable_gold.vhd
	@$(GHDL) -e $(FLAGS) counter_enable_test
	@$(GHDL) -r $(FLAGS) counter_enable_test --stop-time=1us

run:
	@$(GHDL) -a $(FLAGS) testbench.vhd submission.vhd
	@$(GHDL) -e $(FLAGS) counter_enable_test
	@$(GHDL) -r $(FLAGS) counter_enable_test --stop-time=1us

$(NETLIST):
	@$(GHDL) -a $(FLAGS) submission.vhd
	@yosys -m ghdl -p "ghdl $(FLAGS) counter_enable; write_json $(NETLIST)"

