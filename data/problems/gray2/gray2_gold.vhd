library IEEE;
use IEEE.std_logic_1164.all;

entity gray2 is
  port(
	  clk : in std_logic;
	  reset : in std_logic;
	  count : out std_logic_vector(1 downto 0)
  );
end gray2;

architecture synth of gray2 is
begin
  process(clk) is
  begin
    if rising_edge(clk) then
      if reset then
        count <= "00";
      else
        case count is
          when "00" => count <= "01";
          when "01" => count <= "11";
          when "11" => count <= "10";
          when "10" => count <= "00";
          when others => count <= "00";
        end case;
      end if;
    end if;
  end process;
end;

