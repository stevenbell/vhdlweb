--  Testbench for AB+!BC
library IEEE;
use IEEE.std_logic_1164.all;
use std.textio.all;

entity dff_test is
-- No ports, since this is a testbench
end dff_test;

architecture test of dff_test is

component dff is
  port(
	  d : in std_logic;
	  clk : in std_logic;
	  q : out std_logic
  );
end component;


signal d : std_logic;
signal clk : std_logic;
signal q : std_logic;

begin

  dut : dff port map(d, clk, q);

  process
    variable errors : integer := 0;

    -- Function
    procedure check(condition : boolean; message : string) is
    begin
      if not condition then
        report message;
        errors := errors + 1;
      end if;
    end check;


  begin

    -- Check that the output is low after a rising clock edge
    d <= '0';
    clk <= '0';
    wait for 10 ns;

    clk <= '1';
    wait for 10 ns;
    check(q = '0', "Output not 0 after rising edge");

    -- Check that the output is high after a rising clock edge
    clk <= '0';
    d <= '1';
    wait for 10 ns;

    clk <= '1';
    wait for 10 ns;
    check(q = '1', "Output not 1 after rising edge");

    -- Check that the output doesn't change while clk is high (e.g., a latch)
    d <= '0';
    wait for 10 ns;
    check(q = '1', "Output changed while clk was high!");

    -- Check that the output doesn't change on falling edge
    clk <= '0';
    wait for 10 ns;
    check(q = '1', "Output changed on falling edge!");

    
    if errors = 0 then
      write(output, "Test passed." & LF);
    else
      write(output, "Test failed with " & to_string(errors) & " errors." & LF);
    end if;
    wait;
  end process;
end test;

