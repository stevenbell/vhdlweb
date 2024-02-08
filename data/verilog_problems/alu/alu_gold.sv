module alu (input logic[3:0] a,
            input logic[3:0] b,
            input logic[1:0] s,
            output logic[3:0] y);

  assign y = (s == 2'b00) ? a & b :
             (s == 2'b01) ? a | b :
             (s == 2'b10) ? a + b :
                            a - b;

endmodule

