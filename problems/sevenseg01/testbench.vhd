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

    write(l, String'("Test digit 0 -------"));
    writeline (output, l);

    S <= '0'; wait for 10 ns;
    draw_sevenseg(segments);
  

    write(l, String'("Testing digit 1 -------"));
    writeline (output, l);

    S <= '1'; wait for 10 ns;
    draw_sevenseg(segments);

    write(l, String'("Test complete."));
    writeline (output, l);
    wait;
  end process;
end test;

