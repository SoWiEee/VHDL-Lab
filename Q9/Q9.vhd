LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY Q9 IS
	PORT(
		input	: in std_logic_vector(4 downto 0);
		output: out std_logic_vector(2 downto 0)
	);
END Q9;

ARCHITECTURE b OF Q9 IS
-- function call
FUNCTION FN1(F:std_logic_vector(3 downto 0)) return std_logic IS
	VARIABLE temp	: std_logic;
BEGIN
	temp := ((f(0) xor f(1)) xor (f(2) xor f(3))); 
	RETURN temp;
END FN1;

BEGIN
	PROCESS(input)
	BEGIN
		output(0) <= input(4) xor FN1(input(3 downto 0));
		output(1) <= input(4) xor FN1(input(3 downto 0));
		output(2) <= input(4) xor FN1(input(3 downto 0));
	END PROCESS;
END b;