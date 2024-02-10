module div2 (input logic[7:0] operand,
             output logic[7:0] result);

  assign result = {1'b0, operand[6:0]};

endmodule
