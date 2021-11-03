
GHDL=ghdl
FLAGS="--std=08"

# Define the correct result for the DUTs here
DUT1="pass"
DUT2="fail"
DUT3="fail"
DUT4="fail"

all: run1 run2 run3 run4
	@echo "TEST PASSED"

gold: gold_1 gold_2 gold_3 gold_4
	@echo "TEST PASSED"

gold_%:
	@echo "Running gold testbench with DUT #$*"
	@echo "------------------------------"
	@rm -f work-obj08.cf # Clean old build file if it exists
	@$(GHDL) -a $(FLAGS) dut$*.vhd testbench_gold.vhd
	@$(GHDL) -e $(FLAGS) dff_test
	@$(GHDL) -r $(FLAGS) dff_test --stop-time=1us | tee output$*.log
	@./assert $(DUT$*) output$*.log
	@echo "\n\n"

run%:
	@echo "Running testbench with DUT #$*"
	@echo "------------------------------"
	@rm -f work-obj08.cf # Clean old build file if it exists
	@$(GHDL) -a $(FLAGS) dut$*.vhd submission.vhd
	@$(GHDL) -e $(FLAGS) dff_test
	@$(GHDL) -r $(FLAGS) dff_test --stop-time=1us | tee output$*.log
	@./assert $(DUT$*) output$*.log
	@echo "\n\n"

