library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity operador_resto is
    generic(n: natural := 32);
    port(
        d_op, r_op, q_op: in std_logic_vector(n - 1 downto 0);
        op: in std_logic;
        index: in integer range 0 to 30;
        resto_parcial_operado: out std_logic_vector(n - 1 downto 0)

    );
end entity operador_resto;


architecture operando of operador_resto is
    component deslocador_2_bits_esq_q is
        generic(n: natural := 32);
        port(
            vetor2: in std_logic_vector(n - 1 downto 0);
            op: in std_logic;
            deslocado2bits: out std_logic_vector(n - 1 downto 0)
        );
    end component deslocador_2_bits_esq_q;

    component deslocador_2_bits_esq_r is
        generic(n: natural := 32);
        port(
            vetor2r: in std_logic_vector(n - 1 downto 0);
            deslocado2bitsr: out std_logic_vector(n - 1 downto 0)
        );
    end component deslocador_2_bits_esq_r;
    
    component deslocador_n_bits is
        generic(n: natural := 32);
        port(
            vetor: in std_logic_vector(n - 1 downto 0);
            x: in integer range 0 to 30;
            deslocadoNbits: out std_logic_vector(n - 1 downto 0)
        );
    end component deslocador_n_bits;
    
    signal resto_parcial, d_operado, r_deslocado, q_deslocado: std_logic_vector(n - 1 downto 0) := (others => '0');
    begin
        operando_num: deslocador_n_bits port map(
            vetor => d_op,
            x => index,
            deslocadoNbits => d_operado
        );
        operando_resto: deslocador_2_bits_esq_r port map(
            vetor2r => r_op,
            deslocado2bitsr => r_deslocado
        );
        operando_sqrt_parcial: deslocador_2_bits_esq_q port map(
            vetor2 => q_op,
            op => r_op(n - 1),
            deslocado2bits => q_deslocado
        );
        resto_parcial <= d_operado or r_deslocado;
        resto_parcial_operado <=  
            std_logic_vector(signed(resto_parcial) - signed(q_deslocado)) when op = '0'
        else 
            std_logic_vector(signed(resto_parcial) + signed(q_deslocado));

end architecture operando;