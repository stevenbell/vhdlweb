--  Testbench for AB+!BC
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all; -- Easier to count with unsigned!
use std.textio.all;

entity adderlogic_test is
-- No ports, since this is a testbench
end adderlogic_test;

architecture test of adderlogic_test is

component adderlogic is
  port(
	  a : in std_logic_vector(2 downto 0);
	  b : in std_logic_vector(2 downto 0);
	  sum : out std_logic_vector(3 downto 0)
  );
end component;

signal a : std_logic_vector(2 downto 0);
signal b : std_logic_vector(2 downto 0);
signal sum : std_logic_vector(3 downto 0);

begin

  dut : adderlogic port map(a, b, sum);

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
    for a_int in 0 to 7 loop
      a <= std_logic_vector(to_unsigned(a_int, 3));
      for b_int in 0 to 7 loop
        b <= std_logic_vector(to_unsigned(b_int, 3));
        wait for 10 ns;
        check(sum = std_logic_vector(to_unsigned(a_int + b_int, 4)),
               "test failed for " & integer'image(a_int) & " + " & integer'image(b_int) & ".");
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

