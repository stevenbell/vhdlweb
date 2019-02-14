--  Testbench for saturating adder
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use std.textio.all;

entity saturatingadd_test is
-- No ports, since this is a testbench
end saturatingadd_test;

architecture test of saturatingadd_test is

component saturatingadd is
  port(
	  a : in unsigned(7 downto 0);
	  b : in unsigned(7 downto 0);
	  result : out unsigned(7 downto 0)
  );
end component;

signal a : unsigned(7 downto 0);
signal b : unsigned(7 downto 0);
signal result : unsigned(7 downto 0);

begin

  dut : saturatingadd port map(a, b, result);

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


  begin

      write(l, String'("This test is under construction."));

    if errors = 0 then
      write(l, String'("Test passed."));
    else
      write (l, String'("Test failed with "));
      write (l, errors);
      write (l, String'(" errors."));
    end if;
    writeline (output, l);
    wait;
  end process;
end test;

