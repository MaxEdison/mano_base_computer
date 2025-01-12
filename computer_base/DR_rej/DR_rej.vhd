library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity DR_rej is
	port(
		R :in std_logic;
		I :in std_logic;
		D :in std_logic_vector(7 downto 0);
		T :in std_logic_vector(7 downto 0);
		CLK :in std_logic;
		DR_in :in std_logic_vector(15 downto 0);
		DR_out :out std_logic_vector(15 downto 0)
		);
end DR_rej;

architecture bhv of DR_rej is
	signal temp: std_logic_vector(15 downto 0);
	signal temp_1: unsigned(15 downto 0);
begin 
	process(CLK)
	begin
	if (rising_edge(CLK)) then 
		if (D(0)='1' and T(4)='1') or (D(1)='1' and T(4)='1') or (D(2)='1' and T(4)='1') or (D(6)='1' and T(4)='1') then 
			temp <= DR_in;
		elsif (D(6)='1' and T(4)='1') then 
			temp_1 <= unsigned(DR_in);
			temp <= std_logic_vector(temp_1 + 1);
		end if;
	end if;
	end process;
	DR_out <= temp;
end bhv;
