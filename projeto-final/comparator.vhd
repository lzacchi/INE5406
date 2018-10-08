library ieee;
use ieee.std_logic_1164.all;

entity comparator is
    generic(N: integer := 18);
    port (
        a: in std_logic_vector(N-1 downto 0);
        b: in std_logic_vector(N-1 downto 0);
        comp_out: out std_logic
    );
end entity;

architecture behaviour of comparator is
begin
    comp_out <= '1' when ((a = b) or (a < b)) else '0';
end architecture;