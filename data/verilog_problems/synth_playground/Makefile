IVERILOG=iverilog
IVERILOG_FLAGS="-g2012"
VVP=vvp

VERILATOR=verilator
VERILATOR_FLAGS=--lint-only -Wno-STMTDLY -Wno-UNOPTFLAT

NETLIST=netlist.json

all: run

run:
	# There's nothing to actually run, since it's just a synthesizable module
	# Just do the syntax check with verilator.
	@$(VERILATOR) $(VERILATOR_FLAGS) submission.sv

$(NETLIST):
	@yosys submission.sv -p "prep -auto-top; write_json $(NETLIST)"

