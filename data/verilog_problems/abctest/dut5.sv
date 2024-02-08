module abc (input logic a, b, c,
            output logic y);

  assign y = (a & b & c) | (!b & c);

endmodule


