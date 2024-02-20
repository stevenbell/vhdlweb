module twohigh ( input logic clk,
                 input logic data,
                 output logic two );

logic[1:0] delays;

always_ff @(posedge clk)
begin
    delays[0] <= data;
    delays[1] <= delays[0];
end

  assign two = delays[0] & delays[1];

endmodule

