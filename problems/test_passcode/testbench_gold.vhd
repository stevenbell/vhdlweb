--  Reference testbench for passcode
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use std.textio.all;

entity passcode_test is
-- No ports, since this is a testbench
end passcode_test;

architecture test of passcode_test is

component passcode is
  port(
    clk : in std_logic; -- Clock
	  black : in std_logic; -- Black button
	  yellow : in std_logic; -- Yellow button
	  red : out std_logic; -- Locked
	  green : out std_logic -- Unlocked
  );
end component;


signal clk : std_logic; -- Clock
signal black : std_logic := '0'; -- Black button
signal yellow : std_logic := '0'; -- Yellow button
signal red : std_logic; -- Locked
signal green : std_logic; -- Unlocked

begin

  dut : passcode port map(clk => clk, black => black, yellow => yellow,
                          red => red, green => green);

  -- Create 1MHz clock
  process begin
    clk <= '0';
    wait for 500 ns;
    clk <= '1';
    wait for 500 ns;
  end process;

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
    wait for 1 us;
    wait until rising_edge(clk);
    check(red = '1', "Initialization failed - red off.");
    check(green = '0', "Initialization failed - green on.");

    wait until falling_edge(clk);
    yellow <= '1'; black <= '0';
    wait until rising_edge(clk); wait for 1 ns;
    check(red = '0', "ONE failed.");

    wait until falling_edge(clk);
    yellow <= '0'; black <= '1';
    wait until rising_edge(clk); wait for 1 ns;
    check(red = '0', "UNLOCKED failed.");
    check(green = '1', "UNLOCKED failed.");

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

