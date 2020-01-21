--  Testbench for AB+!BC
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use std.textio.all;

entity add1_test is
-- No ports, since this is a testbench
end add1_test;

architecture test of add1_test is

component add1 is
  port(
	  operand : in unsigned(7 downto 0);
	  result : out unsigned(7 downto 0)
  );
end component;

signal operand : unsigned(7 downto 0);
signal result : unsigned(7 downto 0);

begin

  dut : add1 port map(operand, result);

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
    operand <= to_unsigned(0, 8); wait for 10 ns;
    check(result = 1, "test failed for operand = 0.");

    operand <= to_unsigned(1, 8); wait for 10 ns;
    check(result = 2, "test failed for operand = 1.");

    operand <= to_unsigned(127, 8); wait for 10 ns;
    check(result = 128, "test failed for operand = 127.");

    operand <= to_unsigned(255, 8); wait for 10 ns;
    check(result = 0, "test failed for operand = 255.");

    if errors = 0 then
      write (output, "TEST PASSED." & LF);
    else
      write (output, "Test failed with " & to_string(errors) &  " errors." & LF);
    end if;

    wait;
  end process;
end test;

