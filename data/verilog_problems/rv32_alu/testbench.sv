module alu_test();

    logic[31:0] operand1;
    logic[31:0] operand2;
    logic[3:0] operation;
    logic[31:0] result;

    alu dut(.operand1(operand1),
            .operand2(operand2),
            .operation(operation),
            .result(result));

    int errors = 0;
 

    // Variables for reading the file
    int tv_file;  // File handle
    int r; // Return value from scanf/etc
    int firstchar; // First character in a line
    logic[4095:0] line; // iverlilog can't read strings with fgets, so use logic

    logic[31:0] expected; // Expected ALU result

    initial begin
        tv_file = $fopen("alu_vectors.csv", "r");
        while(!$feof(tv_file)) begin
            // If the first character is a '#' or the line is empty, discard it
            firstchar = $fgetc(tv_file);
            if (firstchar == "#" | firstchar == "\n") begin
                r = $fgets(line, tv_file);
            end
            else begin
                r = $ungetc(firstchar, tv_file);
                r = $fscanf(tv_file, "%h,%h,%b,%h\n", operand1, operand2, operation, expected);
                if (r != 4) begin
                    $display("Error reading test vector file; quitting simulation!");
                    $finish;
                end
                #5 // Wait for result to propagate before checking

                if (result !== expected) begin
                    $display("%h (%b) %h = %h <--- Error, expected %h", operand1, operation, operand2, result, expected);
                    errors += 1;
                end
                else begin
                    $display("%h (%b) %h = %h", operand1, operation, operand2, expected);
                end;

            end
        end

        if (errors == 0) begin
            $display("TEST PASSED.");
        end
        else begin
            $display("Test failed with %0d errors.", errors);
        end

        $finish;
    end

endmodule

