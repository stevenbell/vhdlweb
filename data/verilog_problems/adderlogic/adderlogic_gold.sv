module adderlogic (input logic[2:0] a,
                   input logic[2:0] b,
                   output logic[3:0] sum);

    logic carry1;
    assign sum[0] = a[0] ^ b[0];
    assign carry1 = a[0] & b[0];

    logic carry2;
    assign sum[1] = a[1] ^ b[1] ^ carry1;
    assign carry2 = (a[1] & b[1]) | (a[1] & carry1) | (b[1] & carry1);

    logic carry3;
    assign sum[2] = a[2] ^ b[2] ^ carry2;
    assign sum[3] = (a[2] & b[2]) | (a[2] & carry2) | (b[2] & carry2);

endmodule


