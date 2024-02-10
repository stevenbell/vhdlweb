//  Testbench for 4-input OR
module majority_test;

  logic[2:0] votes;
  logic y;
  majority dut(votes, y);


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

    votes = 3'b000; #10
    check(votes, 0, y);
    votes = 3'b001; #10
    check(votes, 0, y);
    votes = 3'b010; #10
    check(votes, 0, y);
    votes = 3'b011; #10
    check(votes, 1, y);
    votes = 3'b100; #10
    check(votes, 0, y);
    votes = 3'b101; #10
    check(votes, 1, y);
    votes = 3'b110; #10
    check(votes, 1, y);
    votes = 3'b111; #10
    check(votes, 1, y);


    if (errors == 0) begin
      $display("TEST PASSED.");
    end
    else begin
      $display("Test failed with %0d errors.", errors);
    end;
 
    $finish;
  end


endmodule


