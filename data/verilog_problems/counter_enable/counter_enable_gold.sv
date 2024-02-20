module counter_enable ( input logic clk,
                        input logic reset,
                        input logic enable,
                        output logic[2:0] count );

  always_ff @(posedge clk)
  begin
    if (reset == 1) begin
      count <= 0;
    end else if (enable == 1) begin
      count <= count + 1;
    end
    // Otherwise, leave count the same
  end

endmodule

