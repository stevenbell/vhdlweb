module thermometer (input logic[2:0] value,
                    output logic[6:0] therm);

  assign therm = (value == 3'd0) ? 7'b0000000 :
                 (value == 3'd1) ? 7'b0000001 :
                 (value == 3'd2) ? 7'b0000011 :
                 (value == 3'd3) ? 7'b0000111 :
                 (value == 3'd4) ? 7'b0001111 :
                 (value == 3'd5) ? 7'b0011111 :
                 (value == 3'd6) ? 7'b0111111 :
                                   7'b1111111;

endmodule
