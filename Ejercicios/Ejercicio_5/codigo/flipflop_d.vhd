library IEEE;
use IEEE.std_logic_1164.all;

entity flipflop_d is
	port(
		clk_i: in std_logic;
		rst_i: in std_logic;
		ena_i: in std_logic;
		D_i: in std_logic;
		Q_o: out std_logic
	);
end;

architecture flipflop_d_arq of flipflop_d is
begin
	process(clk_i)
	begin
		if rising_edge(clk_i) then
			if rst_i = '1' then
				Q_o <= '0';
			elsif ena_i = '1' then
				Q_o <= D_i;
			end if;
		end if;
	end process;
end;
