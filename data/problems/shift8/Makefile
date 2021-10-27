
GHDL=ghdl
FLAGS="--std=08"
NETLIST=netlist.json

all: run

gold:
	@$(GHDL) -a $(FLAGS) testbench.vhd shift8_gold.vhd
	@$(GHDL) -e $(FLAGS) shift8_test
	@$(GHDL) -r $(FLAGS) shift8_test --stop-time=1us

run:
	@$(GHDL) -a $(FLAGS) testbench.vhd submission.vhd
	@$(GHDL) -e $(FLAGS) shift8_test
	@$(GHDL) synth $(FLAGS) shift8 >> /dev/null || (rm work-obj08.cf && false)
	@$(GHDL) -r $(FLAGS) shift8_test --stop-time=1us

$(NETLIST):
	@$(GHDL) -a $(FLAGS) submission.vhd
	@yosys -m ghdl -p "ghdl $(FLAGS) shift8; write_json $(NETLIST)"

