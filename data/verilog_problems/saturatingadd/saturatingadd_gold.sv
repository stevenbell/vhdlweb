module saturatingadd (input logic[7:0] a,
                      input logic[7:0] b,
                      output logic[7:0] result);

    logic[8:0] fullsum;
    assign fullsum = a + b;
    assign result = (fullsum[8] == 1) ? 8'hff : fullsum[7:0];

endmodule


