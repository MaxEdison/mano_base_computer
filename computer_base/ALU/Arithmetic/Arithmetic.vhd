library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Arithmetic is 
    port(
        CLK     : in std_logic;
        Cin     : in std_logic;
        s       : in std_logic_vector(1 downto 0);
        input_1 : in std_logic_vector(15 downto 0);
        input_2 : in std_logic_vector(15 downto 0);
        Cout    : out std_logic;
        output  : out std_logic_vector(15 downto 0)
    );
end Arithmetic;

architecture bhv of Arithmetic is 
    signal temp_C : unsigned(16 downto 0);
    signal temp_out_m : unsigned(15 downto 0);
    signal temp_out_a : unsigned(15 downto 0);
    signal temp_not : unsigned(15 downto 0);
begin 
    temp_not <= unsigned(input_2);
    temp_C(0) <= Cin;
    gen_mux: for i in 0 to 15 generate
        MUX : entity work.mux_4to1
            port map (
                CLK => CLK, 
                I(0) => input_2(i), 
                I(1) => temp_not(i), 
                I(2) => '0', 
                I(3) => '1',
                S0 => s(0), 
                S1 => s(1), 
                z => temp_out_m(i)
            );
    end generate;

    gen_adder: for i in 0 to 15 generate
        FA : entity work.F_A
            port map (
                CLK => CLK, 
                A => input_1(i), 
                B => temp_out_m(i), 
                Cin => temp_C(i),
                S => temp_out_a(i), 
                Cout => temp_C(i+1)
            );
    end generate;
	
    output <= std_logic_vector(temp_out_a);
    Cout <= temp_C(15);
end bhv;

