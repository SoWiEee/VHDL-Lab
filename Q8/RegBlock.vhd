LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;

ENTITY RegBlock IS
	PORT(
		clk, seq, par, load	: in  std_logic;
		Q							: out std_logic
	);
END RegBlock;


ARCHITECTURE b OF RegBlock IS
BEGIN
	proc:
		PROCESS(clk) IS
		BEGIN 
			IF rising_edge(clk) then
            Q <= (seq and not(load)) or (par and load);
			END IF;
	END PROCESS proc;
END b;