--  Testbench for AB+!BC
library IEEE;
use IEEE.std_logic_1164.all;
use std.textio.all;

entity nand3_test is
-- No ports, since this is a testbench
end nand3_test;

architecture test of nand3_test is

component nand3 is
  port(
	  a : in std_logic;
	  b : in std_logic;
	  c : in std_logic;
	  y : out std_logic
  );
end component;

signal a : std_logic;
signal b : std_logic;
signal c : std_logic;
signal y : std_logic;

begin

  dut : nand3 port map(a, b, c, y);

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
    -- !(ABC)
    a <= '0'; b <= '0'; c <= '0'; wait for 10 ns;
    check(y = '1', "test failed for 000.");
    a <= '0'; b <= '0'; c <= '1'; wait for 10 ns;
    check(y = '1', "test failed for 001.");
    a <= '0'; b <= '1'; c <= '0'; wait for 10 ns;
    check(y = '1', "test failed for 010.");
    a <= '0'; b <= '1'; c <= '1'; wait for 10 ns;
    check(y = '1', "test failed for 011.");
    a <= '1'; b <= '0'; c <= '0'; wait for 10 ns;
    check(y = '1', "test failed for 100.");
    a <= '1'; b <= '0'; c <= '1'; wait for 10 ns;
    check(y = '1', "test failed for 101.");
    a <= '1'; b <= '1'; c <= '0'; wait for 10 ns;
    check(y = '1', "test failed for 110.");
    a <= '1'; b <= '1'; c <= '1'; wait for 10 ns;
    check(y = '0', "test failed for 111.");

    if errors = 0 then
      write (output, "TEST PASSED." & LF);
    else
      write (output, "Test failed with " & to_string(errors) &  " errors." & LF);
    end if;

    wait;
  end process;
end test;

