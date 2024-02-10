module sevenseg01 (input logic S,
                   output logic[6:0] segments);

  assign segments = (S == 0) ? 7'b1111110 : 7'b0110000;

endmodule
