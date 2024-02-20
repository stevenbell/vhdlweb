module lfsr2 ( input logic clk,
               input logic reset,
               output logic b );

  logic d0;
  logic d1;
  
  always_ff @(posedge clk)
  begin
    if (reset == 1) begin
      d0 <= 1;
      d1 <= 1;
    end else begin
      d1 <= d0 ^ d1;
      d0 <= d1;
    end
  end

  assign b = d0;

endmodule

