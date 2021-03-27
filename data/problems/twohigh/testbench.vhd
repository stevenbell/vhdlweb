--  Testbench for 8-bit one hot counter
library IEEE;
use IEEE.std_logic_1164.all;
use std.textio.all;

entity twohigh_test is
-- No ports, since this is a testbench
end twohigh_test;

architecture test of twohigh_test is

component twohigh is
  port(
	  clk : in std_logic;
    input : in std_logic;
	  two : out std_logic
  );
end component;

signal clk : std_logic;
signal input : std_logic;
signal two : std_logic;

begin

  dut : twohigh port map(clk, input, two);

  -- Generate 100MHz clock
  process begin
    clk <= '1'; wait for 5 ns;
    clk <= '0'; wait for 5 ns;
  end process;

  -- Check the results
  process
    variable errors : integer := 0;

    procedure print_and_check(actual : std_logic; expected : std_logic) is
    begin
      if actual = expected then
        write(output, to_string(input) & "   " & to_string(actual) & LF);
      else
        write(output, to_string(input) & "   " & to_string(actual) & " <--- Error, expected " & to_string(expected) & LF);
        errors := errors + 1;
      end if;
    end print_and_check;

  begin
    write(output, "in  two" & LF);
    -- Set input to 0 and wait two clock cycles so both are zero
    input <= '0';

    wait until falling_edge(clk);
    wait until falling_edge(clk);
    print_and_check(two, '0');
    input <= '1';
    
    wait until falling_edge(clk);
    print_and_check(two, '0'); -- One cycle later, AND is still 0

    wait until falling_edge(clk);
    print_and_check(two, '1'); -- Two cycles later, AND should be 1

    wait until falling_edge(clk);
    print_and_check(two, '1');
    input <= '0';

    wait until falling_edge(clk);
    print_and_check(two, '0');
 

    if errors = 0 then
      write (output, "TEST PASSED." & LF);
    else
      write (output, "Test failed with " & to_string(errors) &  " errors." & LF);
    end if;
 
    std.env.finish; -- All done, but clock is still going

    wait;
  end process;
end test;

