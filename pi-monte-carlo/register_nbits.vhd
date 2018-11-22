LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity register_nbits is
	generic (N: positive := 18);
	port (
		--control inputs
		clk, reset, enable: in std_logic;
		--data inputs
		input: in std_logic_vector(N - 1 downto 0);
		--data outputs
		output: out std_logic_vector(N-1 downto 0)
	);
end entity;

architecture behaviour of register_nbits is
	subtype internal_state is std_logic_vector(N - 1 downto 0);
	signal next_state, current_state: internal_state;
	
begin
	--next state logic
	next_state <= input when enable = '1';
	
	--memory element (sequential)
	ME: process (clk, reset) is
	begin
		if reset = '1' then
			current_state <= (others=>'0'); --reset state
		elsif rising_edge(clk) then
			current_state <= next_state;
		end if;
	end process;
	
	--output logic
	output <= current_state;
end architecture;