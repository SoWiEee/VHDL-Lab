LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;

ENTITY Q8 IS
	PORT(
		clk, serial, load	: in std_logic;
		parallel				: in  std_logic_vector(3 downto 0);
		Q						: out  std_logic_vector(3 downto 0)
	);
END Q8;


ARCHITECTURE b OF Q8 IS
	-- Component
	COMPONENT RegBlock  IS
		PORT(
			clk, seq, par, load	: in std_logic;
			Q							: out std_logic
		
		);
	END COMPONENT;
	-- Links for serial input for each block
	signal links : std_logic_vector(4 downto 0);
    
BEGIN
	-- Link the serial input for each block
	links(0) <= serial;
	
	-- 4 register blocks
	Chain: FOR i IN 0 TO 3 GENERATE
		RB: RegBlock  PORT MAP(
				clk, links(i), parallel(i), load, links(i + 1)
		);
	END GENERATE;
	
	Q <= links(4 downto 1);
END b;