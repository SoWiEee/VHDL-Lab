Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric.std.all;

-- 4-bit +-
Entity four_bit_adder_subtractor is 
    port(
        A, B : in std_logic_vector(3 downto 0);		-- 4-bit input
        Cin, Op : in std_logic;							-- Op: add/sub
        Sum : out std_logic_vector(3 downto 0);		-- 4-bit sum
        Cout : out std_logic                       -- carry output
    );
end four_bit_adder_subtractor;


Architecture Behavioral of four_bit_adder_subtractor is
begin
    process(A, B, Cin)
        variable SumUnsigned : unsigned(4 downto 0);  -- unsigned result (5-bit)
    begin
		  if Op = '1' then
            sumUnsigned <= ('0'&unsigned(A)) + ('0'&unsigned(B)) + ('0'&Cin);
        else
            sumUnsigned <= ('0'&unsigned(A)) - ('0'&unsigned(B)) - ('0'&Cin);
        end if;
		        Cout <= std_logic(sumUnsigned(4));  -- sumUnsigned[4] (MSB)
        sum <= std_logic_vector(sumUnsigned(3 downto 0));  -- sumUnsigned[3:0]
    end process;
end Behavioral;

