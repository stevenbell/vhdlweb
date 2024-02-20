module lfsr4 ( input logic clk,
                input logic reset,
                output logic[3:0] count );

  always_ff @(posedge clk)
  begin
    if (reset == 1) begin
      count <= 4'b0001;
    end else begin
      count <= {count[0], count[3] ^ count[0], count[2:1]};
    end
  end

endmodule

