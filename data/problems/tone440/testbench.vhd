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
    variable errors : integer := 0;
    variable starttime : time;
    variable endtime : time;
    variable dt : time;
    variable freq : real;

    procedure check(condition : boolean; message : string) is
    begin
      if not condition then
        report message;
        errors := errors + 1;
      end if;
    end check;

  begin
    wait until falling_edge(reset);

    wait until rising_edge(tone);
    starttime := now;

    wait until rising_edge(tone);
    endtime := now;

    dt := endtime - starttime;

    -- Little hack to report this as a real number
    freq := 1.0e12 / real(dt / 1 ps);

    report "Time elapsed for one cycle: " & to_string(dt, 1 us);
    report "Resulting frequency is: " & to_string(freq, 2) & " Hz";

    check(freq > 439.5, "Test failed: Frequency is too low!");
    check(freq < 440.5, "Test failed: Frequency is too high!");

    if errors = 0 then
      write (output, "TEST PASSED." & LF);
    end if;
 
    std.env.finish; -- Forcefully end the simulation, since the clock is still going

    wait;
  end process;
end test;

