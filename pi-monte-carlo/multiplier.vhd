library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
use ieee.std_logic_arith.all;

entity multiplier is
	generic (N: integer := 18);
	port (
		a		 : in std_logic_vector(N-1 downto 0);
		b		 : in std_logic_vector(N-1 downto 0);
		product: out std_logic_vector(N-1 downto 0)
	);
end entity;

architecture behaviour of multiplier is
    signal result: std_logic_vector(2*N-1 downto 0);
begin
	result <= signed(a) * signed(b);
    product <= result(2*N-1 downto N);
end architecture;
