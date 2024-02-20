
module twohigh_test;

  logic clk = 0;
  logic data_in;
  logic two_out;
  
  twohigh dut(clk, data_in, two_out);
  
  // Create the clock signal
  always #5 clk = ~clk;

  int errors = 0;

  task automatic print_and_check(input logic actual, input logic expected);
  begin
    if (actual !== expected) begin
      $display(" %d    %d  <--- Error, expected %d", data_in, actual, expected);
      errors = errors + 1;
    end
    else begin
      $display(" %d    %d", data_in, actual);
    end
  end
  endtask

  initial begin
    $display("data twohigh");
    data_in = 0;
    @(negedge clk);
    @(negedge clk);
    print_and_check(two_out, 0);
    data_in = 1;

    @(negedge clk);
    print_and_check(two_out, 0); // One cycle later, AND is still 0

    @(negedge clk);
    print_and_check(two_out, 1); // Two cycles later, AND should be 1

    @(negedge clk);
    print_and_check(two_out, 1); // Should still be high
    data_in <= 0;

    @(negedge clk);
    print_and_check(two_out, 0);
 
    if (errors == 0) begin
      $display("TEST PASSED.");
    end
    else begin
      $display("Test failed with %0d errors.", errors);
    end
 
    $finish; // End sim even though clock is still going
  end

endmodule

