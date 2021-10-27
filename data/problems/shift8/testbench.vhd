--  Testbench for 8-bit one hot counter
library IEEE;
use IEEE.std_logic_1164.all;
use std.textio.all;

entity shift8_test is
-- No ports, since this is a testbench
end shift8_test;

architecture test of shift8_test is

component shift8 is
  port(
	  clk : in std_logic;
    input : in std_logic;
	  result : out std_logic_vector(7 downto 0)
  );
end component;

signal clk : std_logic;
signal input : std_logic;
signal result : std_logic_vector(7 downto 0);

begin

  dut : shift8 port map(clk, input, result);

  -- Generate 100MHz clock
  process begin
    clk <= '1'; wait for 5 ns;
    clk <= '0'; wait for 5 ns;
  end process;

  -- Run the clock for 8 cycles, printing the result out each time
  -- Then check the answer at the very end
  process
    constant TEST_BITS : std_logic_vector(7 downto 0) := "01110101";

  begin
    write(output, "in  result" & LF);

    for i in 7 downto 0 loop
      input <= TEST_BITS(i);
      wait until rising_edge(clk);
      wait until falling_edge(clk);
      write(output, to_string(input) & "   " & to_string(result) & LF);
    end loop;


    write(output, LF & "Final result:" & to_string(result) & LF);

    if result = TEST_BITS then
      write (output, "TEST PASSED." & LF);
    else
      write (output, "Test failed; final result doesn't match shifted bits!" & LF);
    end if;
 
    std.env.finish; -- All done, but clock is still going

    wait;
  end process;
end test;

