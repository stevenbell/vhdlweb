
module mux21_test;

  logic[7:0] a;
  logic[7:0] b;
  logic s;
  logic[7:0] y;
  mux21 dut(a, b, s, y);

  int errors = 0;

  task automatic check(bit equal, string message);
  begin
    if (!equal) begin
      errors = errors + 1;
      $display(message);
    end
  end
  endtask

  initial
  begin

    a = 8'hFF; b = 8'h88;
    $display("Checking inputs a = %x, b = %h", a, b);
    s = 0; #10
    check(y === a, " Test failed for s = 0.");

    s = 1; #10
    check(y === b, " Test failed for s = 1.");

    a = 8'h39; b = 8'hc7;
    $display("Checking inputs a = %x, b = %h", a, b);
    s = 0; #10
    check(y === a, " Test failed for s = 0.");

    s = 1; #10
    check(y === b, " Test failed for s = 1.");

    a = 8'h02; b = 8'h4x;
    $display("Checking inputs a = %x, b = %h", a, b);
    s = 0; #10
    check(y === a, " Test failed for s = 0.");

    s = 1; #10
    check(y === b, " Test failed for s = 1.");



    if (errors == 0) begin
      $display("TEST PASSED.");
    end
    else begin
      $display("Test failed with %0d errors.", errors);
    end;
 
    $finish;
  end

endmodule
