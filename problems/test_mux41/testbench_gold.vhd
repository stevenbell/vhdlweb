--  Testbench for AB+!BC
library IEEE;
use IEEE.std_logic_1164.all;
use std.textio.all;

entity mux41_test is
-- No ports, since this is a testbench
end mux41_test;

architecture test of mux41_test is

component mux41 is
  port(
	  d : in std_logic_vector(3 downto 0); -- Data port
	  s : in std_logic_vector(1 downto 0); -- Select
	  y : out std_logic -- Result
  );
end component;

signal d : std_logic_vector(3 downto 0);
signal s : std_logic_vector(1 downto 0);
signal y : std_logic;

begin

  dut : mux41 port map(d, s, y);

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

    -- 4:1 mux
    d <= "1110"; s <= "00"; wait for 10 ns;
    check(y = '0', "test failed for d0 = 0.");
    d <= "0001"; s <= "00"; wait for 10 ns;
    check(y = '1', "test failed for d0 = 1.");

    d <= "1101"; s <= "01"; wait for 10 ns;
    check(y = '0', "test failed for d1 = 0.");
    d <= "0010"; s <= "01"; wait for 10 ns;
    check(y = '1', "test failed for d1 = 1.");

    d <= "1011"; s <= "10"; wait for 10 ns;
    check(y = '0', "test failed for d2 = 0.");
    d <= "0100"; s <= "10"; wait for 10 ns;
    check(y = '1', "test failed for d2 = 1.");

    d <= "0111"; s <= "11"; wait for 10 ns;
    check(y = '0', "test failed for d3 = 0.");
    d <= "1000"; s <= "11"; wait for 10 ns;
    check(y = '1', "test failed for d3 = 1.");
    
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

