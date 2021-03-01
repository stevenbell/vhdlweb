--  Testbench for 4-input OR
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use std.textio.all;

entity or4_test is
-- No ports, since this is a testbench
end or4_test;

architecture test of or4_test is

component or4 is
  port(
	  a : in std_logic;
	  b : in std_logic;
	  c : in std_logic;
	  d : in std_logic;
	  y : out std_logic
  );
end component;


signal bits : unsigned(3 downto 0);
signal y : std_logic;

begin

  dut : or4 port map(bits(3), bits(2), bits(1), bits(0), y);


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
    bits <= "0000"; wait for 10 ns;
    check(y = '0', "test failed for 0000.");

    for bitval in 1 to 15 loop
      bits <= to_unsigned(bitval, 4); wait for 10 ns;
      check(y = '1', "test failed for " & to_string(bits) & LF);
    end loop;

    if errors = 0 then
      write (output, "TEST PASSED." & LF);
    else
      write (output, "Test failed with " & to_string(errors) &  " errors." & LF);
    end if;

    wait;
  end process;
end test;

