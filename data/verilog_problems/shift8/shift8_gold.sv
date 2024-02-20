module shift8 ( input logic clk,
                input logic data_in,
                output logic[7:0] result );

  always_ff @(posedge clk)
  begin
    result <= {result[6:0], data_in};
  end

endmodule

