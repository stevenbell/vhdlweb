--  Testbench for seven segment display that only shows 1 bit
library IEEE;
use IEEE.std_logic_1164.all;
use std.textio.all;

entity sevenseg01_test is
-- No ports, since this is a testbench
end sevenseg01_test;

architecture test of sevenseg01_test is

component sevenseg01 is
  port(
	  S : in std_logic;
	  segments : out std_logic_vector(6 downto 0)
  );
end component;

signal S : std_logic;
signal segments : std_logic_vector(6 downto 0);

begin

  dut : sevenseg01 port map(S, segments);

  process
    variable errors : integer := 0;
    variable l : line; -- For y text

    -- Standard check function
    procedure check(condition : boolean; message : string) is
    begin
      if not condition then
        report message;
        errors := errors + 1;
      end if;
    end check;

    -- Draw a single character: '#' if true, ' ' if false
    -- This writes to the process variable line
    procedure dc(value : std_logic) is
    begin
      if value = '1' then
        write(l, String'("#"));
      else
        write(l, String'(" "));
      end if;
    end dc;

    procedure draw_sevenseg(segs : std_logic_vector(6 downto 0)) is
    begin
      dc(segs(6) or segs(1)); dc(segs(6)); dc(segs(6)); dc(segs(6) or segs(5));
      writeline (output, l);
      dc(segs(1)); dc('0'); dc('0'); dc(segs(5));
      writeline (output, l);
      dc(segs(1) or segs(0)); dc(segs(0)); dc(segs(0)); dc(segs(5) or segs(0));
      writeline (output, l);
      dc(segs(2)); dc('0'); dc('0'); dc(segs(4));
      writeline (output, l);
      dc(segs(2) or segs(3)); dc(segs(3)); dc(segs(3)); dc(segs(4) or segs(3));
      writeline (output, l);
    end draw_sevenseg;

  begin

    write(output, "Test digit 0 -------" & LF);
    S <= '0'; wait for 10 ns;
    check(segments = "1111110", "Segments incorrect for digit 0");
    draw_sevenseg(segments);
  
    write(output, to_string(LF)); -- Newline just for visual clarity

    write(output, "Test digit 1 -------" & LF);
    S <= '1'; wait for 10 ns;
    check(segments = "0110000", "Segments incorrect for digit 1");
    draw_sevenseg(segments);

    write(output, to_string(LF)); -- Newline just for visual clarity

    if errors = 0 then
      write (output, "TEST PASSED." & LF);
    else
      write (output, "Test failed with " & to_string(errors) &  " errors." & LF);
    end if;

    wait;
  end process;
end test;

