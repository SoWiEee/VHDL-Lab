LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY FA4B IS
	PORT(
		A, B	:in	std_logic_vector(3 downto 0);	-- A[4], B[4]
		Cin	:in	std_logic;
		Sum	:out	std_logic_vector(3 downto 0);	-- Sum[4]
		Carry	:out	std_logic
	);
END FA4B;


ARCHITECTURE Dataflow OF FA4B IS
	COMPONENT FA
		PORT(
			A, B, Cin	:in	std_logic;
			Cout, Sum	:out	std_logic
		);
	END COMPONENT;
	
	SIGNAL c : std_logic_vector(4 downto 0);	-- carry chain
	BEGIN
		c(0) <= Cin;
		Gen:	FOR i IN 3 downto 0 GENERATE
			FA_inst:	FA PORT MAP(
				A		=> A(i),
				B		=> B(i),
				Cin	=> c(i),
				Sum	=> Sum(i),
				Cout	=> c(i+1)
			);
		END GENERATE;
END Dataflow;