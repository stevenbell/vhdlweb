--  Testbench for AB+!BC
library IEEE;
use IEEE.std_logic_1164.all;
use std.textio.all;

entity majority_test is
-- No ports, since this is a testbench
end majority_test;

architecture test of majority_test is

component majority is
  port(
	  votes : in std_logic_vector(2 downto 0);
	  y : out std_logic
  );
end component;

signal votes : std_logic_vector(2 downto 0);
signal y : std_logic;

begin

  dut : majority port map(votes, y);

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
    votes <= "000"; wait for 10 ns;
    check(y = '0', "test failed for 000.");
    votes <= "001"; wait for 10 ns;
    check(y = '0', "test failed for 001.");
    votes <= "010"; wait for 10 ns;
    check(y = '0', "test failed for 010.");
    votes <= "011"; wait for 10 ns;
    check(y = '1', "test failed for 011.");
    votes <= "100"; wait for 10 ns;
    check(y = '0', "test failed for 100.");
    votes <= "101"; wait for 10 ns;
    check(y = '1', "test failed for 101.");
    votes <= "110"; wait for 10 ns;
    check(y = '1', "test failed for 110.");
    votes <= "111"; wait for 10 ns;
    check(y = '1', "test failed for 111.");

    if errors = 0 then
      write (output, "TEST PASSED." & LF);
    else
      write (output, "Test failed with " & to_string(errors) &  " errors." & LF);
    end if;

    wait;
  end process;
end test;

