library IEEE;
use IEEE.std_logic_1164.all;
use std.textio.all;

entity test_findtt is
end test_findtt;

architecture sim of test_findtt is
component gene_findtt is
  port(
    clk : in std_logic;
    nuc_in : in std_logic_vector(1 downto 0); -- Input nucleotide
    nuc_out : out std_logic_vector(1 downto 0); -- Input nucleotide
    foundtt : out std_logic -- Whether the output nucleotide is a cytosine
  );
end component;

signal clk : std_logic;
signal nuc_in : std_logic_vector(1 downto 0) := "XX";
signal nuc_out : std_logic_vector(1 downto 0);
signal foundtt : std_logic;

constant NUC_A : std_logic_vector(1 downto 0) :=  "00";
constant NUC_T : std_logic_vector(1 downto 0) :=  "01";
constant NUC_G : std_logic_vector(1 downto 0) :=  "10";
constant NUC_C : std_logic_vector(1 downto 0) :=  "11";
constant MAX_DELAY : integer := 10;

begin

  -- DUT
  dut : gene_findtt port map(clk => clk, nuc_in => nuc_in, nuc_out => nuc_out, foundtt => foundtt);

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

    -- Delay counting
    variable delay : integer := 0;
    variable expected_delay : std_logic_vector(MAX_DELAY-1 downto 0);
    type NucChain is array(natural range <>) of std_logic_vector(1 downto 0);
    variable nuc_delay : NucChain(MAX_DELAY-1 downto 0);

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

      wait for 1 ns; -- HACK: wait for nuc_in to be assigned so we can use it below

      -- Shift all the bits down the delay chain
      expected_delay(MAX_DELAY-1 downto 1) := expected_delay(MAX_DELAY-2 downto 0);
      expected_delay(0) := expected;
      nuc_delay(MAX_DELAY-1 downto 1) := nuc_delay(MAX_DELAY-2 downto 0);
      nuc_delay(0) := nuc_in;

      -- Check the outputs once everything has settled
      -- Just before the next rising edge would be ideal, but after the falling
      -- edge works just as well.
      wait until falling_edge(clk);
      -- Eat unknown/invalid outputs; once we get something valid we can start checking
      if nuc_out = "XX" or nuc_out = "UU" then
        delay := delay + 1;
        if delay >= MAX_DELAY then
          report "Test failed: Design didn't produce valid nuc_out after " & to_string(MAX_DELAY) & " cycles." severity failure;

        end if;
        --report "Delay is now: " & to_string(delay) & " delay line: " & to_string(expected_delay);
      else
        check(foundtt = expected_delay(delay),
              "expected tt = " & to_string(expected_delay(delay)) & " but got " & to_string(foundtt));
        check(nuc_out = nuc_delay(delay),
              "expected nuc_out = " & to_string(nuc_delay(delay)) & " but got " & to_string(nuc_out));
      end if;

    end loop;

   if errors = 0 then
      write (output, "TEST PASSED." & LF);
    else
      write (output, "Test failed with " & to_string(errors) &  " errors." & LF);
    end if;

    std.env.finish; -- Forcefully end the simulation, since the clock is still going
 
  end process;

end;

