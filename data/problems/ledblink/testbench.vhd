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
    variable errors : integer := 0;
    variable starttime : time;
    variable endtime : time;
    variable dt : time;

    -- Function
    procedure check(condition : boolean; message : string) is
    begin
      if not condition then
        report message;
        errors := errors + 1;
      end if;
    end check;

  begin
    wait until rising_edge(leds(0));
    check(leds(1) = '0', "LED 0 and 1 are simultaneously high!");
    starttime := now;

    wait until falling_edge(leds(0));
    check(leds(1) = '1', "LED 0 and 1 are simultaneously low!");

    wait until rising_edge(leds(0));
    endtime := now;

    dt := endtime - starttime;
    report "Time elapsed for one cycle: " & to_string(dt, 1 us);
    report "Resulting frequency is: " & to_string(1e6 us / dt) & " Hz";
         
    check(dt > 100 us, "Test failed: Blink period is shorter than 100 us!");
    check(dt < 200 us, "Test failed: Blink period is longer than 200 us!");

    if errors = 0 then
      write (output, "TEST PASSED." & LF);
    end if;
 
    std.env.finish;

    wait;
  end process;
end test;

