library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU is 
	port(
		CLK :in std_logic;
		Cin :in std_logic;
		s :in std_logic_vector(3 downto 0);
		input_1 :in std_logic_vector(15 downto 0);
		input_2 :in std_logic_vector(15 downto 0);
		Cout :out std_logic;
		output :out std_logic_vector(15 downto 0)
		);
end ALU;

architecture bhv of ALU is
	signal temp :std_logic_vector(15 downto 0);
	signal temp_Arth :std_logic_vector(15 downto 0);
	signal temp_Log :std_logic_vector(15 downto 0);
begin 
	A : entity work.Arithmetic port map
		(CLK => CLK, Cin => Cin, s => s(1 downto 0), input_1 => input_1, input_2 => input_2, Cout => Cout,output => temp_Arth);
	L : entity work.Logic port map 
		(CLK => CLK, s => s(1 downto 0),input_1 => input_1, input_2 => input_2,output => temp_Log);
	process(CLK)
	begin 
		if rising_edge(CLK) then 
			if s(3 downto 2) = "00" then 
				temp <= temp_Arth;
			elsif s(3 downto 2) = "01" then			
				temp <= temp_Log;
			elsif s(3 downto 2) = "10" then
				temp <= std_logic_vector(shift_right(unsigned(input_1),1));
			elsif s(3 downto 2) = "11" then 
				temp <= std_logic_vector(shift_left(unsigned(input_1),1));
			end if;
		end if;
	end process;
	output <= temp;
end bhv;

	