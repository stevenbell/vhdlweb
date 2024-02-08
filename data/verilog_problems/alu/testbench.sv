//  Testbench for AB+!BC
module alu_test;

  logic[3:0] a;
  logic[3:0] b;
  logic[1:0] s;
  logic[3:0] y;

  alu dut(a, b, s, y);


  int errors = 0;

  task automatic check(input string test, input logic[3:0] expected, input logic[3:0] actual);
  begin
    if (expected !== actual) begin
      errors = errors + 1;
      $display("Error on \"%s\", expected %d (%b) but got %d (%b)", test, expected, expected, actual, actual);
    end
  end
  endtask


  initial
  begin

    a = 4'h0;
    b = 4'h7;
    s = 2'b00; #10
    check("0 AND 7", 4'h0, y);

    a = 4'hf;
    b = 4'ha;
    s = 2'b00; #10
    check("xF AND xA", 4'ha, y);

    a = 4'h3;
    b = 4'hc;
    s = 2'b01; #10
    check("x3 AND xC", 4'hf, y);

    a = 4'h2;
    b = 4'h2;
    s = 2'b10; #10
    check("2 + 2", 4'h4, y);

    a = 4'hf;
    b = 4'h2;
    s = 2'b10; #10
    check("xf + 2", 4'h1, y); // Overflow to 1

    a = 4'he;
    b = 4'h2;
    s = 2'b11; #10
    check("xE - 2", 4'hc, y);

    a = 4'h0;
    b = 4'h1;
    s = 2'b11; #10
    check("0 - 1", 4'hf, y);


    if (errors == 0) begin
      $display("TEST PASSED.");
    end
    else begin
      $display("Test failed with %0d errors.", errors);
    end
 
    $finish;
  end


endmodule


