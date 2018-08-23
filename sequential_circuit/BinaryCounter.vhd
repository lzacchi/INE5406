library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity BinaryCounter is
	generic(N: positive := 8);
	port(
		clk, rst:in std_logic;
		enable, load, inc:in std_logic;
		d:in std_logic_vector(N-1 downto 0);
		q:out std_logic_vector(N-1 downto 0)
	);
end entity;

architecture canonicalform of BinaryCounter is
	subtype InternalState is unsigned(N-1 downto 0);
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
	next_state <= unsigned (d) 	  when load = '1' else
					  current_state 	  when enable = '0' else
					  current_state + 1 when inc = '1' else
					  current_state - 1;
	
	--output-logic
	q <= std_logic_vector(current_state);
end architecture;