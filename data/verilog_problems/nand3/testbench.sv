//  Testbench for 4-input OR
module nand3_test;

  logic[2:0] bits;
  logic y;
  nand3 dut(bits[2], bits[1], bits[0], y);


  int errors = 0;

  task automatic check(input logic[2:0] test, input expected, input actual);
  begin
    if (expected !== actual) begin
      errors = errors + 1;
      $display("Error with input \"%3b\", expected %d but got %d", test, expected, actual);
    end
  end
  endtask


  initial
  begin

    // Output should be 1 for all cases except 111
    for(int bitval = 0; bitval < 7; bitval++) begin
      bits = 3'(bitval); #10
      check(bits, 1, y);
    end

    bits = 3'b111; #10
    check(bits, 0, y);


    if (errors == 0) begin
      $display("TEST PASSED.");
    end
    else begin
      $display("Test failed with %0d errors.", errors);
    end;
 
    $finish;
  end


endmodule


