library ieee;
use ieee.std_logic_1164.all;

entity Register_Nbits is
	generic(N: positive := 8);
	port(
		clk, rst, enable: in std_logic;
		d: in std_logic_vector(N-1 downto 0);
		q: out std_logic_vector(N-1 downto 0)
	);
end entity;

architecture canonicalform of Register_Nbits is
	subtype InternalState is std_logic_vector(N-1 downto 0);
	signal next_state, current_state: InternalState;
begin
	--memory element
	process(clk, rst) is
	begin
		if rst = '1' then
			current_state <= (others => '0');
		elsif rising_edge(clk) then
			current_state <= next_state;
		end if;
	end process;
	
	--next state
	next_state <= d when enable = '1' else current_state;
	
	--output-logic
	q <= current_state;
end architecture;