-- Code your testbench here
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity testbench is
end entity testbench;

architecture test of testbench is

component ci74hc595 is
generic(n : natural := 8);
port(oe, rclk, srclr, srclk, ser: in std_logic;
qhl: out std_logic;
output: out std_logic_vector(n - 1 downto 0));
end component ci74hc595;

constant k: natural := 8; --constante para prevenir erro
type tripla is array(0 to 2) of std_logic_vector(k - 1 downto 0); --vetor com tres numeros para teste

signal exibir, clock_gravar, limpar_reg, clock_reg, val, qhl: std_logic := '1';
signal numeros: tripla := (0 => "10110110",
						   1 => "11110000",
                           2 => "10010101");
signal output: std_logic_vector(k - 1 downto 0) := (others => '0');

begin

dut: ci74hc595 port map(
oe => exibir,
rclk => clock_gravar,
srclr => limpar_reg,
srclk => clock_reg,
ser => val,
qhl => qhl,
output => output
);

--loop para pegar os valores de teste da tripla;
process
    begin
    for t in 0 to 2 loop
    	for p in k - 1 downto 0 loop
            val <= numeros(t)(p);
            wait for 10 ns;
        end loop;
    end loop;
    wait;
end process;

--loop para gerar o clock do registrador 25 ciclos -> 8 x 3 = 24 + 1 extra;
--tempo total = 25 x 10 ns = 250 ns;

process
	begin
    for i in 0 to 25 loop
    	clock_reg <= '0';
        wait for 5 ns;
        clock_reg <= '1';
        wait for 5 ns;
    end loop;
    wait;
end process;

--momentos do sinal de gravação - borda de subida grava;

clock_gravar <= '1',
				'0' after 35 ns,
                '1' after 40 ns,
				'0' after 50 ns,
                '1' after 55 ns,
                '0' after 60 ns,
                '1' after 65 ns,
                '0' after 70 ns,
                '1' after 75 ns,
                '0' after 80 ns,
                '1' after 85 ns,
                '0' after 90 ns,
                '1' after 105 ns,
        		'0' after 130 ns,
                '1' after 140 ns,
                '0' after 150 ns,
                '1' after 180 ns,
                '0' after 200 ns,
                '1' after 210 ns,
                '0' after 220 ns,
                '1' after 230 ns,
                '0' after 240 ns;

--momentos do sinal de exibição - 0 exibe 1 hold;
exibir <= '0',
		  '1' after 15 ns,
          '0' after 40 ns,
          '1' after 90 ns,
          '0' after 130 ns,
          '1' after 190 ns,
          '0' after 200 ns,
          '1' after 230 ns,
          '0' after 245 ns;
          
--momentos do sinal de limpar o registrador de deslocamento - 0 limpa
limpar_reg <= '1',
			  '0' after 100 ns,
              '1' after 120 ns,
              '0' after 220 ns,
              '1' after 225 ns;

end architecture test;