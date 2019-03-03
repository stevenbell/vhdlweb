--  Testbench for 8-bit shift register
library IEEE;
use IEEE.std_logic_1164.all;
use std.textio.all;

entity gene_findtt_test is
-- No ports, since this is a testbench
end gene_findtt_test;

architecture test of gene_findtt_test is

component gene_findtt is
  port(
    clk : in std_logic;
    nuc_in : in std_logic_vector(1 downto 0);
    nuc_out : out std_logic_vector(1 downto 0);
    is_double : out std_logic
  );
end component;

signal clk : std_logic;
signal nuc_in : std_logic_vector(1 downto 0);
signal nuc_out : std_logic_vector(1 downto 0);
signal is_double : std_logic;

begin

  myreg : gene_findtt port map(clk, nuc_in, nuc_out, is_double);

  process
    variable buf : line;
  begin

    write(buf, string'("Test under construction"));
    writeline(output, buf);

    wait;
  end process;

end; -- of architecture

