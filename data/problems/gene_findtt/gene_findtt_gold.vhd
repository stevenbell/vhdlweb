library IEEE;
use IEEE.std_logic_1164.all;

entity gene_findtt is
  port(
    clk : in std_logic;
    nuc_in : in std_logic_vector(1 downto 0); -- Input nucleotide
    nuc_out : out std_logic_vector(1 downto 0); -- Input nucleotide
    foundtt : out std_logic -- Whether the output nucleotide is a cytosine
  );
end;

architecture synth of gene_findtt is
constant NUC_T : std_logic_vector(1 downto 0) :=  "01";

signal double : std_logic; -- Only need 1 bit of state
begin

  process (clk) is
  begin
    if rising_edge(clk) then
      -- If we enountered a second T, then we need to go into "double" mode
      if (nuc_out = NUC_T) and (nuc_in = NUC_T) then
        double <= '1';
      else -- nuc_in must not be a T, time to leave double mode
        double <= '0';
      end if;
      nuc_out <= nuc_in;
    end if;
  end process;

  foundtt <= '1' when ((nuc_in = NUC_T) and (nuc_out = NUC_T)) or (double = '1') else '0';

end;
