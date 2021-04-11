library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity psqrt_calculator is
    generic(
        n: natural := 32
    );
    port(
        a: in std_logic_vector(n - 1 downto 0);
        s: out std_logic_vector(n / 2 - 1 downto 0);
        r: out std_logic_vector(n - 1 downto 0)
    );
end entity psqrt_calculator;


architecture calculando_sqrt of psqrt_calculator is
    
    component operador_resto is
        generic(n: natural := 32);
        port(
            d_op, r_op, q_op: in std_logic_vector(n - 1 downto 0);
            op: in std_logic;
            index: in integer range 0 to 30;
            resto_parcial_operado: out std_logic_vector(n - 1 downto 0)  
        );
    end component operador_resto;

    component operador_q is
        generic(n: natural := 32);
        port(
            q_op: in std_logic_vector(n - 1 downto 0);
            rp_signal: in std_logic;
            q_parcial_op: out std_logic_vector(n - 1 downto 0)
        );
    end component operador_q;
    
    -- constant d: std_logic_vector(n - 1 downto 0) := a;
    type iteracoes is array(0 to 16) of std_logic_vector(n - 1 downto 0);
    signal r_op, q_op: iteracoes := (others => (others => '0'));
    signal corretor: std_logic_vector(n - 1 downto 0) := (others => '0');
begin
    realizando_conexoes: for idx in 15 downto 0 generate
        instanciar_operacao_resto_parcial: operador_resto port map(
            d_op => a,
            op => r_op(idx + 1)(n - 1),
            index => idx * 2,
            r_op => r_op(idx + 1), 
            q_op => q_op(idx + 1),
            resto_parcial_operado => r_op(idx)
        );
        instanciar_operacao_sqrt_parcial: operador_q port map(
            q_op => q_op(idx + 1),
            rp_signal => r_op(idx)(n - 1),
            q_parcial_op => q_op(idx)
        );
    end generate;
    corretor(n - 1 downto 1) <= q_op(0)(n - 2 downto 0);
    corretor(0) <= '1';
    r <= std_logic_vector(signed(r_op(0)) + signed(corretor)) when r_op(0)(n - 1) = '1' else r_op(0);
    s <= q_op(0)(n / 2 - 1 downto 0);
end architecture calculando_sqrt;