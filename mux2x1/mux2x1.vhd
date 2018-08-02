LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY mux2x1 IS
	PORT (
		A, B  : IN std_logic;
		C     : IN std_logic;
		Y     : OUT std_logic
	);
END ENTITY;

ARCHITECTURE arch1 OF mux2x1 IS
	SIGNAL entradas : std_logic_vector(2 DOWNTO 0);
BEGIN
	entradas <= A & B & C;
	WITH entradas SELECT
	Y <= '0' WHEN "000", 
	     '0' WHEN "001", 
	     '0' WHEN "010", 
	     '1' WHEN "011", 
	     '1' WHEN "100", 
	     '0' WHEN "101", 
	     '1' WHEN "110", 
	     '1' WHEN OTHERS;
END ARCHITECTURE;
 
ARCHITECTURE arch2 OF mux2x1 IS
	SIGNAL entradas : std_logic_vector(2 DOWNTO 0);
BEGIN
	entradas <= A & B & C;
	WITH entradas SELECT
	Y <= '0' WHEN "000" | "001" | "010" | "101", 
	     '1' WHEN OTHERS;
END ARCHITECTURE;

ARCHITECTURE arch3 OF mux2x1 IS
BEGIN
	Y <= A WHEN C = '0' ELSE B;
END ARCHITECTURE;

ARCHITECTURE arch4 OF mux2x1 IS
BEGIN
	PROCESS (A, B, C) IS
	BEGIN
		IF C = '0' THEN
			Y <= A;
		ELSE
			Y <= B;
		END IF;
	END PROCESS;
END ARCHITECTURE;
















