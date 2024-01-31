//  Testbench for AB+!BC
module abc_test;

  logic a, b, c;
  logic y;
  abc dut(a, b, c, y);


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

    a = 0; b = 0; c = 0; #10
    check("000", 0, y);
    a = 0; b = 0; c = 1; #10
    check("001", 1, y);
    a = 0; b = 1; c = 0; #10
    check("010", 0, y);
    a = 0; b = 1; c = 1; #10
    check("011", 0, y);
    a = 1; b = 0; c = 0; #10
    check("100", 0, y);
    a = 1; b = 0; c = 1; #10
    check("101", 1, y);
    a = 1; b = 1; c = 0; #10
    check("110", 1, y);
    a = 1; b = 1; c = 1; #10
    check("111", 1, y);

    if (errors == 0) begin
      $display("TEST PASSED.");
    end
    else begin
      $display("Test failed with %0d errors.", errors);
    end;
 
    $finish;
  end


endmodule


