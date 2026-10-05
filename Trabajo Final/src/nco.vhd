library IEEE;
use IEEE.std_logic_1164.all;
use work.seno_lut_pkg.all;

entity nco is
    generic (
        N : positive := 32;
        FREQ_BITS : positive := 32;
        -- Tasa de actualizacion de fase en Hz.
        FS_HZ : positive
    );
    port (
        clk_i : in std_logic;
        rst_i : in std_logic;
        ena_i : in std_logic;
        -- Frecuencia en Hz enteros, sin signo, proveniente de VIO.
        freq_i : in std_logic_vector(FREQ_BITS-1 downto 0);
        sine_mv_o : out std_logic_vector(LUT_DATA_BITS-1 downto 0)
    );
end entity nco;

architecture nco_arq of nco is
    component freq_a_k is
        generic (
            N : positive := 32;
            FREQ_BITS : positive := 32;
            FS_HZ : positive
        );
        port (
            freq_i : in std_logic_vector(FREQ_BITS-1 downto 0);
            K_o : out std_logic_vector(N-1 downto 0)
        );
    end component;

    component acumulador_fase is
        generic (N : positive := 16);
        port (
            clk_i : in std_logic;
            rst_i : in std_logic;
            ena_i : in std_logic;
            K_i : in std_logic_vector(N-1 downto 0);
            phase_o : out std_logic_vector(N-1 downto 0)
        );
    end component;

    component lut_seno is
        generic (N : positive := 16);
        port (
            clk_i : in std_logic;
            rst_i : in std_logic;
            phase_i : in std_logic_vector(N-1 downto 0);
            sine_mv_o : out std_logic_vector(LUT_DATA_BITS-1 downto 0)
        );
    end component;

    signal phase_step : std_logic_vector(N-1 downto 0);
    signal phase : std_logic_vector(N-1 downto 0);
begin
    assert N >= 10
        report "La fase debe tener al menos 10 bits"
        severity failure;

    u_conversion : freq_a_k
        generic map (
            N => N, 
            FREQ_BITS => FREQ_BITS, 
            FS_HZ => FS_HZ
        )
        port map (
            freq_i => freq_i, 
            K_o => phase_step
        );

    u_acumulador : acumulador_fase
        generic map (N => N)
        port map (
            clk_i => clk_i,
            rst_i => rst_i,
            ena_i => ena_i,
            K_i => phase_step,
            phase_o => phase
        );

    u_lut : lut_seno
        generic map (N => N)
        port map (
            clk_i => clk_i,
            rst_i => rst_i,
            phase_i => phase,
            sine_mv_o => sine_mv_o
        );
end architecture nco_arq;
