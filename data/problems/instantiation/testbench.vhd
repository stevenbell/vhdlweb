--  Testbench for instantiating 
library IEEE;
use IEEE.std_logic_1164.all;
use std.textio.all;

entity instantiation_test is
-- No ports, since this is a testbench
end instantiation_test;

architecture test of instantiation_test is

component and4 is
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

  dut : and4 port map(a, b, c, y);

  process
    variable errors : integer := 0;

    -- Just keep a tally of errors
    -- We'll decide on what to report based on how many tests fail 
    procedure check(condition : boolean) is
    begin
      if not condition then
        errors := errors + 1;
      end if;
    end check;


  begin
    -- Result should be xnor
    -- If all are wrong, student forgot the NOT
    -- If > 0 is wrong, something else is broken
    a <= '0'; b <= '0'; c <= '0'; wait for 10 ns;
    check(y = '1');
    a <= '0'; b <= '0'; c <= '1'; wait for 10 ns;
    check(y = '0');
    a <= '0'; b <= '1'; c <= '0'; wait for 10 ns;
    check(y = '0');
    a <= '0'; b <= '1'; c <= '1'; wait for 10 ns;
    check(y = '1');
    a <= '1'; b <= '0'; c <= '0'; wait for 10 ns;
    check(y = '0');
    a <= '1'; b <= '0'; c <= '1'; wait for 10 ns;
    check(y = '1');
    a <= '1'; b <= '1'; c <= '0'; wait for 10 ns;
    check(y = '1');
    a <= '1'; b <= '1'; c <= '1'; wait for 10 ns;
    check(y = '0');

    if errors = 0 then
      write (output, "TEST PASSED." & LF);
    elsif errors = 8 then
      write (output, "All outputs were inverted.  Did you forget the NOT?" & LF);
    else
      write (output, "Test failed.  Did you use the `nand4` component?" & LF);
    end if;
 
    wait;
  end process;
end test;

