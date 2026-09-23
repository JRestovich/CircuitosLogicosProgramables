library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity sumNb_tb is
end;

architecture sumNb_tb_arq of sumNb_tb is

	-- Declaracion de componente
	constant M : natural := 8;

	component sumNb is
		generic (
			N : natural := 4
		);
		port(
			a_i: in std_logic_vector(N-1 downto 0);
			b_i: in std_logic_vector(N-1 downto 0);
			ci_i: in std_logic;
			s_o: out std_logic_vector(N-1 downto 0);
			co_o: out std_logic
		);
	end component;
	
	-- Declaracion de senales de prueba
	signal a_tb: std_logic_vector(M-1 downto 0) := std_logic_vector(to_unsigned(1, M));
	signal b_tb: std_logic_vector(M-1 downto 0) := std_logic_vector(to_unsigned(0, M));
	signal ci_tb: std_logic := '0';
	signal s_tb: std_logic_vector(M-1 downto 0);
	signal co_tb: std_logic;

begin
	a_tb <= std_logic_vector(to_unsigned(6, M)) after 100 ns;
	b_tb <= std_logic_vector(to_unsigned(3, M)) after 200 ns;
	ci_tb <= '1'   after 300 ns;

	DUT: sumNb
		generic map (
			N => M
		)
		port map(
			a_i	 => a_tb, 
			b_i	 => b_tb,
			ci_i => ci_tb,
			s_o	 => s_tb,
			co_o => co_tb
		);
	
end;
