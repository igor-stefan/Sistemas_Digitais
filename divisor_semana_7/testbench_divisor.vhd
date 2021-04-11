-- Code your testbench here
library IEEE;
use IEEE.std_logic_1164.all;

entity testbench is
end entity testbench;

architecture test of testbench is

component divisor is
generic(n : natural := 8);
port(
a, b : in std_logic_vector(n - 1 downto 0);
clear, clock : in std_logic;
resto1, resto2, q1, q2 : out std_logic_vector(n - 1 downto 0)
);
end component divisor;

constant k : natural := 8;
signal a_in, b_in, resultado1, resultado2, resto1, resto2 : std_logic_vector(k - 1 downto 0);
signal clr, clk : std_logic := '0';

begin

dut: divisor port map(
	a => a_in,
    b => b_in,
    clear => clr,
    clock => clk,
    q1 => resultado1,
    q2 => resultado2,
    resto1 => resto1,
    resto2 => resto2
);

--gerando o clock do teste
process is
begin
	for i in 0 to 45 loop
    	clk <= '1';
        wait for 5 ns;
        clk <= '0';
        wait for 5 ns;
    end loop;
wait;
end process;

--valores de a e b
a_in <= "00010001", -- 17
     	"01111101" after 100 ns, -- 125
     	"01001000" after 290 ns; -- 72
     

b_in <= "00000011", -- 3
     	"00000111" after 100 ns, -- 7
     	"00001000" after 290 ns; -- 8

--momentos de inicio de cada divisao quando clear de 1 -> 0
clr <= '1',
	   '0' after 5 ns,
	   '1' after 115 ns,
       '0' after 130 ns,
       '1' after 320 ns,
       '0' after 330 ns;

-- asserts
-- operacao 1 comeca em 10 ns (primeira borda de subida apos clr = '0')

assert resultado1 /= "00000101" or resto1 /= "00000010" report "Divisor otimizado terminou a operacao 1" severity note;
assert resultado2 /= "00000101" or resto2 /= "00000010" report "Divisor nao-otimizado terminou a operacao 1" severity note;

-- operacao 2 começa em 130 ns
assert resultado1 /= "00010001" or resto1 /= "00000110" report "Divisor otimizado terminou a operacao 2" severity note;
assert resultado2 /= "00010001" or resto2 /= "00000110" report "Divisor nao-otimizado terminou a operacao 2" severity note;

-- operacao 3 começa em 330 ns
assert resultado1 /= "00001001" or resto1 /= "00000000" report "Divisor otimizado terminou a operacao 3" severity note;
assert resultado2 /= "00001001" or resto2 /= "00000000" report "Divisor nao-otimizado terminou a operacao 3" severity note;

end architecture test;