module nand3 (input logic a, b, c,
              output logic y);

  assign y = ~(a & b & c);

endmodule


