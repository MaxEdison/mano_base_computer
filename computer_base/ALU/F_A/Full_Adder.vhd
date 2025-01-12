library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity F_A is
 Port ( 
	CLK : in STD_LOGIC;
	A : in STD_LOGIC;
	B : in STD_LOGIC;
	Cin : in STD_LOGIC;
	S : out STD_LOGIC;
	Cout : out STD_LOGIC);
end F_A;

architecture gate_level of F_A is

	begin
	process(CLK)
	begin
	if rising_edge(CLK) then
		S <= A XOR B XOR Cin ;
		Cout <= (A AND B) OR (Cin AND A) OR (Cin AND B) ;
	end if;
	end process;
end gate_level;