library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.seno_lut_pkg.all;

entity nco_tb is
end;

architecture nco_tb_arq of nco_tb is
    constant M : positive := 32;
    constant F : positive := 32;
    constant FREQ_HZ : natural := 1_000_000;

    -- Declaracion de componente
    component nco is
        generic (
            N : positive := 32;
            FREQ_BITS : positive := 32;
            FS_HZ : positive
        );
        port (
            clk_i : in std_logic;
            rst_i : in std_logic;
            ena_i : in std_logic;
            freq_i : in std_logic_vector(FREQ_BITS-1 downto 0);
            sine_mv_o : out std_logic_vector(LUT_DATA_BITS-1 downto 0)
        );
    end component;

    -- Declaracion de senales de prueba
    signal clk_tb : std_logic := '0';
    signal rst_tb : std_logic := '1';
    signal ena_tb : std_logic := '1';
    signal freq_tb : std_logic_vector(F-1 downto 0) := std_logic_vector(to_unsigned(FREQ_HZ, F));
    signal sine_tb : std_logic_vector(LUT_DATA_BITS-1 downto 0);

begin
    -- Periodo de 10 ns: clock de 100 MHz.
    clk_tb <= not clk_tb after 5 ns;
    rst_tb <= '0' after 20 ns;

    DUT : nco
        generic map (
            N => M,
            FREQ_BITS => F,
            FS_HZ => 100_000_000
        )
        port map (
            clk_i => clk_tb,
            rst_i => rst_tb,
            ena_i => ena_tb,
            freq_i => freq_tb,
            sine_mv_o => sine_tb
        );

end;

