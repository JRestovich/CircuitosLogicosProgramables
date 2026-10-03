library IEEE;
use IEEE.std_logic_1164.all;

entity registro_desp_der is
	generic (
		N: natural :=4
	);

	port(
		clk_i: in std_logic;
		E_i: in std_logic;
		S_o: out std_logic
	);
end;

architecture registro_desp_der_arq of registro_desp_der is
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
