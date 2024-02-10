
module sevenseg01_test;

  logic S;
  logic[6:0] segments;
  sevenseg01 dut(S, segments);

  int errors = 0;

  task automatic check(bit equal, string message);
    if (!equal) begin
      errors = errors + 1;
      $display(message);
    end
  endtask

  // Draw a single character: '#' if true, ' ' if false
  function automatic string dc(logic value);
    return (value == 1) ? "#" : " ";
  endfunction

  task automatic draw_sevenseg(logic[6:0] segs);
    $display({dc(segs[6] | segs[1]), dc(segs[6]), dc(segs[6]), dc(segs[6] | segs[5])});
    $display({dc(segs[1]), dc(0), dc(0), dc(segs[5])});
    $display({dc(segs[1] | segs[0]), dc(segs[0]), dc(segs[0]), dc(segs[5] | segs[0])});
    $display({dc(segs[2]), dc(0), dc(0), dc(segs[4])});
    $display({dc(segs[2] | segs[3]), dc(segs[3]), dc(segs[3]), dc(segs[4] | segs[3])});
    $display(); // newline
  endtask

  initial
  begin

    $display("Test digit 0 -------");
    S = 0; #10
    check(segments === 7'b1111110, "Segments incorrect for digit 0");
    draw_sevenseg(segments);

    $display("Test digit 1 -------");
    S = 1; #10
    check(segments === 7'b0110000, "Segments incorrect for digit 1");
    draw_sevenseg(segments);

    if (errors == 0) begin
      $display("TEST PASSED.");
    end
    else begin
      $display("Test failed with %0d errors.", errors);
    end;
 
    $finish;
  end

endmodule
