
module div2_test;

  logic[7:0] operand;
  logic[7:0] result;
  div2 dut(operand, result);

  int errors = 0;

  task automatic check(logic[7:0] test, logic[7:0] expected, logic[7:0] actual);
  begin
    if (actual !== expected) begin
      errors = errors + 1;
      $display("Test failed for %d; expected %d but got %d", test, expected, actual);
    end
  end
  endtask

  initial
  begin
    static int operand_int = 0; // iverilog doesn't support automatic; doesn't matter
    logic[7:0] expected;

    // Stop at 5 errors to avoid scaring (and scarring?) students
    while (operand_int < 256 && errors < 5) begin
      operand = 8'(operand_int);
      expected = 8'(operand_int / 2);
      #10
      check(operand, expected, result);
      operand_int += 1;
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
