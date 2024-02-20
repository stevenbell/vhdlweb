module onehot ( input logic clk,
                input logic reset,
                output logic[7:0] count );

  always_ff @(posedge clk)
  begin
    if (reset == 1) begin
      count <= 8'h01;
    end else begin
      count <= {count[6:0], count[7]};
    end
  end

endmodule

