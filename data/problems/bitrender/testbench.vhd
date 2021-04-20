--  Testbench for 8-bit one hot counter
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use std.textio.all;

entity bitrender_test is
-- No ports, since this is a testbench
end bitrender_test;

architecture test of bitrender_test is

component bitrender is
  port(
	  clk : in std_logic;
    row : in unsigned(2 downto 0); -- vertical position, 0 to 7
    col : in unsigned(5 downto 0); -- horizontal position, 0 to 63
	  pixel : out std_logic
  );
end component;

signal clk : std_logic;
signal row_addr : unsigned(2 downto 0) := 3d"0";
signal col_addr : unsigned(5 downto 0) := 6d"0";
signal pixel : std_logic;

begin

  dut : bitrender port map(clk, row_addr, col_addr, pixel);

  -- Generate 100MHz clock
  process begin
    clk <= '1'; wait for 5 ns;
    clk <= '0'; wait for 5 ns;
  end process;

  process
  begin

    for row in 0 to 7 loop
      row_addr <= to_unsigned(row, 3);
      write(output, "|");
      for col in 0 to 63 loop
        col_addr <= to_unsigned(col, 6);

        wait until rising_edge(clk);
        wait for 1 ns;

        if pixel then
          write(output, "#");
        else
          write(output, " ");
        end if;
      end loop;
      write(output, "|" & LF);
    end loop;
 
    std.env.finish; -- All done, but clock is still going

    wait;
  end process;
end test;

