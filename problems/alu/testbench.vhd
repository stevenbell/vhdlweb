--  Testbench for AB+!BC
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use std.textio.all;

entity alu_test is
-- No ports, since this is a testbench
end alu_test;

architecture test of alu_test is

component alu is
  port(
	  a : in unsigned(3 downto 0);
	  b : in unsigned(3 downto 0);
	  s : in std_logic_vector(1 downto 0);
	  y : out unsigned(3 downto 0)
  );
end component;

signal a : unsigned(3 downto 0);
signal b : unsigned(3 downto 0);
signal s : std_logic_vector(1 downto 0);
signal y : unsigned(3 downto 0);

begin

  dut : alu port map(a, b, s, y);

  process
    variable l : line; -- For output text
  begin
    a <= x"0";
    b <= x"7";
    s <= "00"; wait for 10 ns;
    assert(y = x"0") report "test failed for 0 AND 7.";

    a <= x"f";
    b <= x"a";
    s <= "00"; wait for 10 ns;
    assert(y = x"a") report "test failed for xF AND xA.";

    a <= x"3";
    b <= x"c";
    s <= "01"; wait for 10 ns;
    assert(y = x"f") report "test failed for 3 OR 0xC.";

    a <= x"1";
    b <= x"2";
    s <= "01"; wait for 10 ns;
    assert(y = x"3") report "test failed for 1 OR 2.";

    a <= x"2";
    b <= x"2";
    s <= "10"; wait for 10 ns;
    assert(y = x"4") report "test failed for 2 + 2.";

    a <= x"f";
    b <= x"2";
    s <= "10"; wait for 10 ns;
    assert(y = x"1") report "test failed for xF + 2.";

    a <= x"e";
    b <= x"2";
    s <= "11"; wait for 10 ns;
    assert(y = x"c") report "test failed for xE - 2.";

    a <= x"0";
    b <= x"1";
    s <= "11"; wait for 10 ns;
    assert(y = x"f") report "test failed for 0 - 1.";


    write (l, String'("Test complete."));
    writeline (output, l);
    wait;
  end process;
end test;

