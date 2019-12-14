library IEEE;
use IEEE.std_logic_1164.all;

entity gene_find_tryp is
  port(
    clk : in std_logic;
    nuc_in : in std_logic_vector(1 downto 0); -- Input nucleotide
    nuc_out : out std_logic_vector(1 downto 0); -- Input nucleotide
    tryp : out std_logic -- Whether the output nucleotide is a cytosine
  );
end;

architecture synth of gene_find_tryp is

constant NUC_A : std_logic_vector(1 downto 0) :=  "00";
constant NUC_T : std_logic_vector(1 downto 0) :=  "01";
constant NUC_G : std_logic_vector(1 downto 0) :=  "10";
constant NUC_C : std_logic_vector(1 downto 0) :=  "11";

type State is (NONE, T, TG, TGG);
signal s : State;

begin
  nuc_out <= nuc_in;

  process (clk) is
  begin
    if rising_edge(clk) then
      case s is
        when NONE =>
          if nuc_in = NUC_T then
            s <= T;
          else
            s <= NONE;
          end if;
        when T =>
          if nuc_in = NUC_G then
            s <= TG;
          elsif nuc_in = NUC_T then
            s <= T;
          else
            s <= NONE;
          end if;
        when TG =>
          if nuc_in = NUC_G then
            s <= TGG;
          elsif nuc_in = NUC_T then
            s <= T;
          else
            s <= NONE;
          end if;
        when TGG =>
          if nuc_in = NUC_T then
            s <= T;
          else
            s <= NONE;
          end if;
        when others => s <= NONE;
      end case;
    end if;
  end process;

  tryp <= '1' when s = TGG else '0';
end;

