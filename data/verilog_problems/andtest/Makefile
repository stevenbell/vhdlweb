
IVERILOG=iverilog
IVERILOG_FLAGS="-g2012"
VVP=vvp

VERILATOR=verilator
VERILATOR_FLAGS=--lint-only -Wno-STMTDLY -Wno-UNOPTFLAT

NETLIST=netlist.json

# Define the correct result for the DUTs here
DUT1="pass"
DUT2="fail"

all: run1 run2
	@echo "TEST PASSED"

gold:
	@$(VERILATOR) $(VERILATOR_FLAGS) dut1.sv testbench_gold.sv
	@$(IVERILOG) $(IVERILOG_FLAGS) dut1.sv testbench_gold.sv
	@$(VVP) a.out

run%:
	@echo "Running testbench with DUT #$*"
	@echo "------------------------------"
	@$(VERILATOR) $(VERILATOR_FLAGS) dut$*.sv submission.sv
	@$(IVERILOG) $(IVERILOG_FLAGS) dut$*.sv submission.sv
	@$(VVP) a.out | tee output$*.log
	@./assert $(DUT$*) output$*.log
	@echo "\n"

