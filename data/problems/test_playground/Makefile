
GHDL=ghdl
FLAGS="--std=08"
NETLIST=netlist.json

all: run

run:
	@$(GHDL) -a $(FLAGS) submission.vhd
	@$(GHDL) -e $(FLAGS) playground
	@$(GHDL) -r $(FLAGS) playground --stop-time=1us

