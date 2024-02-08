module thermometer_test;

logic[2:0] value;
logic[6:0] therm;

thermometer dut(value, therm);

  int errors = 0;

  task automatic check(input logic[2:0] test, input logic[6:0] expected, input logic[6:0] actual);
  begin
    if (expected !== actual) begin
      errors = errors + 1;
      $display("Error with value = %d, expected %b but got %b", test, expected, actual);
    end
  end
  endtask


  initial
  begin

    value = 3'd0; #10
    check(value, 7'b0000000, therm);
    value = 3'd1; #10
    check(value, 7'b0000001, therm);
    value = 3'd2; #10
    check(value, 7'b0000011, therm);
    value = 3'd3; #10
    check(value, 7'b0000111, therm);
    value = 3'd4; #10
    check(value, 7'b0001111, therm);
    value = 3'd5; #10
    check(value, 7'b0011111, therm);
    value = 3'd6; #10
    check(value, 7'b0111111, therm);
    value = 3'd7; #10
    check(value, 7'b1111111, therm);

    if (errors == 0) begin
      $display("TEST PASSED.");
    end
    else begin
      $display("Test failed with %0d errors.", errors);
    end

  end
 
endmodule
