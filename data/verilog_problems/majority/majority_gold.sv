module majority (input logic[2:0] votes,
                 output logic y);

  assign y = (votes[2] & votes[1]) | (votes[1] & votes[0]) | (votes[2] & votes[0]);

  // This is a software way of doing it; don't allow this!
  //assign y = (votes[0] + votes[1] + votes[2]) > 1;

endmodule


