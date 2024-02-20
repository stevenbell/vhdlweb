
module counter_enable_test;

  logic clk = 0;
  logic reset;
  logic enable;
  logic[2:0] count;
  
  counter_enable dut(clk, reset, enable, count);
  
  // Create the clock signal
  always #5 clk = ~clk;

  int errors = 0;

  task automatic print_and_check(input logic[2:0] actual, input logic[2:0] expected);
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
    enable = 1;
    #27;
    print_and_check(count, 3'b000);

    // Check twice during reset so students have to get this right, not just initialize
    // the signal with the right constant to make the shifting align with the test.
    @(negedge clk);
    print_and_check(count, 3'b000);

    reset = 0;
    $display("(reset released)" );

    @(negedge clk);
    print_and_check(count, 3'b001);

    @(negedge clk);
    print_and_check(count, 3'b010);
    enable = 0;
    $display("(enable low)");

    @(negedge clk);
    print_and_check(count, 3'b010);
    enable = 1;
    $display("(enable high)");

    @(negedge clk);
    print_and_check(count, 3'b011);

    @(negedge clk);
    print_and_check(count, 3'b100);

    @(negedge clk);
    print_and_check(count, 3'b101);

    @(negedge clk);
    print_and_check(count, 3'b110);

    @(negedge clk);
    print_and_check(count, 3'b111);
    enable = 0;
    $display("(enable low)");

    @(negedge clk);
    print_and_check(count, 3'b111);
    enable = 1;
    $display("(enable high)");

    @(negedge clk);
    print_and_check(count, 3'b000);

    @(negedge clk);
    print_and_check(count, 3'b001);


    if (errors == 0) begin
      $display("TEST PASSED.");
    end
    else begin
      $display("Test failed with %0d errors.", errors);
    end
 

    $finish; // End sim even though clock is still going
  end

endmodule

