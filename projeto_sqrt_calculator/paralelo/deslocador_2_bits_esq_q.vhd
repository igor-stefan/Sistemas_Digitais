library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity deslocador_2_bits_esq_q is
    generic(n: natural := 32);
    port(
        vetor2: in std_logic_vector(n - 1 downto 0);
        op: in std_logic;
        deslocado2bits: out std_logic_vector(n - 1 downto 0)
    );
end entity deslocador_2_bits_esq_q;


architecture deslocando_2_bits_q of deslocador_2_bits_esq_q is
    constant q01 : std_logic_vector(n - 1 downto 0) := "00000000000000000000000000000001";
    constant q11 : std_logic_vector(n - 1 downto 0) := "00000000000000000000000000000011";
    signal s: std_logic_vector(n - 1 downto 0) := (others => '0');
    begin
        s(n - 1 downto 2) <= vetor2(n - 3 downto 0);
        deslocado2bits <= s or q01 when op = '0' else 
                          s or q11;
end architecture deslocando_2_bits_q;
