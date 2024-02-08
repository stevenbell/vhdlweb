module and_test;

  logic a, b, y;
  andgate dut(a, b, y);

  int errors = 0;

  task automatic check(input string test, input expected, input actual);
  begin
    if (expected !== actual) begin
      errors = errors + 1;
      $display("Error on \"%s\", expected %d but got %d", test, expected, actual);
    end
  end
  endtask


  initial
  begin

    a = 0; b = 0; #10
    check("0 & 0", 0, y);
    a = 0; b = 1; #10
    check("0 & 1", 0, y);
    a = 1; b = 0; #10
    check("1 & 0", 0, y);
    a = 1; b = 1; #10
    check("1 & 1", 1, y);

    if (errors == 0) begin
      $display("Test passed.");
    end
    else begin
      $display("Test failed with %0d errors.", errors);
    end
 
    $finish;
  end





endmodule
