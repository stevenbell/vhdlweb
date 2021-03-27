--  Testbench for 8-bit one hot counter
library IEEE;
use IEEE.std_logic_1164.all;
use std.textio.all;

entity lfsr2_test is
-- No ports, since this is a testbench
end lfsr2_test;

architecture test of lfsr2_test is

component lfsr2 is
  port(
	  clk : in std_logic;
    reset : in std_logic;
	  b : out std_logic
  );
end component;

signal clk : std_logic;
signal reset : std_logic;
signal b : std_logic;

begin

  dut : lfsr2 port map(clk, reset, b);

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
        write(output, to_string(actual) & LF);
      else
        write(output, to_string(actual) & " <--- Error, expected " & to_string(expected) & LF);
        errors := errors + 1;
      end if;
    end print_and_check;

  begin
    write(output, "B:" & LF);
    reset <= '1';
    wait for 20 ns; -- A couple clock cycles
    wait until falling_edge(clk);
    print_and_check(b, '1');

    reset <= '0';
    wait until falling_edge(clk); -- First cycle after coming out of reset
    print_and_check(b, '1');

    wait until falling_edge(clk);
    print_and_check(b, '0');

    wait until falling_edge(clk);
    print_and_check(b, '1');

    wait until falling_edge(clk);
    print_and_check(b, '1');

    wait until falling_edge(clk);
    print_and_check(b, '0');
 

    if errors = 0 then
      write (output, "TEST PASSED." & LF);
    else
      write (output, "Test failed with " & to_string(errors) &  " errors." & LF);
    end if;
 
    std.env.finish; -- All done, but clock is still going

    wait;
  end process;
end test;

