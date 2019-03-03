library IEEE;
use IEEE.std_logic_1164.all;

entity gene_findc is
  port(
    clk : in std_logic;
    nuc_in : in std_logic_vector(1 downto 0); -- Input nucleotide
    nuc_out : out std_logic_vector(1 downto 0); -- Input nucleotide
    is_c : out std_logic -- Whether the output nucleotide is a cytosine
  );
end;

architecture synth of gene_findc is
begin
  -- We don't even have to clock this...
  nuc_out <= nuc_in;
  is_c <= '1' when (nuc_in = "11") else '0';
end;

