LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;

ENTITY FA IS
	PORT(
		A, B 	 : in unsigned(2 downto 0);
		result : out unsigned(3 downto 0)
	);
END FA;


ARCHITECTURE b OF FA IS
BEGIN
	result <= ("0" & A) + ("0" & B);
END b;