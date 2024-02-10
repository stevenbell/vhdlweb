module adderlogic_test;

  logic[2:0] a;
  logic[2:0] b;
  logic[3:0] sum;
  adderlogic dut(a, b, sum);

  int errors = 0;
  logic[3:0] expected;

  initial
  begin
    for(int a_int = 0; a_int < 8; a_int++) begin
      for(int b_int = 0; b_int < 8; b_int++) begin
        a = 3'(a_int);
        b = 3'(b_int);
        expected = 4'(a + b);
        #10

        // Go silent after 10 errors
        if (sum !== expected && errors < 10) begin
          errors = errors + 1;
          $display("Error with %d + %d; expected %d (%b) but got %d (%b)", a, b, expected, expected, sum, sum);
        end
      end
    end

    if (errors == 0) begin
      $display("TEST PASSED.");
    end
    else begin
      $display("Test failed with %0d errors.", errors);
    end
 
  end

endmodule


