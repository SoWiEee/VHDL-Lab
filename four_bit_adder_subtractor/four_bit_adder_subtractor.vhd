LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

-- 4b adder/suber --
ENTITY AddSuber IS
	Port(
		Op, Cin: in std_logic;
		A, B: in std_logic_vector(3 downto 0);
		S: out std_logic_vector(3 downto 0);
		Cout: out std_logic
	);
END AddSuber;

ARCHITECTURE Behavioral OF AddSuber IS
begin
	process(A, B, Cin, Op)
		variable SumUnsigned : unsigned(4 downto 0);	-- result
	begin
		if Op = '1' then
			-- add
			sumUnsigned := ('0'&unsigned(A)) + ('0'&unsigned(B)) + ('0'&Cin);
	  else
			-- sub
			sumUnsigned := ('0'&unsigned(A)) - ('0'&unsigned(B)) - ('0'&Cin);
	  end if;
			  
	  Cout <= std_logic(sumUnsigned(4));
	  S <= std_logic_vector(sumUnsigned(3 downto 0));
	end process;
end Behavioral;
