--  Testbench for 8-bit one hot counter
library IEEE;
use IEEE.std_logic_1164.all;
use std.textio.all;

entity risingedge_test is
-- No ports, since this is a testbench
end risingedge_test;

architecture test of risingedge_test is

component risingedge is
  port(
	  clk : in std_logic;
	  D : in std_logic;
	  flag : out std_logic
  );
end component;

signal clk : std_logic;
signal D : std_logic;
signal flag : std_logic;
begin

  dut : risingedge port map(clk, D, flag);

  -- Generate 100MHz clock
  process begin
    clk <= '1'; wait for 5 ns;
    clk <= '0'; wait for 5 ns;
  end process;

  -- Check the results
  process
    variable errors : integer := 0;

    procedure print_and_check(input : std_logic; actual : std_logic; expected : std_logic) is
    begin
      if actual = expected then
        write(output, to_string(input) & " | " & to_string(actual) & LF);
      else
        write(output, to_string(input) & " | " & to_string(actual) & " <--- Error, expected " & to_string(expected) & LF);
        errors := errors + 1;
      end if;
    end print_and_check;

  begin
    write(output, "D | flag" & LF);
    D <= '0';
    wait until falling_edge(clk);
    wait until falling_edge(clk);
    wait until falling_edge(clk);
  
    print_and_check(D, flag, '0');

    -- Set data high, flag should be high after the next rising edge
    d <= '1';
    wait until rising_edge(clk); wait for 1 ns;
    print_and_check(D, flag, '1');

    -- Flag should go low again after the next rising edge
    wait until rising_edge(clk); wait for 1 ns;
    print_and_check(D, flag, '0');

    -- and stay low...
    wait until rising_edge(clk); wait for 1 ns;
    print_and_check(D, flag, '0');

    d <= '0';
    wait until rising_edge(clk); wait for 1 ns;
    print_and_check(D, flag, '0');
    wait until rising_edge(clk); wait for 1 ns;
    print_and_check(D, flag, '0');
    wait until rising_edge(clk); wait for 1 ns;
    print_and_check(D, flag, '0');

    d <= '1';
    wait until rising_edge(clk); wait for 1 ns;
    print_and_check(D, flag, '1');

    d <= '0';
    wait until rising_edge(clk); wait for 1 ns;
    print_and_check(D, flag, '0');

    wait until rising_edge(clk); wait for 1 ns;
    print_and_check(D, flag, '0');

    if errors = 0 then
      write (output, "TEST PASSED." & LF);
    else
      write (output, "Test failed with " & to_string(errors) &  " errors." & LF);
    end if;
 
    std.env.finish; -- All done, but clock is still going
    wait;
  end process;
end test;

