LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;

ENTITY Q6 IS
	PORT(
		A, B	: in unsigned(2 downto 0);
		result: out unsigned(5 downto 0)
	);
END Q6;


ARCHITECTURE b OF Q6 IS
	COMPONENT FA IS
		PORT(
			A, B	: in  unsigned(2 downto 0);
			result: out unsigned(3 downto 0)
		);
	END COMPONENT;
	signal b0, b1, b2 : unsigned(2 downto 0);	-- Vector for each bit in B
	signal add_1 : unsigned(3 downto 0);		-- Layer 1 adding result

BEGIN
   -- Generate a three bits long vector for each bit in B
	b0 <= (others => B(0));
	b1 <= (others => B(1));
	b2 <= (others => B(2));
	
	-- Layer 1
	result(0) <= B(0) and A(0);
	Add1: FA port map("0" & b0(2 downto 1) and A(2 downto 1), A and b1, add_1);
	
	-- Layer 2
	result(1) <= add_1(0);
   Add2: FA port map(add_1(3 downto 1), A and b2, result(5 downto 2));
END b;