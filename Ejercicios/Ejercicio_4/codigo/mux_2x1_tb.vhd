library IEEE;
use IEEE.std_logic_1164.all;

entity mux_2x1_tb is
end;

architecture mux_2x1_tb_arq of mux_2x1_tb is

	-- Declaracion de componente
	component mux_2x1 is
		port(
			a_i: in std_logic;
			b_i: in std_logic;
			sel_i: in std_logic;
			s_o: out std_logic
		);
	end component;
	
	-- Declaracion de senales de prueba
	signal a_tb: std_logic := '0';
	signal b_tb: std_logic := '0';
	signal sel_tb: std_logic := '0';
	signal s_tb: std_logic;

begin

	a_tb <= '1' after 100 ns, '0' after 350 ns;
	b_tb <= '0' after 200 ns, '1' after 300 ns;
	sel_tb <= '1' after 50 ns, '0' after 250 ns;
	-- a_tb <= not a_tb after 10 ns;
	-- b_tb <= not b_tb after 20 ns;
	-- ci_tb <= not ci_tb after 40 ns;

	DUT: mux_2x1
		port map(
			a_i	 => a_tb, 
			b_i	 => b_tb,
			sel_i => sel_tb,
			s_o	 => s_tb
		);
	
end;
