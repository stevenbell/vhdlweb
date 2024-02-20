module johnson ( input logic clk,
                input logic reset,
                output logic[3:0] count );

  always_ff @(posedge clk)
  begin
    if (reset == 1) begin
      count <= 0;
    end else begin
      count <= {count[2:0], ~count[3]};
    end
  end

endmodule

