--  Testbench for 8-bit one hot counter
library IEEE;
use IEEE.std_logic_1164.all;
use std.textio.all;

entity lfsr4_test is
-- No ports, since this is a testbench
end lfsr4_test;

architecture test of lfsr4_test is

component lfsr4 is
  port(
	  clk : in std_logic;
	  reset : in std_logic;
	  count : out std_logic_vector(3 downto 0)
  );
end component;

signal clk : std_logic;
signal reset : std_logic;
signal count : std_logic_vector(3 downto 0);
signal gold : std_logic_vector(3 downto 0); -- Testbench gold model
begin

  dut : lfsr4 port map(clk, reset, count);

  -- Generate 100MHz clock
  process begin
    clk <= '1'; wait for 5 ns;
    clk <= '0'; wait for 5 ns;
  end process;

  -- Check the results
  process
    variable errors : integer := 0;

    procedure print_and_check(actual : std_logic_vector(3 downto 0); expected : std_logic_vector(3 downto 0)) is
    begin
      if actual = expected then
        write(output, to_string(actual) & LF);
      else
        write(output, to_string(actual) & " <--- Error, expected " & to_string(expected) & LF);
        errors := errors + 1;
      end if;
    end print_and_check;

  begin
    write(output, "count:" & LF);
  
    write(output, "(reset asserted)" & LF);
    reset <= '1';
    gold <= "0001";
    wait for 27 ns;
    print_and_check(count, "0001");

    -- Check twice during reset so students have to get this right, not just initialize
    -- the signal with the right constant to make the shifting align with the test.
    wait until falling_edge(clk);
    print_and_check(count, "0001");

    reset <= '0';
    write(output, "(reset released)" & LF);

    for i in 0 to 15 loop
      -- Compute the next expected value
      gold(3) <= gold(0);
      gold(2) <= gold(3) xor gold(0);
      gold(1 downto 0) <= gold (2 downto 1);

      wait until falling_edge(clk);
      print_and_check(count, gold);
    end loop;
    
   if errors = 0 then
      write (output, "TEST PASSED." & LF);
    else
      write (output, "Test failed with " & to_string(errors) &  " errors." & LF);
    end if;
 
    std.env.finish; -- All done, but clock is still going
    wait;
  end process;
end test;

