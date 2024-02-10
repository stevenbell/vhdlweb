module saturatingadd_test;

  logic[7:0] a;
  logic[7:0] b;
  logic[7:0] result;
  saturatingadd dut(a, b, result);

  int errors = 0;
  logic[3:0] expected;

  task automatic testcase(input logic[7:0] a_test, input logic[7:0] b_test, input logic[7:0] expected);
  begin
    a = a_test;
    b = b_test;
    #10
    if (result !== expected) begin
      errors = errors + 1;
      $display("Error with %d + %d; expected %d (%b) but got %d (%b)", a, b, expected, expected, result, result);
    end
  end
  endtask


  initial
  begin

    testcase(0, 0, 0);
    testcase(0, 1, 1);
    testcase(1, 1, 2);
    testcase(150, 100, 250);
    testcase(254, 0, 254);
    testcase(255, 1, 255);
    testcase(254, 2, 255);
    testcase(128, 128, 255);
    testcase(127, 127, 254);
    testcase(255, 255, 255);

    if (errors == 0) begin
      $display("TEST PASSED.");
    end
    else begin
      $display("Test failed with %0d errors.", errors);
    end
 
  end

endmodule


