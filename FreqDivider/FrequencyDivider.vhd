Library IEEE;
USE IEEE.std_logic_1164.all;


ENTITY FrequencyDivider IS
	Port(
		clk_in		:in std_logic;
		clk_div2		:out std_logic;
		clk_div4		:out std_logic;
		clk_div8		:out std_logic;
		clk_div16	:out std_logic
	);
END FrequencyDivider;


ARCHITECTURE Behavioral OF FrequencyDivider IS
	signal q2, q4, q8, q16 : std_logic := '0';	-- trigger signal
	BEGIN
		process(clk_in)
		 begin
			  if rising_edge(clk_in) then
					q2  <= not q2;
					q4  <= q4 xor q2;
					q8  <= q8 xor q4;
					q16 <= q16 xor q8;
			  end if;
		end process;
		
		clk_div2  <= q2;
		clk_div4  <= q4;
		clk_div8  <= q8;
		clk_div16 <= q16;
END Behavioral;
