--  Testbench for 8-bit one hot counter
library IEEE;
use IEEE.std_logic_1164.all;
use std.textio.all;

entity cubefsm_test is
-- No ports, since this is a testbench
end cubefsm_test;

architecture test of cubefsm_test is

component cubefsm is
  port(
	  clk : in std_logic;
	  valid_in : in std_logic;
	  valid_out : out std_logic;
	  b_select : out std_logic
  );
end component;

signal clk : std_logic;
signal valid_in : std_logic;
signal valid_out : std_logic;
signal b_select : std_logic;

begin

  dut : cubefsm port map(clk, valid_in, valid_out, b_select);

  -- Generate 100MHz clock
  process begin
    clk <= '1'; wait for 5 ns;
    clk <= '0'; wait for 5 ns;
  end process;

  -- Check the results
  process
    variable errors : integer := 0;

    procedure print_and_check(b_expected : std_logic; out_expected : std_logic) is
    begin
      write(output, to_string(valid_in) & "  | " & to_string(b_select) & "        | " & to_string(valid_out));
      if (b_select = b_expected) and (valid_out = out_expected) then
        write(output, " " & LF); -- All good!
      elsif (b_select = b_expected) then -- b_select matches, error must be with valid_out
        write(output, "   <--- Error, expected valid_out = " & to_string(out_expected) & LF);
        errors := errors + 1;
      else
        write(output, "   <--- Error, expected b_select = " & to_string(b_expected) & LF);
        errors := errors + 1;
      end if;
    end print_and_check;

  begin
    -- Let FSM self-initialize
    valid_in <= '0';
    wait for 50 ns;

    write(output, "in | b_select | valid_out" & LF);

    wait until falling_edge(clk);
    print_and_check('0', '0');

    valid_in <= '1';
    wait until falling_edge(clk);
    print_and_check('1', '0');

    valid_in <= '0';
    wait until falling_edge(clk);
    print_and_check('0', '1');

    wait until falling_edge(clk);
    print_and_check('0', '0');

    wait until falling_edge(clk);
    print_and_check('0', '0');

    -- Check that it works when valid is high on the cycle we finish one output
    valid_in <= '1';
    wait until falling_edge(clk);
    print_and_check('1', '0');

    valid_in <= '0';
    wait until falling_edge(clk);
    print_and_check('0', '1');

    valid_in <= '1';
    wait until falling_edge(clk);
    print_and_check('1', '0');

    valid_in <= '0';
    wait until falling_edge(clk);
    print_and_check('0', '1');

  
    if errors = 0 then
      write (output, "TEST PASSED." & LF);
    else
      write (output, "Test failed with " & to_string(errors) &  " errors." & LF);
    end if;
 
    std.env.finish; -- All done, but clock is still going

    wait;
  end process;
end test;

