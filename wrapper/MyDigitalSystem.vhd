library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MyDigitalSystem is
	generic(width: positive := 32);
	port(
		clock, reset: in std_logic;
		start: in std_logic;
		dataIn: in std_logic_vector(width-1 downto 0);
		dataOut: out std_logic_vector(width-1 downto 0);
		done: out std_logic
	);
end entity;

architecture a1 of MyDigitalSystem is
	subtype InternalState is unsigned(width-1 downto 0);
	signal currentState, nextState: InternalState;
begin
	nextState <= currentState when start='0' else 
					unsigned(dataIn)+1;
					
	process(clock, reset) is
	begin
		if reset='1' then
			currentState <= (others=>'0');
		elsif rising_edge(clock) then
			currentState <= nextState;
		end if;
	end process;

	dataOut <= std_logic_vector(currentState);
	done <= '1' when to_integer(currentState)=16 else '0';
end architecture;







