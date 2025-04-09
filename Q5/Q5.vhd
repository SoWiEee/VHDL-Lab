LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
--use ieee.numeric_std.all;

ENTITY Q5 IS
	PORT(
		clk, X	:in std_logic;
		Q			:out std_logic_vector(2 downto 0)
	);
END Q5;


ARCHITECTURE Behavioral OF Q5 IS
		signal count : std_logic_vector(2 downto 0) := "000";	--state
BEGIN
	PROCESS(X, count)
	BEGIN
		if rising_edge(clk) then
			if X = '1' then
				-- switch
				CASE count is
					-- when <state> => ???
					when "000" => count <= "001";
					when "001" => count <= "011";
					when "011" => count <= "010";
					when "010" => count <= "110";
					when "110" => count <= "111";
					when "111" => count <= "101";
					when "101" => count <= "100";
					when others => count <= "000";
				END CASE;
			else
				CASE count is
					when "000" => count <= "100";
					when "100" => count <= "101";
					when "101" => count <= "111";
					when "111" => count <= "110";
					when "110" => count <= "010";
					when "010" => count <= "011";
					when "011" => count <= "001";
					when others => count <= "000";
            END CASE;
			END if;
			Q <= count;
		END if;
	END PROCESS;
END Behavioral;