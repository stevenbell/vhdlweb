module mux21 (input logic[7:0] a,
              input logic[7:0] b,
              input logic s,
              output logic[7:0] y);

  assign y = s ? b : a;

endmodule
