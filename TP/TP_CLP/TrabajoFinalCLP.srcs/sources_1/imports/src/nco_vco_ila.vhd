library IEEE;
use IEEE.std_logic_1164.all;

entity nco_vco_ila is
    port (
        clk_pin : in std_logic
    );
end entity;

architecture rtl of nco_vco_ila is
    component vio_control is
        port (
            clk : in std_logic;
            probe_out0 : out std_logic_vector(31 downto 0);
            probe_out1 : out std_logic_vector(0 downto 0);
            probe_out2 : out std_logic_vector(0 downto 0)
        );
    end component;

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
            sine_mv_o : out std_logic_vector(11 downto 0)
        );
    end component;

    component ila_nco is
        port (
            clk : in std_logic;
            probe0 : in std_logic_vector(11 downto 0);
            probe1 : in std_logic_vector(31 downto 0);
            probe2 : in std_logic_vector(0 downto 0);
            probe3 : in std_logic_vector(0 downto 0)
        );
    end component;

    signal freq_hz : std_logic_vector(31 downto 0);
    signal rst_vio : std_logic_vector(0 downto 0);
    signal ena_vio : std_logic_vector(0 downto 0);
    signal sine_mv : std_logic_vector(11 downto 0);
begin

    u_vio : vio_control
        port map (
            clk        => clk_pin,
            probe_out0 => freq_hz,
            probe_out1 => rst_vio,
            probe_out2 => ena_vio
        );

    u_nco : nco
        generic map (
            N         => 32,
            FREQ_BITS => 32,
            FS_HZ     => 100_000_000
        )
        port map (
            clk_i     => clk_pin,
            rst_i     => rst_vio(0),
            ena_i     => ena_vio(0),
            freq_i    => freq_hz,
            sine_mv_o => sine_mv
        );

    u_ila : ila_nco
        port map (
            clk    => clk_pin,
            probe0 => sine_mv,
            probe1 => freq_hz,
            probe2 => rst_vio,
            probe3 => ena_vio
        );

end architecture;
