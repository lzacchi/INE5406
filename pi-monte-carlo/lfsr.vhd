library ieee;
use ieee.std_logic_1164.all;

entity lfsr is
    generic(N: positive:= 18);
    port(
        reset: in  std_logic;
        clk: in  std_logic; 
        random : out std_logic_vector(N-1 downto 0)
    );
end entity;

architecture rtl of lfsr is
    signal lfsr       : std_logic_vector (N-2 downto 0);
    signal feedback  : std_logic;

begin
    -- option for LFSR size 4
    feedback <= not(lfsr(N-2) xor lfsr(N-3));  

    sr_pr : process (clk) 
    begin
        if (rising_edge(clk)) then
        if (reset = '1') then
            lfsr <= (others => '0');
        else
            lfsr <= lfsr(N-3 downto 0) & feedback;
        end if; 
        end if;
    end process sr_pr;

    random <= '0' & lfsr;
  
end architecture;