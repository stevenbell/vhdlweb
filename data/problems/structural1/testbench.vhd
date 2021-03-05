--  Testbench for instantiating 
library IEEE;
use IEEE.std_logic_1164.all;
use std.textio.all;

entity structural1_test is
-- No ports, since this is a testbench
end structural1_test;

architecture test of structural1_test is

component funinabox is
  port(
	  a : in std_logic;
	  b : in std_logic;
	  result : out std_logic_vector(3 downto 0)
  );
end component;

signal a : std_logic;
signal b : std_logic;
signal result : std_logic_vector(3 downto 0);

begin

  dut : funinabox port map(a, b, result);

  process
    variable errors : integer := 0;

    procedure check(condition : boolean; message : string) is
    begin
      if not condition then
        report message;
        errors := errors + 1;
      end if;
    end check;


  begin
    a <= '0'; b <= '0'; wait for 10 ns;
    check(result = "0000", "Test failed for a = 0, b = 0, result is " & to_string(result));
    a <= '1'; b <= '0'; wait for 10 ns;
    check(result = "1010", "Test failed for a = 1, b = 0, result is " & to_string(result));
    a <= '0'; b <= '1'; wait for 10 ns;
    check(result = "0100", "Test failed for a = 0, b = 1, result is " & to_string(result));
    a <= '1'; b <= '1'; wait for 10 ns;
    check(result = "1110", "Test failed for a = 1, b = 1, result is " & to_string(result));

    if errors = 0 then
      write (output, "TEST PASSED." & LF);
    else
      write (output, "Test failed with " & to_string(errors) & " errors. Check that components are connected correctly and that you aren't modifying any signals." & LF);
    end if;
 
    wait;
  end process;
end test;

