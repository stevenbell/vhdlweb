--  Testbench for 8-bit one hot counter
library IEEE;
use IEEE.std_logic_1164.all;
use std.textio.all;

entity count5_test is
-- No ports, since this is a testbench
end count5_test;

architecture test of count5_test is

component count5 is
  port(
	  clk : in std_logic;
	  reset : in std_logic;
	  flag : out std_logic
  );
end component;

signal clk : std_logic;
signal reset : std_logic;
signal flag : std_logic;
begin

  dut : count5 port map(clk, reset, flag);

  -- Generate 100MHz clock
  process begin
    clk <= '1'; wait for 5 ns;
    clk <= '0'; wait for 5 ns;
  end process;

  -- Assert reset and let it start running
  --process begin
  --  reset <= '0'; wait for 12 ns;
  --  reset <= '1'; wait for 20 ns;
  --  reset <= '0'; wait;
  --end process;

  -- Check the results
  process
    variable sinceLastOne : integer;
    variable errors : integer := 0;
  begin
    reset <= '1';
    write(output, "(reset asserted)" & LF);
    wait for 27 ns;
    reset <= '0';
    write(output, "(reset released)" & LF);

    -- Find the first occurance of '1'
    while flag /= '1' loop
      wait until falling_edge(clk);
      write(output, "out: " & to_string(flag) & LF);
    end loop;

    sinceLastOne := 0;

    -- Now run for a while and make sure the 1s occur at the right time
    for i in 0 to 20 loop
      wait until falling_edge(clk);
      write(output, "out: " & to_string(flag));

      if flag = '1' then
        if sinceLastOne /= 4 then
          errors := errors + 1;
          write(output, " <-- error, expected 5 cycles before next 1, but got " & to_string(sinceLastOne + 1));
        end if;
        sinceLastOne := 0;
      else
        sinceLastOne := sinceLastOne + 1;
      end if;
      write(output, to_string(LF));

    end loop;
    
   if errors = 0 then
      write (output, "TEST PASSED." & LF);
    else
      write (output, "Test failed with " & to_string(errors) &  " errors." & LF);
    end if;
 
    std.env.finish; -- All done, but clock is still going
    wait;
  end process;
end test;

