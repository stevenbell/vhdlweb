
module lfsr2_test;

  logic clk = 0;
  logic reset;
  logic b;
  
  lfsr2 dut(clk, reset, b);
  
  // Create the clock signal
  always #5 clk = ~clk;

  int errors = 0;

  task automatic print_and_check(input logic actual, input logic expected);
  begin
    if (actual !== expected) begin
      $display("%d  <--- Error, expected %d", actual, expected);
      errors = errors + 1;
    end
    else begin
      $display("%d", actual);
    end
  end
  endtask

  initial begin
    $display("B:");

    reset = 1;
    $display("     asserting reset (reset = 1)");
    #20; // A couple clock cycles
    @(negedge clk);
    print_and_check(b, 1);
    reset = 0;
    $display("     releasing reset (reset = 0)");

    @(negedge clk); // First cycle after coming out of reset, state should be 11
    print_and_check(b, 1);

    @(negedge clk);
    print_and_check(b, 0);

    @(negedge clk);
    print_and_check(b, 1);

    @(negedge clk);
    print_and_check(b, 1);

    @(negedge clk);
    print_and_check(b, 0);
 

    if (errors == 0) begin
      $display("TEST PASSED.");
    end
    else begin
      $display("Test failed with %0d errors.", errors);
    end
 
    $finish; // End sim even though clock is still going
  end

endmodule

