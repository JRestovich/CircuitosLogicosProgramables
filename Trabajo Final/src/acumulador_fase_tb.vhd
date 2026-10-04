library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity acumulador_fase_tb is
end;

architecture acumulador_fase_tb_arq of acumulador_fase_tb is
    -- Declaracion de componente
	constant M : positive := 4;

	component acumulador_fase is
		generic (
			N : positive := 4
		);

		port(
			clk_i: in std_logic;
			rst_i: in std_logic;
			ena_i: in std_logic;
			K_i: in std_logic_vector(N-1 downto 0);
			phase_o: out std_logic_vector(N-1 downto 0)
		);
	end component;

	-- Declaracion de senales de prueba
	signal clk_tb: std_logic := '0';
	signal rst_tb: std_logic := '1';
	signal ena_tb: std_logic := '1';
	signal K_tb: std_logic_vector(M-1 downto 0) := std_logic_vector(to_unsigned(1, M));
	signal phase_tb: std_logic_vector(M-1 downto 0);

	begin
	clk_tb <= not clk_tb after 10 ns;
	rst_tb <= '0' after 20 ns;

	DUT: acumulador_fase
		generic map (
			N => M
		)
		port map(
			clk_i   => clk_tb,
			rst_i   => rst_tb,
			ena_i   => ena_tb,
			K_i     => K_tb,
			phase_o => phase_tb
		);

end;

