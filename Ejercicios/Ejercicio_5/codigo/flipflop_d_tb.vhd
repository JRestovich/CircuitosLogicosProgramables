library IEEE;
use IEEE.std_logic_1164.all;

entity flipflop_d_tb is
end;

architecture flipflop_d_tb_arq of flipflop_d_tb is

	-- Declaracion de componente
	component flipflop_d is
		port(
			clk_i: in std_logic;
			rst_i: in std_logic;
			ena_i: in std_logic;
			D_i: in std_logic;
			Q_o: out std_logic
		);
	end component;
	
	-- Declaracion de senales de prueba
	signal clk_tb: std_logic := '0';
	signal rst_tb: std_logic := '0';
	signal ena_tb: std_logic := '1';
	signal D_tb:   std_logic := '0';
	signal Q_tb:   std_logic;

begin
	clk_tb <= not clk_tb after 10 ns;
	rst_tb <= '1' after 100 ns, '0' after 150 ns;
	ena_tb <= '0' after 200 ns, '1' after 400 ns;
	D_tb <= '1' after 50 ns, '0' after 250 ns, '1' after 300 ns;

	DUT: flipflop_d
		port map(
			clk_i => clk_tb, 
			rst_i => rst_tb,
			ena_i => ena_tb,
			D_i => D_tb,
			Q_o	 => Q_tb
		);
	
end;
