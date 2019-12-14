--  Testbench for blinking LED
library IEEE;
use IEEE.std_logic_1164.all;
use std.textio.all;

entity ledblink_test is
-- No ports, since this is a testbench
end ledblink_test;

architecture test of ledblink_test is

component top is
  port(
	  leds : out std_logic_vector(1 downto 0)
  );
end component;

signal leds : std_logic_vector(1 downto 0);

begin

  dut : top port map(leds);

  -- Check the results: time one output cycle and see how long it is
  process
    variable starttime : time;
    variable endtime : time;

  begin
    wait until rising_edge(leds(0));
    assert leds(1) = '0' report "LED 0 and 1 are simultaneously high!";
    starttime := now;

    wait until falling_edge(leds(0));
    assert leds(1) = '1' report "LED 0 and 1 are simultaneously low!";

    wait until rising_edge(leds(0));
    endtime := now;

    report "Time elapsed for one cycle: " & to_string(endtime - starttime);
    
    -- Use 1001 ms becuase of integer rounding
    report "Resulting frequency is: " & to_string(1001 ms / (endtime - starttime)) & " Hz";
         
    report "Test complete. (Killing simulation with error; ignore the message)" severity failure;

    wait;
  end process;
end test;

