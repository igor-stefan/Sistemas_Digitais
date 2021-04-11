-- Code your design here
library IEEE;
use IEEE.std_logic_1164.all;

entity ci74hc595 is
generic(n : natural := 8);
port(oe, rclk, srclr, srclk, ser: in std_logic;
qhl: out std_logic;
output: out std_logic_vector(n - 1 downto 0)); -- qh -> qa e qh'
end entity ci74hc595;

architecture behavior of ci74hc595 is

signal reg, memo: std_logic_vector(n-1 downto 0) := (others => '0');

begin

qhl <= output(n - 1);

	process(oe, rclk, srclr, srclk, ser) is
    begin
    	if(oe = '0') then --atualiza saida
        	output <= memo;
        else
        	output <= output; --hold saida
        end if;
        if(srclk'event and srclk = '1') then --na borda de subida, faz o deslocamento
        	reg(n - 1 downto 1) <= reg(n - 2 downto 0); -- << sentido do deslocamento <<
            reg(0) <= ser;
         end if;
         if(rclk'event and rclk = '1') then --na borda de subida, grava os valores
         	memo <= reg;
         end if;
        if(srclr = '0') then --limpa o registrador
        	reg <= (others => '0');
        end if;
    end process;
    
end architecture behavior;
