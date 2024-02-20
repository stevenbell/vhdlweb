
module lfsr4_test;

  logic clk = 0;
  logic reset;
  logic[3:0] count;
  
  lfsr4 dut(clk, reset, count);
  
  // Create the clock signal
  always #5 clk = ~clk;

  int errors = 0;

  task automatic print_and_check(input logic[3:0] actual, input logic[3:0] expected);
  begin
    if (actual !== expected) begin
      $display("%b  <--- Error, expected %b", actual, expected);
      errors = errors + 1;
    end
    else begin
      $display("%b", actual);
    end
  end
  endtask

  logic[3:0] expected = 4'b0001;
  initial begin
    $display("count:");
  
    $display("(reset asserted)" );
    reset = 1;
    #27;
    print_and_check(count, 4'b0001);

    // Check twice during reset so students have to get this right, not just initialize
    // the signal with the right constant to make the shifting align with the test.
    @(negedge clk);
    print_and_check(count, 4'b0001);

    reset = 0;
    $display("(reset released)" );

    expected = 4'b0001;
    // Do 16 iterations so we loop over all combinations and back around
    for(int i = 0; i < 16; i++) begin
      // Compute the next expected value (non-blocking assignments so the bits work!)
      expected[3] <= expected[0];
      expected[2] <= expected[3] ^ expected[0];
      expected[1:0] <= expected[2:1];

      @(negedge clk);
      print_and_check(count, expected);
    end;
 
    if (errors == 0) begin
      $display("TEST PASSED.");
    end
    else begin
      $display("Test failed with %0d errors.", errors);
    end
 

    $finish; // End sim even though clock is still going
  end

endmodule

