library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity shifterCordic is
port(
    a: in std_logic_vector(15 downto 0);
    how_many: in integer;
    s: out std_logic_vector(15 downto 0)
);
end entity shifterCordic;

architecture shift of shifterCordic is

signal x: std_logic_vector(15 downto 0) := (others => '0');

begin

x(15 - how_many downto 0) <= a(15 downto how_many);
s <= x;

end architecture shift;

-- este deslocador apenas desloca para direita
-- o número de bits especificados pela variável how many