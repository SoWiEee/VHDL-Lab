 LIBRARY IEEE;
 USE IEEE.std_logic_1164.all;
 USE ieee.numeric_std.all;

 ENTITY LookAheadAdder IS
    Port(
        A, B 	: in std_logic_vector(3 downto 0);
        Cin 	: in std_logic;
        S 		: out std_logic_vector(3 downto 0);
        Cout 	: out std_logic
    );
 END LookAheadAdder;

 Architecture Behavioral OF LookAheadAdder IS

 BEGIN
    process(A, B, Cin)
        variable Cg, Cp : std_logic_vector(3 downto 0);
        variable Cn	   : std_logic_vector(4 downto 0);
    BEGIN
        for i in 0 to 3 loop
            Cg(i) := A(i) and B(i);
            Cp(i) := A(i) xor B(i);
        END loop;
        
        Cn(0) := Cin;
        for i in 0 to 3 loop
            Cn(i+1) := Cg(i) or (Cp(i) and Cn(i));
        END loop;
        
        for i in 0 to 3 loop
            S(i) <= Cp(i) xor Cn(i);
        END loop;
        Cout <= Cn(4);
    END process;
 END Behavioral;