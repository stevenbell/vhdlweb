--  Testbench for AB+!BC
library IEEE;
use IEEE.std_logic_1164.all;
use std.textio.all;

entity mux21_test is
-- No ports, since this is a testbench
end mux21_test;

architecture test of mux21_test is

component mux21 is
  port(
	  a : in std_logic_vector(7 downto 0);
	  b : in std_logic_vector(7 downto 0);
	  s : in std_logic;
	  y : out std_logic_vector(7 downto 0)
  );
end component;

signal a : std_logic_vector(7 downto 0);
signal b : std_logic_vector(7 downto 0);
signal s : std_logic;
signal y : std_logic_vector(7 downto 0);

begin

  dut : mux21 port map(a, b, s, y);

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
    a <= x"FF"; b <= x"88";
    s <= '0'; wait for 10 ns;
    check(y = a, "test failed for s = 0.");

    s <= '1'; wait for 10 ns;
    check(y = b, "test failed for s = 1.");

    a <= x"39"; b <= x"C7";
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

