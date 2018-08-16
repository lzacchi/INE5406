LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_signed.all;

ENTITY adder IS
GENERIC (n: POSITIVE := 5);
PORT (a,b : IN STD_LOGIC_VECTOR(n -1  DOWNTO 0);
		sel : IN STD_LOGIC;
		overflow: out std_LOGIC;
		s	 : OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0)
);
END ENTITY;

ARCHITECTURE bhv OF adder IS
signal temp_a : std_LOGIC_VECTOR(n-1 downto 0);

BEGIN
	temp_a <= a when sel = '1' else NOT(a) + '1';
	s <= b + temp_a;
END ARCHITECTURE;
