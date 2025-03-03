library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

Entity Mul_3bits is
    port(
        A, B : in std_logic_vector(2 downto 0);
        P : out std_logic_vector(5 downto 0)
    );
end Mul_3bits;

Architecture Behavior of Mul_3bits is

begin
    P <= std_logic_vector(unsigned(A) * unsigned(B));
end Behavior;