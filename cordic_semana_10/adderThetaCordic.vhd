library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity adderThetaCordic is
port(
    a, b: in std_logic_vector(15 downto 0);
    subtracao : in std_logic; --1 para subtrair
    s: out std_logic_vector(15 downto 0);
    next_op: out std_logic
);
end entity adderThetaCordic;

architecture make_sum_theta of adderThetaCordic is

begin
    s <= std_logic_vector(unsigned(a) - unsigned(b)) when unsigned(a) >= unsigned(b) else
         std_logic_vector(unsigned(b) - unsigned(a));
            
    next_op <= '0' when subtracao = '1' and unsigned(b) > unsigned(a) else
    		   '0' when subtracao = '0' and unsigned(b) < unsigned(a) else
               '1';
end architecture make_sum_theta;
-- para o algoritmo desenvolvido, apenas a diferença entre o números importa
-- o sinal, se é negativo ou positivo, é tratado na operação seguinte