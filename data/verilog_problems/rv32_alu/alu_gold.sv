
module alu(input logic[31:0] operand1,
           input logic[31:0] operand2,
           input logic[3:0] operation, // This is {imm7[5], imm3}, other bits of imm7 are always 0 for RV32I
           output logic[31:0] result);

    // Inputs are unsigned by default, but signed operations only apply
    // to signed signals, and iverilog doesn't allow us to cast them inline
    logic signed[31:0] op1_signed;
    logic signed[31:0] op2_signed;

    assign op1_signed = operand1;
    assign op2_signed = operand2;

    always_comb begin
        if (operation == 4'b0000)
            result = operand1 + operand2; // ADD
        else if (operation == 4'b1000)
            result = operand1 - operand2; // SUB
        else if (operation == 4'b0001)
            result = operand1 << operand2; // SLL: logical shift left
        else if (operation == 4'b0010)
            result = {31'd0, op1_signed < op2_signed}; // SLT: signed less-than
        else if (operation == 4'b0011)
            result = {31'd0, operand1 < operand2}; // SLTU: unsigned less-than
        else if (operation == 4'b0100)
            result = operand1 ^ operand2; // XOR
        else if (operation == 4'b0101)
            result = operand1 >> operand2; // SRL: logical shift right
        else if (operation == 4'b1101)
            result = op1_signed >>> operand2; // SRA: arithmetic shift right
        else if (operation == 4'b0110)
            result = operand1 | operand2; // OR
        else if (operation == 4'b0111)
            result = operand1 & operand2; // AND
    end

endmodule

