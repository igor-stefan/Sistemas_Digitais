-- Code your design here
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity doubledabble is
port(
	clk: in std_logic;
	binary: in std_logic_vector(7 downto 0);
    reset: in std_logic; --ativo em high
    unidade, dezena, centena: out std_logic_vector(3 downto 0);
    done: out std_logic
);
end entity doubledabble;

architecture behavior of doubledabble is
constant k : unsigned(3 downto 0) := "0101"; -- 5 -> esse poderia ter sido criado como int
constant n : unsigned(3 downto 0) := "0011"; -- 3
type states is (idle, check, add, shift, finish); --estados
signal at_state, nx_state : states; --signals para controlar os estados

begin

process(clk, reset) is
begin
	if(reset = '1') then --ao resetar entra no primeiro estado
    	at_state <= idle;
	elsif(clk'event and clk = '1') then --em borda de subida troca o estado (se este mudar)
    	at_state <= nx_state;
    end if;
end process;

process(at_state, clk) is
variable cont : integer := 8; --variavel para contar os deslocamentos
variable add1, add2, add3 : boolean := false; --para controlar se é necessario fazer adição
variable ans : std_logic_vector(11 downto 0) := (others => '0'); --vetor para os deslocamentos
begin
	case at_state is
    	when idle => --primeiro estado reseta tudo
        	nx_state <= check;
            done <= '0';
            cont := 8;
            add1 := false;
            add2 := false;
            add3 := false;
            ans := (others => '0');
            centena <= (others => 'Z'); --alta impedância
            dezena <= (others => 'Z');
            unidade <= (others => 'Z');
        when check => --segundo estado é o checador
        	if(cont = 0) then --se eu terminei a conversao
            	nx_state <= finish; -- prox estado é o final
            else
              --se nao, na borda de descida, para nao conflitar com a borda de subida do processo anterior
                if(clk'event and clk = '0') then 
                    --report integer'image(to_integer(unsigned(ans(3 downto 0)))) &  " >= " & integer'image(to_integer(k)) & " ?" severity note; --apenas um report
                    --verifico se o numero da casa das centenas é maior ou igual a 5
                    if(to_integer(unsigned(ans(11 downto 8))) >= to_integer(k)) then
                        add1 := true;
                    end if;
                    --verifico se o numero da casa das dezenas é maior ou igual a 5
                    if(to_integer(unsigned(ans(7 downto 4))) >= to_integer(k)) then
                        add2 := true;
                    end if;
                    --verifico se o numero da casa das unidades é maior ou igual a 5
                    if(to_integer(unsigned(ans(3 downto 0))) >= to_integer(k)) then
                        add3 := true;
                    end if;
                    --se algum dos numeros for maior que 5
                    if(add1 or add2 or add3) then
                        nx_state <= add; --o proximo estado é o de adição
                    else
                        nx_state <= shift; --caso contrario, é o de deslocamento
                    end if;
                end if;
            end if;
        when add => --estado de adição
        	--verifico em qual numero (centena, dezena ou unidade) devo fazer a soma
            --faço a soma e imediatamente coloco a variavel em false para evitar nova adição
            if add1 then
                ans(11 downto 8) := std_logic_vector(unsigned(ans(11 downto 8)) + n);
                add1 := false;
            end if;
            if add2 then
                ans(7 downto 4) := std_logic_vector(unsigned(ans(7 downto 4)) + n);
                add2 := false;
            end if;
            if add3 then
           		ans(3 downto 0) := std_logic_vector(unsigned(ans(3 downto 0)) + n);
                add3 := false;
            end if;
            nx_state <= shift; --ao final das somas necessárias o proximo estado é o de deslocamento
        when shift => --estado de deslocamento
        	-- na borda de descida realizo o deslocamento
            if(clk'event and clk = '0') then
            	cont := cont - 1;
                ans(11 downto 1) := ans(10 downto 0);
            	ans(0) := binary(cont);
            	nx_state <= check; --depois de deslocar o proximo estado é o de checagem
            end if;
        when finish => --se cheguei neste estado eu terminei a conversao
            done <= '1'; --ativo o sinal de done
            --os sinais de saida recebem seus respectivos numeros
            centena <= ans(11 downto 8); 
            dezena <= ans(7 downto 4);
            unidade <= ans(3 downto 0);
    end case;
    --report "atual state = " & to_string(at_state) & " cont = " & integer'image(cont) & " " & to_string(ans) severity note; --apenas um report
end process; --fim
end architecture behavior;