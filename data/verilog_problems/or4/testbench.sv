//  Testbench for 4-input OR
module or4_test;

  logic[3:0] bits;
  logic y;
  or4 dut(bits[3], bits[2], bits[1], bits[0], y);


  int errors = 0;

  task automatic check(input logic[3:0] test, input expected, input actual);
  begin
    if (expected !== actual) begin
      errors = errors + 1;
      $display("Error with input \"%4b\", expected %d but got %d", test, expected, actual);
    end
  end
  endtask


  initial
  begin

    bits = 4'd0; #10
    check(bits, 0, y);

    for(int bitval = 1; bitval <= 15; bitval++) begin
      bits = 4'(bitval); #10
      check(bits, 1, y);
    end


    if (errors == 0) begin
      $display("TEST PASSED.");
    end
    else begin
      $display("Test failed with %0d errors.", errors);
    end;
 
    $finish;
  end


endmodule


