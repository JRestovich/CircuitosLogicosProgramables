library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity sum_rest_Nb_tb is
end;

architecture sum_rest_Nb_arq of sum_rest_Nb_tb is

	-- Declaracion de componente
	constant M : natural := 8;

	component sum_rest_Nb is
		generic (
			N : natural := 4
		);
		port(
			a_i: in std_logic_vector(N-1 downto 0);
			b_i: in std_logic_vector(N-1 downto 0);
			s_o: out std_logic_vector(N-1 downto 0);
			co_o: out std_logic;
			op_i: in std_logic
		);
	end component;
	
	-- Declaracion de senales de prueba
	signal a_tb: std_logic_vector(M-1 downto 0) := std_logic_vector(to_unsigned(1, M));
	signal b_tb: std_logic_vector(M-1 downto 0) := std_logic_vector(to_unsigned(0, M));
	signal op_tb: std_logic := '0';
	signal s_tb: std_logic_vector(M-1 downto 0);
	signal co_tb: std_logic;

begin
	a_tb <= std_logic_vector(to_unsigned(6, M)) after 100 ns;
	b_tb <= std_logic_vector(to_unsigned(3, M)) after 200 ns, std_logic_vector(to_unsigned(7, M)) after 300 ns;
	op_tb <= '1'   after 300 ns;

	DUT: sum_rest_Nb
		generic map (
			N => M
		)
		port map(
			a_i	 => a_tb, 
			b_i	 => b_tb,
			op_i => op_tb,
			s_o	 => s_tb,
			co_o => co_tb
		);
	
end;
