-- Code your testbench here
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity testbench is
end entity testbench;

architecture test of testbench is
	constant tamanho_k: integer := 30;
    constant potencia: integer := 6;
    --potencia para limitar testbench, se for > 6 o simulador nao aguenta 
    --potencia deve ser menor que tamanho_k
    --trocar o valor da constante --> subtraio? 
    constant subtraio: std_logic := '0';
    
    signal primeiro_numero, segundo_numero: std_logic_vector(tamanho_k - 1 downto 0) := (others => '0');
    signal resultado_soma: std_logic_vector(tamanho_k downto 0);
    
    component carry_select_adder is
generic(n : natural;
		devo_subtrair : std_logic);
port(
	a: in std_logic_vector(n - 1 downto 0);
    b: in std_logic_vector(n - 1 downto 0);
    sum: out std_logic_vector(n downto 0)
);
end component carry_select_adder;

begin

	dut: carry_select_adder generic map (
    n => tamanho_k,
    devo_subtrair => subtraio)
    port map(
    	a => primeiro_numero,
        b => segundo_numero,
        sum => resultado_soma
    );
    
--teste realizado com todos os pares possiveis com/sem repeticao no limite da potencia --> ver log
--mudar valor de rep no bloco process (0 com repeticao, 1 sem repeticao)

simulacao: process
 constant rep : natural := 1;
 variable temp : integer := 0;
 begin

  for f in 0 to 2 ** potencia - 1 loop
      for s in temp to 2 ** potencia - 1 loop
        primeiro_numero <= std_logic_vector(to_unsigned(f, tamanho_k));
        segundo_numero   <= std_logic_vector(to_unsigned(s, tamanho_k));
        wait for 5 ns;
        if subtraio = '0' then
          report integer'image(f) & " + " & integer'image(s) & " = " & integer'image(to_integer(unsigned(resultado_soma)));
	else
		report integer'image(f) & " - " & integer'image(s) & " = " & integer'image(to_integer(unsigned(resultado_soma))  - (2 ** tamanho_k));
        --conversao realizada usando o mapeamento top-down dos bits ao usar o complemento de 2
        --complemento_2 -8 --> 8(1000)
        -- complemento_2 -2 --> 14 (1110)
        -- complemento_2 -1 --> 15 (1111)
        -- complemento_2 0 --> 16 (descarta 1 bit) ...
        --verificado pelos numeros binarios do resultado na forma de onda gerada
	end if;
      end loop;
      temp := temp + rep;
    end loop;
    
    wait;
   end process;
end architecture test;