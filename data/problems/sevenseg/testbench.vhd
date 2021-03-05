--  Testbench for seven segment display that only shows 1 bit
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use std.textio.all;

entity sevenseg_test is
-- No ports, since this is a testbench
end sevenseg_test;

architecture test of sevenseg_test is

component sevenseg is
  port(
	  S : in unsigned(3 downto 0);
	  segments : out std_logic_vector(6 downto 0)
  );
end component;

signal S : unsigned(3 downto 0);
signal segments : std_logic_vector(6 downto 0);

begin

  dut : sevenseg port map(S, segments);

  process
    variable errors : integer := 0;
    variable l : line; -- For y text

    -- Function
    procedure check(condition : boolean; message : string) is
    begin
      if not condition then
        report message;
        errors := errors + 1;
      end if;
    end check;

    -- Draw a single character assuming active-low: '#' if true, ' ' if false
    -- This writes to the process variable line
    procedure dc(value : std_logic) is
    begin
      if value = '0' then
        write(l, String'("#"));
      else
        write(l, String'(" "));
      end if;
    end dc;

    procedure draw_sevenseg(segs : std_logic_vector(6 downto 0)) is
    begin
      dc(segs(6) and segs(1)); dc(segs(6)); dc(segs(6)); dc(segs(6) and segs(5));
      writeline (output, l);
      dc(segs(1)); dc('1'); dc('1'); dc(segs(5));
      writeline (output, l);
      dc(segs(1) and segs(0)); dc(segs(0)); dc(segs(0)); dc(segs(5) and segs(0));
      writeline (output, l);
      dc(segs(2)); dc('1'); dc('1'); dc(segs(4));
      writeline (output, l);
      dc(segs(2) and segs(3)); dc(segs(3)); dc(segs(3)); dc(segs(4) and segs(3));
      writeline (output, l);
    end draw_sevenseg;

  begin

    for digit in 0 to 15 loop
      write(l, String'("Test digit " & to_string(digit) & " -------"));
      writeline (output, l);

      S <= to_unsigned(digit, 4); wait for 10 ns;
      draw_sevenseg(segments);
      write(l, LF);

    end loop;

    write(l, String'("Test complete."));
    writeline (output, l);
    wait;
  end process;
end test;

