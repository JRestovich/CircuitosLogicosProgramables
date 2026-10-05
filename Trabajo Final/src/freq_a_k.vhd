library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity freq_a_k is
    generic (
        N : positive := 32;
        FREQ_BITS : positive := 32;
        FS_HZ : positive
    );
    port (
        freq_i : in std_logic_vector(FREQ_BITS-1 downto 0);
        K_o : out std_logic_vector(N-1 downto 0)
    );
end entity;

architecture freq_a_k_arq of freq_a_k is
    -- Espacio para desplazar la frecuencia y sumar el redondeo.
    constant W : positive := N + FREQ_BITS + 32;
    constant DIVISOR : unsigned(W-1 downto 0) := to_unsigned(FS_HZ, W);
    constant HALF_FS : unsigned(W-1 downto 0) := to_unsigned(FS_HZ / 2, W);
    constant K_MAX : unsigned(N-1 downto 0) :=
        shift_right(to_unsigned(0, N) - 1, 1);
    signal numerator, quotient : unsigned(W-1 downto 0);
begin
    -- K = round(freq_Hz * 2**N / FS_HZ).
    numerator <= shift_left(resize(unsigned(freq_i), W), N) + HALF_FS;
    quotient <= numerator / DIVISOR;
    -- Saturacion estrictamente por debajo de Nyquist.
    K_o <= std_logic_vector(K_MAX) when quotient > resize(K_MAX, W)
           else std_logic_vector(resize(quotient, N));
end architecture;
