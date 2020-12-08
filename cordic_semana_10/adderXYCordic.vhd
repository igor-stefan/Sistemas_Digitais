-- Code your design here
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity adderXYCordic is
port(
    a, b: in std_logic_vector(15 downto 0);
    subtracao : in std_logic; --1 para subtrair
    s: out std_logic_vector(15 downto 0);
    next_op: out std_logic
);
end entity adderXYCordic;

architecture make_sumXY of adderXYCordic is

begin
    
	s <= std_logic_vector(unsigned(a) - unsigned(b)) when unsigned(a) >= unsigned(b) and subtracao = '1' else
         std_logic_vector(unsigned(b) - unsigned(a)) when unsigned(a) < unsigned(b)  and subtracao = '1' else
         std_logic_vector(unsigned(a) + unsigned(b));
    next_op <= '1' xor subtracao;

end architecture make_sumXY;

-- para o algoritmo desenvolvido, apenas a diferença entre o números importa
-- o sinal, se é negativo ou positivo, é tratado na operação seguinte
-- no caso do adderXY o sinal da proxima operacao nao importa pois quem define a operação
-- é o sinal de Zi que é calculado no adderTheta
-- entao a saída é uma função xor arbitrária