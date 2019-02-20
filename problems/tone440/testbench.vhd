--  Testbench for 440 Hz tone generator
library IEEE;
use IEEE.std_logic_1164.all;
use std.textio.all;

entity tone440_test is
-- No ports, since this is a testbench
end tone440_test;

architecture test of tone440_test is

component tone440 is
  port(
	  clk : in std_logic;
	  reset : in std_logic;
	  tone : out std_logic
  );
end component;

signal clk : std_logic;
signal reset : std_logic;
signal tone : std_logic;

begin

  dut : tone440 port map(clk, reset, tone);

  -- Generate 24.000MHz clock
  process begin
    clk <= '1'; wait for 20.83333 ns;
    clk <= '0'; wait for 20.83333 ns;
  end process;

  -- Generate reset
  process begin
    reset <= '1'; wait for 47 ns;
    reset <= '0'; wait;
  end process;

  -- Check the results: time one output cycle and see how long it is
  process
    variable starttime : time;
    variable endtime : time;

  begin
    wait until falling_edge(reset);

    wait until rising_edge(tone);
    starttime := now;

    wait until rising_edge(tone);
    endtime := now;

    report "Time elapsed for one cycle: " & to_string(endtime - starttime);
    
    -- Use 1001 ms becuase of integer rounding
    report "Resulting frequency is: " & to_string(1001 ms / (endtime - starttime)) & " Hz";
         
    report "Test complete.";

    wait;
  end process;
end test;

