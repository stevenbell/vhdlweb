library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity dddd is
  port(
    value : in unsigned(5 downto 0);    
    tensdigit : out std_logic_vector(6 downto 0);    
    onesdigit : out std_logic_vector(6 downto 0)
  );
end dddd;

architecture sim of dddd is

component sevenseg is
  port(
	  S : in unsigned(3 downto 0);
	  segments : out std_logic_vector(6 downto 0)
  );
end component;

signal lowBCD : unsigned(3 downto 0);
signal highBCD : unsigned(3 downto 0);
signal tensplace : unsigned(12 downto 0);
signal onesplace : unsigned(6 downto 0);

begin

  ones : sevenseg port map(lowBCD, onesdigit);
  tens : sevenseg port map(highBCD, tensdigit);

  -- Do the math to split up the digits. Input `value` is 6 bits
  lowBCD <= value mod 4d"10";
  -- Multiply by 52. Intermediate term is 13 bits
  tensplace <= value * to_unsigned(52, 7);
  -- Divide by 512 (2ˆ9). High digit result is 4 bit unsigned
  highBCD <= tensplace(12 downto 9);


end;

