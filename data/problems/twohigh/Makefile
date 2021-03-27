
GHDL=ghdl
FLAGS="--std=08"
NETLIST=netlist.json

all: run

gold:
	@$(GHDL) -a $(FLAGS) testbench.vhd twohigh_gold.vhd
	@$(GHDL) -e $(FLAGS) twohigh_test
	@$(GHDL) -r $(FLAGS) twohigh_test --stop-time=1us

run:
	@$(GHDL) -a $(FLAGS) testbench.vhd submission.vhd
	@$(GHDL) -e $(FLAGS) twohigh_test
	@$(GHDL) -r $(FLAGS) twohigh_test --stop-time=1us

$(NETLIST):
	@$(GHDL) -a $(FLAGS) submission.vhd
	@yosys -m ghdl -p "ghdl $(FLAGS) twohigh; write_json $(NETLIST)"

