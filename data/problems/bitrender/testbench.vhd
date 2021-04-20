--  Testbench for 8-bit one hot counter
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use std.textio.all;

entity bitrender_test is
-- No ports, since this is a testbench
end bitrender_test;

architecture test of bitrender_test is

-- DUT
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

-- Our own copy of the ROM as the gold model
component rom is
  port(
    clk : in std_logic;
    addr : in std_logic_vector(5 downto 0); -- 64 words total
    data : out std_logic_vector(7 downto 0) -- 8-bit words
  );
end component;

signal addr : std_logic_vector(5 downto 0);
signal data : std_logic_vector(7 downto 0); -- Memory has 8-bit words
signal goldpixel : std_logic;

begin

  dut : bitrender port map(clk, row_addr, col_addr, pixel);

  -- Generate 100MHz clock
  process begin
    clk <= '1'; wait for 5 ns;
    clk <= '0'; wait for 5 ns;
  end process;

  -- Connect our own copy of the ROM as the gold model
  goldrom : rom port map(clk, addr, data);
  addr <= std_logic_vector(row_addr) & std_logic_vector(col_addr(5 downto 3));
  goldpixel <= data(7 - to_integer(col_addr(2 downto 0)));


  process
    -- Silently count the number of errors
    variable errors : integer := 0;
    procedure check(condition : boolean) is
    begin
      if not condition then
        errors := errors + 1;
      end if;
    end check;

  begin

    for row in 0 to 7 loop
      row_addr <= to_unsigned(row, 3);
      write(output, "|");
      for col in 0 to 63 loop
        col_addr <= to_unsigned(col, 6);

        wait until rising_edge(clk);
        wait for 1 ns;

        check(pixel = goldpixel);

        if pixel then
          write(output, "#");
        else
          write(output, " ");
        end if;
      end loop;
      write(output, "|" & LF);
    end loop;


    if errors = 0 then
      write (output, "TEST PASSED." & LF);
    else
      write (output, "Test failed with " & to_string(errors) &  " incorrect pixels." & LF);
    end if;
 
    std.env.finish; -- All done, but clock is still going
    wait;
  end process;
end test;

