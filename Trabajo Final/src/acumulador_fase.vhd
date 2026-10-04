library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity acumulador_fase is
	generic (
		N: positive := 16
	);

	port(
		clk_i: in std_logic;
		rst_i: in std_logic;
		ena_i: in std_logic;
		K_i: in std_logic_vector(N-1 downto 0);
		phase_o: out std_logic_vector(N-1 downto 0)
	);
end;

architecture acumulador_fase_arq of acumulador_fase is
begin

	process(clk_i)
	begin
		if rising_edge(clk_i) then
			if rst_i = '1' then
				phase_o <= std_logic_vector(to_unsigned(0, N));
			elsif ena_i = '1' then
				phase_o <= ( unsigned(phase_o) + unsigned(K_i) ) * 2**N;
			end if;
		end if;
	end process;

end;
