library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.seno_lut_pkg.all;

entity lut_seno is
	generic (
		N: positive := 16
	);

	port(
		clk_i: in std_logic;
		rst_i: in std_logic;
		phase_i: in std_logic_vector(N-1 downto 0);
		sine_mv_o: out std_logic_vector(LUT_DATA_BITS-1 downto 0)
	);
end;

architecture lut_seno_arq of lut_seno is
	signal addr : unsigned(9 downto 0);
begin
	assert N >= 10
        report "La fase debe tener al menos 10 bits"
        severity failure;

	addr <= unsigned(phase_i(N-1 downto N-10));

	process(clk_i)
	begin
		if rising_edge(clk_i) then
			if rst_i = '1' then
				sine_mv_o <= std_logic_vector(to_unsigned(1500, 12));
			else
				sine_mv_o <= std_logic_vector(SENO_ROM(to_integer(addr)));
			end if;
		end if;
	end process;

end;
