--  Testbench for 8-bit one hot counter
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use std.textio.all;

entity counter_enable_test is
-- No ports, since this is a testbench
end counter_enable_test;

architecture test of counter_enable_test is

component counter_enable is
  port(
	  clk : in std_logic;
	  reset : in std_logic;
	  enable : in std_logic;
	  count : out unsigned(2 downto 0)
  );
end component;

signal clk : std_logic;
signal reset : std_logic;
signal enable : std_logic;
signal count : unsigned(2 downto 0);

begin

  dut : counter_enable port map(clk, reset, enable, count);

  -- Generate 100MHz clock
  process begin
    clk <= '1'; wait for 5 ns;
    clk <= '0'; wait for 5 ns;
  end process;

  -- Check the results
  process
    variable errors : integer := 0;

    procedure print_and_check(actual : unsigned(2 downto 0); expected : unsigned(2 downto 0)) is
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
    enable <= '1';
    wait for 27 ns;
    print_and_check(count, "000");

    -- Check twice during reset so students have to get this right, not just initialize
    -- the pattern with some magic offset.
    wait until falling_edge(clk);
    print_and_check(count, "000");

    reset <= '0';
    write(output, "(reset released)" & LF);

    wait until falling_edge(clk);
    print_and_check(count, "001");

    wait until falling_edge(clk);
    print_and_check(count, "010");

    write(output, "(enable low)" & LF);
    enable <= '0';

    wait until falling_edge(clk);
    print_and_check(count, "010");

    write(output, "(enable high)" & LF);
    enable <= '1';

    wait until falling_edge(clk);
    print_and_check(count, "011");

    wait until falling_edge(clk);
    print_and_check(count, "100");

    wait until falling_edge(clk);
    print_and_check(count, "101");

    wait until falling_edge(clk);
    print_and_check(count, "110");

    wait until falling_edge(clk);
    print_and_check(count, "111");

    write(output, "(enable low)" & LF);
    enable <= '0';

    wait until falling_edge(clk);
    print_and_check(count, "111");
 
    write(output, "(enable high)" & LF);
    enable <= '1';

    wait until falling_edge(clk);
    print_and_check(count, "000");
    
    
   if errors = 0 then
      write (output, "TEST PASSED." & LF);
    else
      write (output, "Test failed with " & to_string(errors) &  " errors." & LF);
    end if;
 
    std.env.finish; -- All done, but clock is still going

    wait;
  end process;
end test;

