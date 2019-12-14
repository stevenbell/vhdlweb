library IEEE;
use IEEE.std_logic_1164.all;
use std.textio.all;

entity test_findc is
end test_findc;

architecture sim of test_findc is
component gene_findc is
  port(
    clk : in std_logic;
    nuc_in : in std_logic_vector(1 downto 0); -- Input nucleotide
    nuc_out : out std_logic_vector(1 downto 0); -- Input nucleotide
    foundC : out std_logic -- Whether the output nucleotide is a cytosine
  );
end component;

signal clk : std_logic;
signal nuc_in : std_logic_vector(1 downto 0);
signal nuc_out : std_logic_vector(1 downto 0);
signal foundC : std_logic;

constant NUC_A : std_logic_vector(1 downto 0) :=  "00";
constant NUC_T : std_logic_vector(1 downto 0) :=  "01";
constant NUC_G : std_logic_vector(1 downto 0) :=  "10";
constant NUC_C : std_logic_vector(1 downto 0) :=  "11";

begin

  -- DUT
  dut : gene_findc port map(clk => clk, nuc_in => nuc_in, nuc_out => nuc_out, foundC => foundC);

  -- 100MHz clock generation
  process begin
    clk <= '1'; wait for 5 ns;
    clk <= '0'; wait for 5 ns;
  end process;

  -- Run tests from file
  process is
    -- Variables for reading the test vector file
    file tv : text;
    variable l : line;
    variable nuc : character;
    variable separator : character;
    variable expected : std_logic;

    -- Error counting
    variable errors : integer := 0;

    procedure check(condition : boolean; message : string) is
    begin
      if not condition then
        report message severity error;
        errors := errors + 1;
      end if;
    end check;

  begin
    report "Test started";
    FILE_OPEN(tv, "testvectors.txt", READ_MODE);

    while not endfile(tv) loop

      -- Change the inputs slightly after the rising edge
      -- This is as if the inputs are driven by the same clock, with some delay
      wait until rising_edge(clk); wait for 1 ns;
      readline(tv, l);
      read(l, nuc); -- Should be one of GCAT
      read(l, separator); -- Eat the underscore
      read(l, expected); -- Should be 1 or 0

      case nuc is
        when 'A' => nuc_in <= NUC_A;
        when 'T' => nuc_in <= NUC_T;
        when 'G' => nuc_in <= NUC_G;
        when 'C' => nuc_in <= NUC_C;
        when others => report "Malformed genome file, encountered " & to_string(nuc);
      end case;

      -- Check the outputs once everything has settled
      -- Just before the next rising edge would be ideal, but after the falling
      -- edge works just as well.
      wait until falling_edge(clk);
      check(foundC = expected, "expected " & to_string(expected) & " but got " & to_string(foundC));

    end loop;

    if errors = 0 then
      report "Test passed.";
    else
      report "Test failed with " & to_string(errors) & " errors.";
    end if;
    wait;
  end process;

end;

