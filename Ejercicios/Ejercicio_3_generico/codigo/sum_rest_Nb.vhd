library IEEE;
use IEEE.std_logic_1164.all;

entity sum_rest_Nb is
	generic (
		N: natural :=4
	);

	port(
		a_i: in std_logic_vector(N-1 downto 0);
		b_i: in std_logic_vector(N-1 downto 0);
		s_o: out std_logic_vector(N-1 downto 0);
		co_o: out std_logic;
		op_i: in std_logic -- false suma, true resta
	);
end;

architecture sum_rest_Nb_arq of sum_rest_Nb is
	-- parte declarativa
	component sum1b is
	port(
		a_i: in std_logic;
		b_i: in std_logic;
		ci_i: in std_logic;
		s_o: out std_logic;
		co_o: out std_logic
	);
	end component;

	signal aux: std_logic_vector(N downto 0);
	signal b_aux: std_logic_vector(N-1 downto 0);

begin
	-- parte descriptiva
	aux(0) <= op_i;
	co_o <= aux(N);

	sumador : for i in 0 to N-1 generate
		b_aux(i) <= b_i(i) xor op_i;

		sum1b_inst : sum1b 
			port map(
				a_i  => a_i(i),
				b_i  => b_aux(i),
				ci_i => aux(i),
				s_o  => s_o(i),
				co_o => aux(i+1)
			);
	
	end generate;

end;