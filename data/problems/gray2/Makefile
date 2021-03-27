
GHDL=ghdl
FLAGS="--std=08"
NETLIST=netlist.json

all: run

gold:
	@$(GHDL) -a $(FLAGS) testbench.vhd gray2_gold.vhd
	@$(GHDL) -e $(FLAGS) gray2_test
	@$(GHDL) -r $(FLAGS) gray2_test --stop-time=1us

run:
	@$(GHDL) -a $(FLAGS) testbench.vhd submission.vhd
	@$(GHDL) -e $(FLAGS) gray2_test
	@$(GHDL) -r $(FLAGS) gray2_test --stop-time=1us

$(NETLIST):
	@$(GHDL) -a $(FLAGS) submission.vhd
	@yosys -m ghdl -p "ghdl $(FLAGS) gray2; write_json $(NETLIST)"

