
module countto_test;

  logic clk = 0;
  logic reset;
  logic[3:0] count;
  
  countto dut(clk, reset, count);
  
  // Create the clock signal
  always #5 clk = ~clk;

  int errors = 0;

  task automatic print_and_check(input logic[3:0] actual, input logic[3:0] expected);
  begin
    if (actual !== expected) begin
      $display("%b (%d)  <--- Error, expected %b (%d)", actual, actual, expected, expected);
      errors = errors + 1;
    end
    else begin
      $display("%b (%d)", actual, actual);
    end
  end
  endtask

  logic[3:0] expected;

  initial begin
    $display("count (decimal):");
  
    $display("(reset asserted)" );
    reset = 1;
    #27;
    print_and_check(count, 4'b0000);

    // Check twice during reset so students have to get this right, not just initialize
    // the signal with the right constant to make the shifting align with the test.
    @(negedge clk);
    print_and_check(count, 4'b0000);

    reset = 0;
    $display("(reset released)" );

    for(int i = 1; i < 13; i++) begin
      @(negedge clk);
      expected = 4'(i % 10);
      print_and_check(count, expected);
    end

    if (errors == 0) begin
      $display("TEST PASSED.");
    end
    else begin
      $display("Test failed with %0d errors.", errors);
    end
 

    $finish; // End sim even though clock is still going
  end

endmodule

