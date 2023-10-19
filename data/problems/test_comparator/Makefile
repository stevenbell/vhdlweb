
GHDL=ghdl
FLAGS="--std=08"

# Define the correct result for the DUTs here
DUT1="pass"
DUT2="fail"
DUT3="fail"
DUT4="fail"

all: run1 run2 run3 run4
	@echo "TEST PASSED"

gold:
	@$(GHDL) -a $(FLAGS) dut1.vhd testbench_gold.vhd
	@$(GHDL) -e $(FLAGS) lab2_test
	@$(GHDL) -r $(FLAGS) lab2_test --stop-time=1us

run%:
	@echo "Running your testbench with DUT #$*"
	@echo "------------------------------"
	@rm -f work-obj08.cf # Clean old build file if it exists
	@$(GHDL) -a $(FLAGS) dut$*.vhd submission.vhd
	@$(GHDL) -e $(FLAGS) lab2_test
	@$(GHDL) -r $(FLAGS) lab2_test --stop-time=1us | tee output$*.log
	@./assert $(DUT$*) output$*.log
	@echo "\n\n"

