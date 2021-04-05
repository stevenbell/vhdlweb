--  Testbench for 8-bit one hot counter
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use std.textio.all;

entity detect001_test is
-- No ports, since this is a testbench
end detect001_test;

architecture test of detect001_test is

component detect001 is
  port(
    clk : in std_logic;
    input : in std_logic;
    result : out std_logic
  );
end component;

signal clk : std_logic;
signal dut_input : std_logic;
signal dut_result : std_logic;

begin

  dut : detect001 port map(clk, dut_input, dut_result);

  -- Generate 100MHz clock
  process begin
    clk <= '1'; wait for 5 ns;
    clk <= '0'; wait for 5 ns;
  end process;

  -- Run tests from file
  process is
    -- Variables for reading the test vector file
    file tv : text;
    variable l : line;
    variable testinput : std_logic;
    variable separator : character;
    variable expectedout : std_logic;

    -- Error counting
    variable errors : integer := 0;

    procedure check(condition : boolean; message : string) is
    begin
      if not condition then
        report message severity error;
        errors := errors + 1;
      end if;
    end check;

    procedure print_and_check(input : std_logic; actual : std_logic; expected : std_logic) is
    begin
      if actual = expected then
        write(output, " " & to_string(input) & " | " & to_string(actual) & LF);
      else
        write(output, " " & to_string(input) & " | " & to_string(actual) & " <--- Error, expected " & to_string(expected) & LF);
        errors := errors + 1;
      end if;
    end print_and_check;


  begin
    write(output, "IN | OUT" & LF);
    FILE_OPEN(tv, "testvectors.txt", READ_MODE);

    while not endfile(tv) loop

      -- Change the inputs slightly after the rising edge
      -- This is as if the inputs are driven by the same clock, with some delay
      wait until rising_edge(clk); wait for 1 ns;
      readline(tv, l);
      read(l, testinput); -- Should be 1 or 0
      read(l, separator); -- Eat the underscore
      read(l, expectedout); -- Should be 1 or 0

      dut_input <= testinput;

      -- Check the outputs once everything has settled
      -- Just before the next rising edge would be ideal, but after the falling
      -- edge works just as well.
      wait until falling_edge(clk);
      print_and_check(dut_input, dut_result, expectedout);

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

