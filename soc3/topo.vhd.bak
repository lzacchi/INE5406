library ieee;
use ieee.std_logic_1164.all;

entity nios2_project_wrapper_DE2 is
	port (
		CLOCK_50: in std_logic;
		LEDG: out std_logic_vector(7 downto 0)
	);
end entity;

architecture vhdltop of nios2_project_wrapper_DE2 is
	component first_nios2_system is
		port (
			clk_clk: in std_logic := 'X';
			reset_reset_n: in std_logic := 'X';
			led_pio_external_connection_export: out std_logic_vector(7 downto 0)
		);
	end component;
begin
	u0: component first_nios2_system
		port map(
			clk_clk => CLOCK_50,
			reset_reset_n => '1',
			led_pio_external_connection_export => LEDG
		);
end architecture;
		