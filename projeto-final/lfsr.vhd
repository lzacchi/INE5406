library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.math_real.all;
use ieee.numeric_std.all;

entity lfsr is
    generic (N: positive := 18);
    port(
        clock, reset: in std_logic;
        iterations  : in std_logic_vector(N-1 downto 0);
        random_no   : out std_logic_vector(N-1 downto 0)
    );
end entity;

--architecture behaviour of lfsr is
  --  signal lfsr    : std_logic_vector (N-1 downto 0);
    --signal feedback: std_logic;
--begin
    --OPTION
  --  feedback <= not(lfsr(3) xor lfsr(2));
    
   -- sr_process: process (clock)
   -- begin
     --   if (rising_edge(clock)) then
       --     if (reset = '1') then
         --       lfsr <= (others => '0');
           -- else 
             --   lfsr <= std_logic_vector(unsigned(lfsr(16 downto 0) & feedback)/unsigned(iterations));
            --end if;
        --end if;
    --end process sr_process;
    
--    random_no <= lfsr;
        
--end architecture;