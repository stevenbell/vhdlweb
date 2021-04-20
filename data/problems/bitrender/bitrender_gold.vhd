library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity bitrender is
  port(
    clk : in std_logic;
    row : in unsigned(2 downto 0); -- vertical position, 0 to 7
    col : in unsigned(5 downto 0); -- horizontal position, 0 to 63
    pixel : out std_logic
  );
end;

architecture synth of bitrender is

component rom is
  port(
    clk : in std_logic;
    addr : in std_logic_vector(5 downto 0); -- 64 words total
    data : out std_logic_vector(7 downto 0) -- 8-bit words
  );
end component;

signal addr : std_logic_vector(5 downto 0);
signal data : std_logic_vector(7 downto 0); -- Memory has 8-bit words

begin

  myrom : rom port map(clk, addr, data);

  addr <= std_logic_vector(row) & std_logic_vector(col(5 downto 3));

  pixel <= data(7 - to_integer(col(2 downto 0)));
end;

