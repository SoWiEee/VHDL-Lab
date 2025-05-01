LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_unsigned.all;

ENTITY StepMotor IS
	PORT(
		clk	: in std_logic;
		step	: out std_logic_vector(3 downto 0)
	);
END StepMotor;

ARCHITECTURE arch OF StepMotor IS
	signal cnt : std_logic_vector(1 downto 0) := "00";
	signal clk_div   : std_logic := '0';
	signal div_count : integer range 0 to 479999 := 0;
	BEGIN
	-- clk div
	PROCESS(clk)
	BEGIN
	if rising_edge(clk) then
		if div_count = 479999 then
			div_count <= 0;
			clk_div <= not clk_div;
		else
			div_count <= div_count + 1;
		END if;
	END if;
	END PROCESS;
	
	-- motor state switch
	PROCESS(clk_div)
	BEGIN 
		if rising_edge(clk_div) then
			cnt <= cnt + 1;
		END if;
	END PROCESS;
	WITH cnt SELECT
		step <=  "1000" when "00",
					"0100" when "01",
					"0010" when "10",
					"0001" when others;

END arch;