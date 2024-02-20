
module onehot_test;

  logic clk = 0;
  logic reset;
  logic[7:0] count;
  
  onehot dut(clk, reset, count);
  
  // Create the clock signal
  always #5 clk = ~clk;

  int errors = 0;

  task automatic print_and_check(input logic[7:0] actual, input logic[7:0] expected);
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

  initial begin
    $display("count:");
  
    $display("(reset asserted)" );
    reset = 1;
    #27;
    print_and_check(count, 8'b00000001);

    // Check twice during reset so students have to get this right, not just initialize
    // the signal with the right constant to make the shifting align with the test.
    @(negedge clk);
    print_and_check(count, 8'b00000001);

    reset = 0;
    $display("(reset released)" );

    @(negedge clk);
    print_and_check(count, 8'b00000010);

    @(negedge clk);
    print_and_check(count, 8'b00000100);

    @(negedge clk);
    print_and_check(count, 8'b00001000);

    @(negedge clk);
    print_and_check(count, 8'b00010000);

    @(negedge clk);
    print_and_check(count, 8'b00100000);

    @(negedge clk);
    print_and_check(count, 8'b01000000);

    @(negedge clk);
    print_and_check(count, 8'b10000000);

    @(negedge clk);
    print_and_check(count, 8'b00000001);

    if (errors == 0) begin
      $display("TEST PASSED.");
    end
    else begin
      $display("Test failed with %0d errors.", errors);
    end
 

    $finish; // End sim even though clock is still going
  end

endmodule

