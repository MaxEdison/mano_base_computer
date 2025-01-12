library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity AC_rej is
	port(
		R :in std_logic;
		E :in std_logic;
		I :in std_logic;
		D :in std_logic_vector(7 downto 0);
		T :in std_logic_vector(7 downto 0);
		IR :in std_logic_vector(15 downto 0);
		DR :in std_logic_vector(15 downto 0);
		CLK :in std_logic;
		AC_in :in std_logic_vector(15 downto 0);
		AC_out :out std_logic_vector(15 downto 0)
		);
end AC_rej;

architecture bhv of AC_rej is
	signal temp: std_logic_vector(15 downto 0);
	signal temp_1 : unsigned(15 downto 0);
	signal rr : std_logic;
	signal p : std_logic;
begin 
	process(CLK)
	begin

	if (rising_edge(CLK)) then 
		rr <= (D(7) and not(I) and T(3));
		p <= (D(7) and I and T(3));
		if (D(0)='1' and T(5)='1') or (D(1)='1' and T(5)='1') or (D(2)='1' and T(5)='1') or (p='1' and IR(11)='1')
			or (rr='1' and IR(9)='1') or (rr='1' and IR(7)='1') or (rr='1' and IR(6)='1') then 
				temp <= AC_in;
			elsif (rr='1' and IR(5)='1')  then 
				temp_1 <= unsigned(AC_in);
				temp <= std_logic_vector(temp_1 + "0000000000000001");
			elsif (rr='1' and IR(11)='1') then 
				temp <= (others => '0');
			end if;
	end if;
	end process;
	AC_out <= temp;
end bhv;
