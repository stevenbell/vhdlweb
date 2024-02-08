module mux1bit (input logic a, b,
                input logic s,
                output logic y);

assign y = s ? b : a;

endmodule
