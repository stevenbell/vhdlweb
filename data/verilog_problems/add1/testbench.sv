module add1_test;

  logic[7:0] operand;
  logic[7:0] result;
  add1 dut(operand, result);

  int errors = 0;

  task automatic testcase(input logic[7:0] op_test, input logic[7:0] expected);
  begin
    operand = op_test;
    #10
    if (result !== expected) begin
      errors = errors + 1;
      $display("Error with operand %d; expected %d (%b) but got %d (%b)", operand, expected, expected, result, result);
    end
  end
  endtask

  initial
  begin
    testcase(0, 1);
    testcase(1, 2);
    testcase(2, 3);
    testcase(35, 36);
    testcase(127, 128);
    testcase(183, 184);
    testcase(254, 255);
    testcase(255, 0);

    if (errors == 0) begin
      $display("TEST PASSED.");
    end
    else begin
      $display("Test failed with %0d errors.", errors);
    end
 
  end

endmodule


