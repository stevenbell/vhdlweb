--  Testbench for AB+!BC
library IEEE;
use IEEE.std_logic_1164.all;
use std.textio.all;

entity srlatch_test is
-- No ports, since this is a testbench
end srlatch_test;

architecture test of srlatch_test is

component srlatch is
  port(
	  s : in std_logic;
	  r : in std_logic;
	  q : out std_logic
  );
end component;

signal s : std_logic;
signal r : std_logic;
signal q : std_logic;

begin

  dut : srlatch port map(s, r, q);

  process
    variable errors : integer := 0;

    -- Function
    procedure check_equal(actual : std_logic; expected : std_logic; message : string) is
    begin
      if not (actual = expected) then
        report message & ", expected " & to_string(expected) & " but got " & to_string(actual);
        errors := errors + 1;
      end if;
    end check_equal;


  begin
    s <= '0'; r <= '1'; wait for 10 ns;
    check_equal(q, '0', "Error when reset asserted");
    s <= '0'; r <= '0'; wait for 10 ns;
    check_equal(q, '0', "Error after reset released");

    s <= '1'; r <= '0'; wait for 10 ns;
    check_equal(q, '1', "Error when set asserted");
    s <= '0'; r <= '0'; wait for 10 ns;
    check_equal(q, '1', "Error after set released");

    s <= '0'; r <= '1'; wait for 10 ns;
    check_equal(q, '0', "Error when reset asserted again");

   if errors = 0 then
      write (output, "TEST PASSED." & LF);
    else
      write (output, "Test failed with " & to_string(errors) &  " errors." & LF);
    end if;
 
    wait;
  end process;
end test;

