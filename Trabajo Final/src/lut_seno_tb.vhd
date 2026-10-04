library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.seno_lut_pkg.all;

entity lut_seno_tb is
end;

architecture lut_seno_tb_arq of lut_seno_tb is
	 -- Declaracion de componente
	constant M : positive := 10;

	component lut_seno is
		generic (
			N : positive := 10
		);

		port(
			clk_i: in std_logic;
			rst_i: in std_logic;
			phase_i: in std_logic_vector(N-1 downto 0);
			sine_mv_o: out std_logic_vector(LUT_DATA_BITS-1 downto 0)
		);
	end component;

	-- Declaracion de senales de prueba
	signal clk_tb: std_logic := '0';
	signal rst_tb: std_logic := '1';
	signal phase_tb: std_logic_vector(M-1 downto 0) := (others => '0');
	signal sine_tb: std_logic_vector(LUT_DATA_BITS-1 downto 0);

	begin
	clk_tb <= not clk_tb after 10 ns;
	rst_tb <= '0' after 20 ns;

	DUT: lut_seno
		generic map (
			N => M
		)
		port map(
			clk_i   => clk_tb,
			rst_i   => rst_tb,
			phase_i     => phase_tb,
			sine_mv_o => sine_tb
		);

    estimulos: process
    begin
        -- Esperar a que finalice el reset antes de recorrer la tabla.
        wait until rst_tb = '0';

        for i in 0 to 1023 loop
            wait until falling_edge(clk_tb);
            phase_tb <= std_logic_vector(to_unsigned(i, M));
        end loop;

        wait;
    end process;

end;
