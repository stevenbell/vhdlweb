--  Testbench for 3-bit thermometer decoder
library IEEE;
use IEEE.std_logic_1164.all;
use std.textio.all;

entity thermometer_test is
-- No ports, since this is a testbench
end thermometer_test;

architecture test of thermometer_test is

component thermometer is
  port(
	  value : in std_logic_vector(2 downto 0);
	  therm : out std_logic_vector(6 downto 0)
  );
end component;

signal value : std_logic_vector(2 downto 0);
signal therm : std_logic_vector(6 downto 0);

begin

  dut : thermometer port map(value, therm);

  process
    variable l : line; -- For output text
  begin
    -- Just count up and assert that the value is right
    value <= "000"; wait for 10 ns;
    assert(therm = "0000000") report "test failed for 0.";
    value <= "001"; wait for 10 ns;
    assert(therm = "0000001") report "test failed for 1.";
    value <= "010"; wait for 10 ns;
    assert(therm = "0000011") report "test failed for 2.";
    value <= "011"; wait for 10 ns;
    assert(therm = "0000111") report "test failed for 3.";
    value <= "100"; wait for 10 ns;
    assert(therm = "0001111") report "test failed for 4.";
    value <= "101"; wait for 10 ns;
    assert(therm = "0011111") report "test failed for 5.";
    value <= "110"; wait for 10 ns;
    assert(therm = "0111111") report "test failed for 6.";
    value <= "111"; wait for 10 ns;
    assert(therm = "1111111") report "test failed for 7.";

    write (l, String'("Test complete."));
    writeline (output, l);
    wait;
  end process;
end test;

