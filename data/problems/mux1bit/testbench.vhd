--  Testbench for AB+!BC
library IEEE;
use IEEE.std_logic_1164.all;
use std.textio.all;

entity mux1bit_test is
-- No ports, since this is a testbench
end mux1bit_test;

architecture test of mux1bit_test is

component mux1bit is
  port(
	  a : in std_logic;
	  b : in std_logic;
	  s : in std_logic;
	  y : out std_logic
  );
end component;

signal a : std_logic;
signal b : std_logic;
signal s : std_logic;
signal y : std_logic;

begin

  dut : mux1bit port map(a, b, s, y);

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
    -- Both low
    a <= '0'; b <= '0';
    s <= '0'; wait for 10 ns;
    check(y = a, "test failed for s = 0.");

    s <= '1'; wait for 10 ns;
    check(y = b, "test failed for s = 1.");

    -- One low, one high
    a <= '1'; b <= '0';
    s <= '0'; wait for 10 ns;
    check(y = a, "test failed for s = 0.");

    s <= '1'; wait for 10 ns;
    check(y = b, "test failed for s = 1.");

    -- Now flip
    a <= '0'; b <= '1';
    s <= '0'; wait for 10 ns;
    check(y = a, "test failed for s = 0.");

    s <= '1'; wait for 10 ns;
    check(y = b, "test failed for s = 1.");

    -- Both high
    a <= '1'; b <= '1';
    s <= '0'; wait for 10 ns;
    check(y = a, "test failed for s = 0.");

    s <= '1'; wait for 10 ns;
    check(y = b, "test failed for s = 1.");

    if errors = 0 then
      write (output, "TEST PASSED." & LF);
    else
      write (output, "Test failed with " & to_string(errors) &  " errors." & LF);
    end if;

    wait;
  end process;
end test;

