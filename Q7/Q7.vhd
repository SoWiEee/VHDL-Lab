LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY Q7 IS
	PORT(
		input : in std_logic;
		clk	: in std_logic;
		Q		: out std_logic_vector(3 downto 0)
	);
END Q7;

ARCHITECTURE b OF Q7 IS
	COMPONENT D
		PORT(
			D	: in std_logic;
			clk: in std_logic;
			Q	: out std_logic
		);
	END COMPONENT;
	signal s: std_logic_vector(1 to 3);
	BEGIN
		DFF: for i in 0 to 3 GENERATE
			head: if i=0 GENERATE
				DD:D PORT MAP(
					D   => input,
					clk => clk,
					Q   => s(i+1)
				);
			END GENERATE;
			mid: if i>0 AND i<3 GENERATE
				DD:D PORT MAP(
					D   => s(i),
					clk => clk,
					Q   => s(i+1)
				);
			END GENERATE;
			tail: if i=3 GENERATE
				DD:D PORT MAP(
					D   => s(i),
					clk => clk,
					Q   => Q(3)
				);
			END GENERATE;
		END GENERATE;
	Q(0) <= s(1);
	Q(1) <= s(2);
	Q(2) <= s(3);
END b;