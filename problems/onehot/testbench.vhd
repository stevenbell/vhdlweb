--  Testbench for 8-bit one hot counter
library IEEE;
use IEEE.std_logic_1164.all;
use std.textio.all;

entity onehot_test is
-- No ports, since this is a testbench
end onehot_test;

architecture test of onehot_test is

component onehot is
  port(
	  clk : in std_logic;
	  reset : in std_logic;
	  count : out std_logic_vector(7 downto 0)
  );
end component;

signal clk : std_logic;
signal reset : std_logic;
signal count : std_logic_vector(7 downto 0);

begin

  dut : onehot port map(clk, reset, count);

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
    check(count = "00000001", "test failed coming out of reset.");

    -- Check the results on falling edge
    wait until falling_edge(clk);
    check(count = "00000010", "test failed on cycle 1.");

    wait until falling_edge(clk);
    check(count = "00000100", "test failed on cycle 2.");

    wait until falling_edge(clk);
    check(count = "00001000", "test failed on cycle 3.");

     wait until falling_edge(clk);
    check(count = "00010000", "test failed on cycle 4.");

    wait until falling_edge(clk);
    check(count = "00100000", "test failed on cycle 5.");

    wait until falling_edge(clk);
    check(count = "01000000", "test failed on cycle 6.");

    wait until falling_edge(clk);
    check(count = "10000000", "test failed on cycle 7.");

    wait until falling_edge(clk);
    check(count = "00000001", "test failed on cycle 8.");
     
    if errors = 0 then
      report "Test passed.";
    else
      write (l, String'("Test failed with "));
      write (l, errors);
      write (l, String'(" errors."));
      report "Test failed." severity failure;
    end if;
    writeline (output, l);

    wait;
  end process;
end test;

