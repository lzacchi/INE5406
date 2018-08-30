library ieee;
use ieee.std_logic_1164.all;

entity FSM is
	generic(N: positive := 8);
	port(
		clk, rst: in std_logic;
		SA, SF, OB, CR: in std_logic;
		MT: out std_logic_vector(1 downto 0)
		);
end entity;

architecture canonicalform of FSM is
	type InternalState is (FECHANDO, FECHADO, ABRINDO, ABERTO);
	signal next_state, current_state: InternalState;
begin
	--memory element
	process(clk, rst) is
	begin
		if rst = '1' then
			current_state <= FECHANDO;
		elsif rising_edge(clk) then
			current_state <= next_state;
		end if;
	end process;
	
	--next state
	--next_state <= ABERTO when (current_state=ABERTO and CR='0') or (current_state=ABRINDO);
		--			  ABRINDO when (current_state)
		
	NSL: process(current_state, SA, SF, OB, CR) is
	begin
		next_state <= current_state;
		case current_state is
			when FECHANDO =>
				if OB='1' then
					next_state <= ABRINDO;
				elsif SF='1' then
					next_state <= FECHADO;
				end if;
				
			when FECHADO =>
				if CR='1' then
						next_state <= ABRINDO;
				end if;
			when ABRINDO =>
				if SA = '1' then
					next_state <= ABERTO;
				else
					next_state <= ABRINDO;
				end if;
			
			when ABERTO =>
				if CR='1' then
					next_state <= FECHANDO;
				end if;
		end case;
	end process;
		
	--output-logic
--	MT <= "01" when current_state=ABRINDO else
--			"10" when current_state=FECHANDO else
--			"00";

	OL: process(current_state, SA, SF, OB, CR) is
	begin
		A = '0';
		B = '0';
		
	
		next_state <= current_state;
		case current_state is
			when FECHANDO =>
				
			when FECHADO =>

			when ABRINDO =>
			
			when ABERTO =>
				end if;
		end case;
	end process;
end architecture;
































