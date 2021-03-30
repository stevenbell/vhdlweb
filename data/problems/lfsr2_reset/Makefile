
GHDL=ghdl
FLAGS="--std=08"
NETLIST=netlist.json

all: run

gold:
	@$(GHDL) -a $(FLAGS) testbench.vhd lfsr2_gold.vhd
	@$(GHDL) -e $(FLAGS) lfsr2_test
	@$(GHDL) -r $(FLAGS) lfsr2_test --stop-time=1us

run:
	@$(GHDL) -a $(FLAGS) testbench.vhd submission.vhd
	@$(GHDL) -e $(FLAGS) lfsr2_test
	@$(GHDL) synth $(FLAGS) lfsr2 >> /dev/null || (rm work-obj08.cf && false)
	@$(GHDL) -r $(FLAGS) lfsr2_test --stop-time=1us

$(NETLIST):
	@$(GHDL) -a $(FLAGS) submission.vhd
	@yosys -m ghdl -p "ghdl $(FLAGS) lfsr2; write_json $(NETLIST)"

