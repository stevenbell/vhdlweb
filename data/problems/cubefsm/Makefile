
GHDL=ghdl
FLAGS="--std=08"
NETLIST=netlist.json

all: run

gold:
	@$(GHDL) -a $(FLAGS) testbench.vhd cubefsm_gold.vhd
	@$(GHDL) -e $(FLAGS) cubefsm_test
	@$(GHDL) -r $(FLAGS) cubefsm_test --stop-time=1us

run:
	@$(GHDL) -a $(FLAGS) testbench.vhd submission.vhd
	@$(GHDL) -e $(FLAGS) cubefsm_test
	@$(GHDL) -r $(FLAGS) cubefsm_test --stop-time=1us

$(NETLIST):
	@$(GHDL) -a $(FLAGS) submission.vhd
	@yosys -m ghdl -p "ghdl $(FLAGS) cubefsm; write_json $(NETLIST)"

