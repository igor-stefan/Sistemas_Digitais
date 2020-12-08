library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity deslocador_n_bits is
    generic(n: natural := 32);
    port(
        vetor: in std_logic_vector(n - 1 downto 0);
        x: in integer range 0 to 30;
        deslocadoNbits: out std_logic_vector(n - 1 downto 0)
    );
end entity deslocador_n_bits;

architecture deslocando_n_bits of deslocador_n_bits is
    constant q11 : std_logic_vector(n - 1 downto 0) := "00000000000000000000000000000011";
    signal s: std_logic_vector(n - 1 downto 0) := (others => '0');
    begin
        s(n - x - 1 downto 0) <= vetor(n - 1 downto x);
        deslocadoNbits <= s and q11;
end architecture deslocando_n_bits;
