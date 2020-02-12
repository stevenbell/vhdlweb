--  Testbench for AB+!BC
library IEEE;
use IEEE.std_logic_1164.all;
use std.textio.all;

entity div2_test is
-- No ports, since this is a testbench
end div2_test;

architecture test of div2_test is

component div2 is
  port(
	  operand : in std_logic_vector(7 downto 0);
	  result : out std_logic_vector(7 downto 0)
  );
end component;

signal operand : std_logic_vector(7 downto 0);
signal result : std_logic_vector(7 downto 0);

begin

  dut : div2 port map(operand, result);

  process
    variable errors : integer := 0;

    -- Standard check function
    procedure check(condition : boolean; message : string) is
    begin
      if not condition then
        report message;
        errors := errors + 1;
      end if;
    end check;

  begin
    operand <= x"01"; wait for 10 ns;
    check(result = x"00", "test failed for x01.");

    operand <= x"02"; wait for 10 ns;
    check(result = x"01", "test failed for x02.");

    operand <= x"03"; wait for 10 ns;
    check(result = x"01", "test failed for x03.");

    operand <= x"80"; wait for 10 ns;
    check(result = x"40", "test failed for x80.");

    operand <= x"FF"; wait for 10 ns;
    check(result = x"7F", "test failed for xFF.");
   
    if errors = 0 then
      write (output, "TEST PASSED." & LF);
    else
      write (output, "Test failed with " & to_string(errors) &  " errors." & LF);
    end if;

    wait;
  end process;
end test;

