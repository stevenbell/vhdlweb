
GHDL=ghdl
FLAGS="--std=08"
NETLIST=netlist.json

all: run

gold:
	@$(GHDL) -a $(FLAGS) testbench.vhd risingedge_gold.vhd
	@$(GHDL) -e $(FLAGS) risingedge_test
	@$(GHDL) -r $(FLAGS) risingedge_test --stop-time=1us

run:
	@$(GHDL) -a $(FLAGS) testbench.vhd submission.vhd
	@$(GHDL) -e $(FLAGS) risingedge_test
	@$(GHDL) -r $(FLAGS) risingedge_test --stop-time=1us

$(NETLIST):
	@$(GHDL) -a $(FLAGS) submission.vhd
	@yosys -m ghdl -p "ghdl $(FLAGS) risingedge; write_json $(NETLIST)"

