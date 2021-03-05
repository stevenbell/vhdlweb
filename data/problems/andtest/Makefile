
GHDL=ghdl
FLAGS="--std=08"

# Define the correct result for the DUTs here
DUT1="pass"
DUT2="fail"

all: run1 run2
	@echo "TEST PASSED"

gold:
	@$(GHDL) -a $(FLAGS) dut1.vhd testbench_gold.vhd
	@$(GHDL) -e $(FLAGS) abc_test
	@$(GHDL) -r $(FLAGS) abc_test --stop-time=1us

run%:
	@echo "Running testbench with DUT #$*"
	@echo "------------------------------"
	@rm -f work-obj08.cf # Clean old build file if it exists
	@$(GHDL) -a $(FLAGS) dut$*.vhd submission.vhd
	@$(GHDL) -e $(FLAGS) and_test
	@$(GHDL) -r $(FLAGS) and_test --stop-time=1us | tee output$*.log
	@./assert $(DUT$*) output$*.log
	@echo "\n\n"

