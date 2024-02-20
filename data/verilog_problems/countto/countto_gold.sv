module countto ( input logic clk,
                 input logic reset,
                 output logic[3:0] count );

  always_ff @(posedge clk)
  begin
    if (reset == 1) begin
      count <= 0;
    end else if (count == 9) begin
      count <= 0;
    end else begin
      count <= count + 1;
    end
  end

endmodule

