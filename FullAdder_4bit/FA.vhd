LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY FA IS
	PORT(
		A, B, Cin	:in	std_logic;
		Cout, Sum	:out	std_logic
	);
END FA;


ARCHITECTURE Dataflow OF FA IS
	BEGIN
		Cout <= (A and B) or ((A xor B) and Cin);
		Sum <= A xor B xor Cin;
END Dataflow;