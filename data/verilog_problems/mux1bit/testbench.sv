
module mux1bit_test;

  logic[1:0] inputs;
  logic s;
  logic y;
  mux1bit dut(inputs[0], inputs[1], s, y);

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
    for(int bitval = 0; bitval < 4; bitval++) begin
      inputs = 2'(bitval);
      $display("Checking inputs \"%2b\"", inputs);
      s = 0; #10
      check(y === inputs[0], " Test failed for s = 0.");

      s = 1; #10
      check(y === inputs[1], " Test failed for s = 1.");
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
