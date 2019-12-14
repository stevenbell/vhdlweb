--  Testbench for AB+!BC
library IEEE;
use IEEE.std_logic_1164.all;
use std.textio.all;

entity and_test is
-- No ports, since this is a testbench
end and_test;

architecture test of and_test is

component andgate is
  port(
	  a : in std_logic;
	  b : in std_logic;
	  y : out std_logic
  );
end component;

signal a : std_logic;
signal b : std_logic;
signal y : std_logic;

begin

  dut : andgate port map(a, b, y);

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
    -- a AND b
    a <= '0'; b <= '0'; wait for 10 ns;
    check(y = '0', "test failed for 00.");
    a <= '0'; b <= '1'; wait for 10 ns;
    check(y = '0', "test failed for 01.");
    a <= '1'; b <= '0'; wait for 10 ns;
    check(y = '0', "test failed for 10.");
    a <= '1'; b <= '1'; wait for 10 ns;
    check(y = '1', "test failed for 11.");
    
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

