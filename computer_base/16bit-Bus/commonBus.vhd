library IEEE;
use ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;

entity mux_array is
    Port (
        sel  : out  STD_LOGIC_VECTOR (2 downto 0);
        A   : in  STD_LOGIC_VECTOR (15 downto 0);
        B   : in  STD_LOGIC_VECTOR (15 downto 0);
        C   : in  STD_LOGIC_VECTOR (15 downto 0);
        D   : in  STD_LOGIC_VECTOR (15 downto 0);
        E   : in  STD_LOGIC_VECTOR (15 downto 0);
        F   : in  STD_LOGIC_VECTOR (15 downto 0);
        G   : in  STD_LOGIC_VECTOR (15 downto 0);
        H   : in  STD_LOGIC_VECTOR (15 downto 0);
        o    : out  STD_LOGIC_VECTOR (15 downto 0);
        clk  : in STD_LOGIC;
        DD  : in STD_LOGIC_VECTOR (7 downto 0);
        T   : in STD_LOGIC_VECTOR (7 downto 0);
        R   : in STD_LOGIC;
        I   : in STD_LOGIC
    );
end mux_array;

architecture Behavioral of mux_array is
    signal sel_internal : STD_LOGIC_VECTOR(2 downto 0);

    component mux_8to1
        Port (
            sel : in  STD_LOGIC_VECTOR (2 downto 0);
            i   : in  STD_LOGIC_VECTOR (7 downto 0);
            o   : out  STD_LOGIC
        );
    end component;

begin
    process(clk)
    begin
        if rising_edge(clk) then
            if (DD(5) = '1' and T(5) = '1') or (DD(4) = '1' and T(4) = '1') then
                sel_internal <= "001";
            elsif (T(0) = '1') or (DD(5) = '1' and T(5) = '1') then
                sel_internal <= "010";
            elsif (DD(2) = '1' and T(5) = '1') or (DD(6) = '1' and T(6) = '1') then
                sel_internal <= "011";
            elsif DD(3) = '1' and T(4) = '1' then
                sel_internal <= "100";
            elsif (not R = '1') and T(2) = '1' then
                sel_internal <= "101";
            elsif R = '1' and T(1) = '1' then
                sel_internal <= "110";
            elsif (not R = '1' and T(1) = '1') or (not DD(2) = '1' and I = '1' and T(3) = '1') or 
                  (DD(0) = '1' and (T(4) = '1' or T(1) = '1')) or (T(4) = '1' and (DD(2) = '1' or DD(6) = '1')) then
                sel_internal <= "111";
            end if;
        end if;
    end process;



    gen_mux: for j in 0 to 15 generate
        mux_inst: mux_8to1 port map (
            sel => sel_internal,
	    i(0) => A(j), i(1) => B(j), i(2) => C(j), i(3) => D(j), i(4) => E(j), i(5) => F(j), i(6) => G(j), i(7) => H(j),
            o   => o(j)
        );
    end generate;

end Behavioral;

