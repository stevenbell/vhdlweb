--  Testbench for M > N just like lab 2
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use std.textio.all;

entity lab2_test is
-- No ports, since this is a testbench
end lab2_test;

architecture test of lab2_test is

component lab2 is
  port(
    m : in std_logic_vector(1 downto 0);
    n : in std_logic_vector(1 downto 0);
    y : out std_logic
  );
end component;

signal m : unsigned(1 downto 0);
signal n : unsigned(1 downto 0);
signal y : std_logic;

begin

  dut : lab2 port map(std_logic_vector(m), std_logic_vector(n), y);

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

    variable correct : std_logic;

  begin

    for mi in 0 to 3 loop
      for ni in 0 to 3 loop
        m <= to_unsigned(mi, 2);
        n <= to_unsigned(ni, 2);

        if mi > ni then
          correct := '1';
        else
          correct := '0';
        end if;

        wait for 10 ns;

        -- write(l, "Reporting for M = " & to_string(m) & " and N = " & to_string(n) & ", should be " & to_string(correct) & ", got " & to_string(y) & LF);

        check(y = correct, "Incorrect for M = " & to_string(m) & " and N = " & to_string(n) & ", should be " & to_string(correct) & " but got " & to_string(y));

      end loop;
    end loop;

    
    if errors = 0 then
      write(l, String'("Test passed."));
    else
      write (l, String'("Test failed with "));
      write (l, errors);
      write (l, String'(" errors."));
    end if;
    writeline (output, l);
    wait;
  end process;
end test;

