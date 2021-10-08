
GHDL=ghdl
FLAGS="--std=08"
NETLIST=netlist.json

all: run

run:
	@$(GHDL) -a $(FLAGS) submission.vhd

$(NETLIST):
	#@$(GHDL) -a $(FLAGS) submission.vhd
	@yosys -m ghdl -p "ghdl $(FLAGS) submission.vhd -e; write_json $(NETLIST)"

