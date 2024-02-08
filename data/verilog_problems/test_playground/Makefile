
IVERILOG=iverilog
IVERILOG_FLAGS="-g2012"
VVP=vvp

VERILATOR=verilator
VERILATOR_FLAGS=--lint-only -Wno-STMTDLY -Wno-UNOPTFLAT


all: run

run:
	@$(VERILATOR) $(VERILATOR_FLAGS) submission.sv
	@$(IVERILOG) $(IVERILOG_FLAGS) testbench.sv submission.sv
	@$(VVP) a.out

