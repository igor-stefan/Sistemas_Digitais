library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity cordic is
port(
    x1, y1, theta: in std_logic_vector(15 downto 0);
    x2, y2 : out std_logic_vector(15 downto 0)
);
end entity cordic;

architecture sin_cos_cordic of cordic is

---- adiciona os componentes que serão necessários ------
component adderThetaCordic is
port(
    a, b: in std_logic_vector(15 downto 0);
    subtracao : in std_logic;
    s: out std_logic_vector(15 downto 0);
    next_op: out std_logic
);
end component adderThetaCordic;

component shifterCordic is
port(
    a: in std_logic_vector(15 downto 0);
    how_many: in integer;
    s: out std_logic_vector(15 downto 0)
);
end component shifterCordic;

component adderXYCordic is
port(
    a, b: in std_logic_vector(15 downto 0);
    subtracao : in std_logic; --1 para subtrair
    s: out std_logic_vector(15 downto 0);
    next_op: out std_logic
);
end component adderXYCordic;

------ cria uma matriz para armazenar os valores dos resultados das somas de cada adder

type resultados_somas is array(0 to 9) of std_logic_vector(15 downto 0);
constant aTan : resultados_somas := (0 => "0000000011001001", --201 -> 45º
                                     1 => "0000000001110111", --119 -> 26,56505118º
                                     2 => "0000000000111111", --63 -> 14,03624347º
                                     3 => "0000000000100000", --32 -> 7,125016349º
                                     4 => "0000000000010000", --16 -> 3,576334375º
                                     5 => "0000000000001000", --8 -> 1,789910608º
                                     6 => "0000000000000100", --4 -> 0,89517371º
                                     7 => "0000000000000010", --2 -> 0,447614171º
                                     8 => "0000000000000001", --1 -> 0,2238105º
                                     9 => "0000000000000000"  --0 -> 0,111905677º
                                     );
--- sinais que receberao os resultados das somas do respectivo bloco responsavel por atualizar o valor de x, y e theta
signal somaX, somaY, somaT, shiftX, shiftY: resultados_somas := (others => (others => '0'));
-- sinais que guardam qual devera ser a proxima operação a ser realizada 
-- 1 para subtracao e 0 para soma
signal subX, subY, subT, nsubT: std_logic_vector(0 to 9) := (others => '0');

begin

--valores iniciais
somaX(0) <= x1;
somaY(0) <= x1; 
shiftX(0) <= x1;
shiftY(0) <= y1;
nsubT <= not subT;

somaT(0) <= std_logic_vector(unsigned(aTan(0)) - unsigned(theta)) when theta < aTan(0) else
            std_logic_vector(unsigned(theta) - unsigned(aTan(0)));
subT(0) <= '1' when unsigned(aTan(0)) < unsigned(theta) else '0';

-- generate para conectar os componentes
conectar_componentes: for i in 1 to 9 generate
    instanciar_shiftersX: shifterCordic port map(
        a => somaX(i - 1),
        how_many => to_integer(to_unsigned(i, 4)),
        s => shiftX(i)
    );
    instanciar_addersX: adderXYCordic port map(
        a => somaX(i - 1),
        b => shiftY(i),
        subtracao => subT(i - 1),
        s => somaX(i),
        next_op => subX(i)
    );

    instanciar_shiftersY: shifterCordic port map(
        a => somaY(i - 1),
        how_many => to_integer(to_unsigned(i, 4)),
        s => shiftY(i)
    );
    instanciar_addersY: adderXYCordic port map(
        a => somaY(i - 1),
        b => shiftX(i),
        subtracao => nsubT(i - 1),
        s => somaY(i),
        next_op => subY(i)
    );

    instanciar_addersT: adderThetaCordic port map(
        a => somaT(i - 1),
        b => aTan(i),
        subtracao => subT(i - 1),
        s => somaT(i),
        next_op => subT(i)

    );
end generate conectar_componentes;

-- resultado final esta armazenado na ultima linha da matriz de atualização do respectivo valor; x para cos e y para sin;
x2 <= somaX(9);
y2 <= somaY(9);

end architecture sin_cos_cordic;