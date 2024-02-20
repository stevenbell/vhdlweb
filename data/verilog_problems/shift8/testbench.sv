
module shift8_test;

  logic clk = 0;
  logic data_in;
  logic[7:0] result;
  
  shift8 dut(clk, data_in, result);
  
  // Create the clock signal
  always #5 clk = ~clk;

  // Run the clock for 8 cycles, printing the result out each time
  // Then check the answer at the very end
  initial begin
    static logic[7:0] TEST_BITS = 8'b01110101; // Should be const, but icarus doesn't like that

    $display("in  result");
    for(int i = 7; i >= 0; i--) begin

      data_in = TEST_BITS[i];
      @(posedge clk); // wait a whole clock cycle
      @(negedge clk);
      $display("%b  %b", data_in, result);

    end;

    $display("\nFinal result: %b", result);

    if (result === TEST_BITS) begin
      $display("TEST PASSED.");
    end
    else begin
      $display("Test failed: result does not match expected %b", TEST_BITS);
    end
 
    $finish; // End sim even though clock is still going
  end

endmodule

