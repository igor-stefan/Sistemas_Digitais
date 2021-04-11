library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity deslocador_2_bits_esq_r is
    generic(n: natural := 32);
    port(
        vetor2r: in std_logic_vector(n - 1 downto 0);
        deslocado2bitsr: out std_logic_vector(n - 1 downto 0)
    );
end entity deslocador_2_bits_esq_r;

architecture deslocando_2_bits_r of deslocador_2_bits_esq_r is
    signal s: std_logic_vector(n - 1 downto 0) := (others => '0');
    begin
        s(n - 1 downto 2) <= vetor2r(n - 3 downto 0);
        deslocado2bitsr <= s;
end architecture deslocando_2_bits_r;
