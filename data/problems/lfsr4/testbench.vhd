--  Testbench for 8-bit one hot counter
library IEEE;
use IEEE.std_logic_1164.all;
use std.textio.all;

entity lfsr4_test is
-- No ports, since this is a testbench
end lfsr4_test;

architecture test of lfsr4_test is

component lfsr4 is
  port(
	  clk : in std_logic;
	  reset : in std_logic;
	  count : out std_logic_vector(3 downto 0)
  );
end component;

signal clk : std_logic;
signal reset : std_logic;
signal count : std_logic_vector(3 downto 0);

begin

  dut : lfsr4 port map(clk, reset, count);

  -- Generate 100MHz clock
  process begin
    clk <= '1'; wait for 5 ns;
    clk <= '0'; wait for 5 ns;
  end process;

  -- Generate reset
  process begin
    reset <= '1'; wait for 27 ns;
    reset <= '0'; wait;
  end process;

  -- Check the results
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
    wait until falling_edge(reset);
    -- At least one clock cycle has gone by in reset; output should be initialized
    check(count = "0001", "test failed coming out of reset.");

    for i in 0 to 15 loop
       report "Value of LFSR is: " & to_string(count);
       wait until falling_edge(clk);
    end loop;
    
    if errors = 0 then
      write (l, String'("Test passed."));
    else
      write (l, String'("Test failed with "));
      write (l, errors);
      write (l, String'(" errors."));
    end if;
    writeline (output, l);

    -- Kill the simulation
    report "Simulation finished (ignore the following error message)" severity failure;
    wait;
  end process;
end test;

