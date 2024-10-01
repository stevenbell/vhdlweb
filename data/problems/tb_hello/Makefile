
GHDL=ghdl
FLAGS="--std=08"
NETLIST=netlist.json

all: run

run:
	@$(GHDL) -a $(FLAGS) submission.vhd
	@$(GHDL) -e $(FLAGS) hello
	@$(GHDL) -r $(FLAGS) hello --stop-time=1us

