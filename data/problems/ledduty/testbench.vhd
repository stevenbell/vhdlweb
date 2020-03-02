--  Testbench for 1kHz 25% duty cycle generator
library IEEE;
use IEEE.std_logic_1164.all;
use std.textio.all;

entity ledduty_test is
-- No ports, since this is a testbench
end ledduty_test;

architecture test of ledduty_test is

component ledduty is
  port(
	  clk : in std_logic;
	  reset : in std_logic;
	  led : out std_logic
  );
end component;

signal clk : std_logic;
signal reset : std_logic;
signal led : std_logic;

begin

  dut : ledduty port map(clk, reset, led);

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

    variable onstart : real; -- Times in microseconds
    variable offstart : real;
    variable endtime : real;

    procedure check(condition : boolean; message : string) is
    begin
      if not condition then
        report message;
        errors := errors + 1;
      end if;
    end check;

  begin
    wait until falling_edge(reset);

    wait until rising_edge(led);
    onstart := real(now / 1 us);

    wait until falling_edge(led);
    offstart := real(now / 1 us);

    wait until rising_edge(led);
    endtime := real(now / 1 us);

    report "Time elapsed for one cycle: " & to_string(endtime - onstart) & " microseconds";

    report "Resulting frequency is: " & to_string(1000.0 / (endtime - onstart)) & " kHz";
    report "Duty cycle is: " & to_string(integer(100.0 * (offstart - onstart) / (endtime - onstart))) & " %";

    check((endtime - onstart) < 1001.0, "Test failed: Frequency is too low!");
    check((endtime - onstart) > 999.0, "Test failed: Frequency is too high!");

    check((offstart - onstart) < 251.0, "Test failed: On period is too long!");
    check((offstart - onstart) > 249.0, "Test failed: On period is too short!");

    if errors = 0 then
      write (output, "TEST PASSED." & LF);
    else
      write (output, "Test failed with " & to_string(errors) &  " errors." & LF);
    end if;

    std.env.finish; -- Forcefully end the simulation, since the clock is still going

  end process;
end test;

