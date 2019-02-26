--  Reference testbench for adder
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use std.textio.all;

entity adder_test is
-- No ports, since this is a testbench
end adder_test;

architecture test of adder_test is

component adder is
  port(
	  a : in unsigned(3 downto 0);
	  b : in unsigned(3 downto 0);
	  sum : out unsigned(3 downto 0)
  );
end component;

signal a : unsigned(3 downto 0) := 4d"0";
signal b : unsigned(3 downto 0) := 4d"0";
signal sum : unsigned(3 downto 0);

begin

  dut : adder port map(a, b, sum);

  process
    variable errors : integer := 0;
    variable l : line; -- For output text

    -- Function
    procedure check(condition : boolean; message : string) is
    begin
      if not condition then
        report message;
        errors := errors + 1;
      end if;
    end check;


  begin

    for aVal in 0 to 15 loop
      for bVal in 0 to 15 loop
        a <= to_unsigned(aVal, 4);
        b <= to_unsigned(bVal, 4);
        wait for 1 ns;
        check(sum = (a + b), "test failed with " & to_string(a) & " + " & to_string(b) & " = " & to_string(sum));
      end loop;
    end loop;
        
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

