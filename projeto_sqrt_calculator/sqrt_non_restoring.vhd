library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity sqrt_calculator is
    generic(
        n: natural := 32
    );
    port(
        a: in std_logic_vector(n - 1 downto 0);
        clk, reset: in std_logic;
        s: out std_logic_vector(n / 2 - 1 downto 0);
        r: out std_logic_vector(n - 1 downto 0)
    );
end entity sqrt_calculator;

architecture procedimento of sqrt_calculator is
    function deslocar_numero(k: std_logic_vector; x, tam: natural) return std_logic_vector is
        variable ans : std_logic_vector(tam - 1 downto 0) := (others => '0');
        begin
            ans(tam - x - 1 downto 0) := k(tam - 1 downto x);
            return ans;
    end function deslocar_numero;
    function deslocar_duas_casas_esq(k1: std_logic_vector) return std_logic_vector is
        variable ans: std_logic_vector(k1'length - 1 downto 0) := (others => '0');
        begin
            ans(k1'length - 1 downto 2) := k1(k1'length - 3 downto 0);
            return ans;
    end function deslocar_duas_casas_esq;
    constant q11 : std_logic_vector(n - 1 downto 0) := "00000000000000000000000000000011";
    constant q01 : std_logic_vector(n - 1 downto 0) := "00000000000000000000000000000001";
    begin
        process(reset, clk) is
            variable resto, resto_deslocado, num_deslocado: std_logic_vector(n - 1 downto 0) := (others => '0');
            variable square_root: std_logic_vector(n / 2 - 1 downto 0) := (others => '0');
            variable i: integer := 15;
            begin
                if(reset = '1') then
                    resto := (others => '0');
                    num_deslocado := (others => '0');
                    square_root := (others => '0');
                    i := 15;
                    r <= (others => 'Z');
                    s <= (others => 'Z');
                else
                    if(i >= 0) then
                        if(clk'event and clk = '1') then
                            if(to_integer(signed(resto)) >= 0) then
                                resto_deslocado := deslocar_duas_casas_esq(resto);
                                num_deslocado := deslocar_numero(a, 2 * i, n) and q11;
                                resto_deslocado := resto_deslocado or num_deslocado;
                                num_deslocado := (others => '0');
                                num_deslocado(n / 2 - 1 downto 0) := deslocar_duas_casas_esq(square_root);
                                num_deslocado := num_deslocado or q01;  
                                resto := std_logic_vector(signed(resto_deslocado) - signed(num_deslocado));
                            else
                                resto_deslocado := deslocar_duas_casas_esq(resto);
                                num_deslocado := deslocar_numero(a, 2 * i, n) and q11;
                                resto_deslocado := resto_deslocado or num_deslocado;
                                num_deslocado := (others => '0');
                                num_deslocado(n / 2 - 1 downto 0) := deslocar_duas_casas_esq(square_root);
                                num_deslocado := num_deslocado or q11;  
                                resto := std_logic_vector(signed(resto_deslocado) + signed(num_deslocado));
                            end if;
                            if(to_integer(signed(resto)) >= 0) then
                                square_root(n / 2 - 1 downto 1) := square_root(n / 2 - 2 downto 0);
                                square_root(0) := '1';
                            else
                                square_root(n / 2 - 1 downto 1) := square_root(n / 2 - 2 downto 0);
                                square_root(0) := '0';
                            end if;
                            i := i - 1;
                        end if;
                    else
                        if(to_integer(signed(resto)) < 0) then
                            num_deslocado := (others => '0');
                            num_deslocado(n / 2 - 1 downto 1) := square_root(n / 2 - 2 downto 0);
                            num_deslocado(0) := '1';
                            resto := std_logic_vector(signed(resto) + signed(num_deslocado));
                        end if;
                        r <= resto;
                        s <= square_root;
                    end if;
                end if;
            end process;
end architecture procedimento;