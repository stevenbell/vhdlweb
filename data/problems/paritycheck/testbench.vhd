--  Testbench for 8-bit one hot counter
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use std.textio.all;

entity paritycheck_test is
-- No ports, since this is a testbench
end paritycheck_test;

architecture test of paritycheck_test is

component paritycheck is
  port(
	  clk : in std_logic;
	  reset : in std_logic;
	  data : in std_logic;
	  complete : out std_logic;
	  valid : out std_logic
  );
end component;

signal clk : std_logic;
signal reset : std_logic;
signal data : std_logic;
signal complete : std_logic;
signal valid : std_logic;

begin

  dut : paritycheck port map(clk, reset, data, complete, valid);

  -- Generate 100MHz clock
  process begin
    clk <= '1'; wait for 5 ns;
    clk <= '0'; wait for 5 ns;
  end process;

  -- Check the results
  process
    variable errors : integer := 0;

    procedure print_and_check(actual : std_logic_vector(1 downto 0); expected : std_logic_vector(1 downto 0)) is
    begin
      if actual = expected then
        write(output, to_string(actual(1)) & " | " & to_string(actual(0)) & LF);
      else
        write(output, to_string(actual(1)) & " | " & to_string(actual(0)) & " <--- Error, expected " & to_string(expected) & LF);
        errors := errors + 1;
      end if;
    end print_and_check;

    procedure run_check(bits : std_logic_vector(7 downto 0)) is
      variable gold_parity : std_logic := '0';
    begin
      write(output, LF & "--- Testing " & to_string(bits) & "---" & LF);
      write(output, "complete | valid" & LF);
      write(output, "(reset asserted)" & LF);
      reset <= '1';
      wait for 27 ns;
      print_and_check(complete & valid, "00");

      wait until falling_edge(clk);
      reset <= '0';
      write(output, "(transmitting bits)" & LF);

      for i in 7 downto 1 loop
        data <= bits(i);
        gold_parity := gold_parity xor bits(i);
        wait until falling_edge(clk);
        print_and_check(complete & valid, "00");
      end loop;

      data <= bits(0);
      gold_parity := gold_parity xor bits(0);
      wait until falling_edge(clk);
      print_and_check(complete & valid, "1" & not gold_parity);

    end run_check;

  begin
    run_check("00000000"); -- valid
    run_check("10000001"); -- valid
    run_check("11111111"); -- valid
    run_check("10000000"); -- invalid
    run_check("10101000"); -- invalid
    run_check("00000111"); -- invalid   
    
   if errors = 0 then
      write (output, "TEST PASSED." & LF);
    else
      write (output, "Test failed with " & to_string(errors) &  " errors." & LF);
    end if;
 
    std.env.finish; -- All done, but clock is still going

    wait;
  end process;
end test;

