
IVERILOG=iverilog
IVERILOG_FLAGS="-g2012"
VVP=vvp

VERILATOR=verilator
VERILATOR_FLAGS=--lint-only -Wno-STMTDLY -Wno-UNOPTFLAT -Wno-UNUSED

NETLIST=netlist.json


all: run

gold:
	@$(VERILATOR) $(VERILATOR_FLAGS) johnson_gold.sv #testbench.sv
	@$(IVERILOG) $(IVERILOG_FLAGS) testbench.sv johnson_gold.sv
	@$(VVP) a.out

run:
	@$(VERILATOR) $(VERILATOR_FLAGS) submission.sv
	@$(IVERILOG) $(IVERILOG_FLAGS) testbench.sv submission.sv
	@$(VVP) a.out

$(NETLIST):
	@yosys submission.sv -p "prep -auto-top; write_json $(NETLIST)"

