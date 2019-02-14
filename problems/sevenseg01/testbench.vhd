--  Testbench for AB+!BC
library IEEE;
use IEEE.std_logic_1164.all;
use std.textio.all;

entity sevenseg01_test is
-- No ports, since this is a testbench
end sevenseg01_test;

architecture test of sevenseg01_test is

component sevenseg01 is
  port(
	  S : in std_logic;
	  segments : out std_logic_vector(6 downto 0)
  );
end component;

signal S : std_logic;
signal segments : std_logic_vector(6 downto 0);

begin

  dut : sevenseg01 port map(S, segments);

  process
    variable errors : integer := 0;
    variable l : line; -- For y text

    -- Function
    procedure check(condition : boolean; message : string) is
    begin
      if not condition then
        report message;
        errors := errors + 1;
      end if;
    end check;

  begin

    write(l, String'("This test is still under construction"));
    writeline (output, l);
    wait;
  end process;
end test;

