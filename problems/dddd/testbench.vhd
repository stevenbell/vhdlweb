--  Testbench for seven segment display that only shows 1 bit
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use std.textio.all;

entity dddd_test is
-- No ports, since this is a testbench
end dddd_test;

architecture test of dddd_test is

component dddd is
  port(
    value : in unsigned(5 downto 0);    
    tensdigit : out std_logic_vector(6 downto 0);    
    onesdigit : out std_logic_vector(6 downto 0)
  );
end component;

signal S : unsigned(5 downto 0);
signal onessegs : std_logic_vector(6 downto 0);
signal tenssegs : std_logic_vector(6 downto 0);

begin

  dut : dddd port map(value=>S, tensdigit=>tenssegs, onesdigit=>onessegs);

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

    procedure draw_doublesevenseg(tens : std_logic_vector(6 downto 0); ones : std_logic_vector(6 downto 0)) is
    begin
      dc(tens(6) or tens(1)); dc(tens(6)); dc(tens(6)); dc(tens(6) or tens(5)); write(l, String'("  "));
      dc(ones(6) or ones(1)); dc(ones(6)); dc(ones(6)); dc(ones(6) or ones(5));
      writeline (output, l);

      dc(tens(1)); dc('0'); dc('0'); dc(tens(5)); write(l, String'("  "));
      dc(ones(1)); dc('0'); dc('0'); dc(ones(5));
      writeline (output, l);

      dc(tens(1) or tens(0)); dc(tens(0)); dc(tens(0)); dc(tens(5) or tens(0)); write(l, String'("  ")); 
      dc(ones(1) or ones(0)); dc(ones(0)); dc(ones(0)); dc(ones(5) or ones(0));
      writeline (output, l);

      dc(tens(2)); dc('0'); dc('0'); dc(tens(4)); write(l, String'("  ")); 
      dc(ones(2)); dc('0'); dc('0'); dc(ones(4));
      writeline (output, l);

      dc(tens(2) or tens(3)); dc(tens(3)); dc(tens(3)); dc(tens(4) or tens(3)); write(l, String'("  ")); 
      dc(ones(2) or ones(3)); dc(ones(3)); dc(ones(3)); dc(ones(4) or ones(3));
      writeline (output, l);
    end draw_doublesevenseg;

  begin

    for digit in 0 to 63 loop
      write(l, String'("Test digit " & to_string(digit) & " -------"));
      writeline (output, l);

      S <= to_unsigned(digit, 6); wait for 10 ns;
      draw_doublesevenseg(tenssegs, onessegs);

    end loop;

    write(l, String'("Test complete."));
    writeline (output, l);
    wait;
  end process;
end test;

