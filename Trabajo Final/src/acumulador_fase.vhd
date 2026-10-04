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
    signal phase_reg : unsigned(N-1 downto 0);
begin
    phase_o <= std_logic_vector(phase_reg);

	process(clk_i)
	begin
		if rising_edge(clk_i) then
			if rst_i = '1' then
				phase_reg <= to_unsigned(0, N);
			elsif ena_i = '1' then
				phase_reg <= phase_reg + unsigned(K_i);
			end if;
		end if;
	end process;

end;
