--  Testbench for 8-bit shift register
library IEEE;
use IEEE.std_logic_1164.all;
use std.textio.all;

entity gene_protein_test is
-- No ports, since this is a testbench
end gene_protein_test;

architecture test of gene_protein_test is

component gene_protein is
  port(
    clk : in std_logic;
    nuc_in : in std_logic_vector(1 downto 0);
    nuc_out : out std_logic_vector(1 downto 0);
    is_protein : out std_logic
  );
end component;

signal clk : std_logic;
signal nuc_in : std_logic_vector(1 downto 0);
signal nuc_out : std_logic_vector(1 downto 0);
signal is_protein : std_logic;

begin

  myreg : gene_protein port map(clk, nuc_in, nuc_out, is_protein);

  process begin

    write (output, "The test for this problem has not been completed yet." & LF);

    wait;
  end process;

end; -- of architecture

