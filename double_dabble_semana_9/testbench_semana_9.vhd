-- Code your testbench here
library IEEE;
use IEEE.std_logic_1164.all;

entity testbench is
end entity testbench;

architecture test of testbench is

component doubledabble is
port(
	clk: in std_logic;
	binary: in std_logic_vector(7 downto 0);
    reset: in std_logic; --ativo em high
    unidade, dezena, centena: out std_logic_vector(3 downto 0);
    done: out std_logic
);
end component doubledabble;
type numeros_teste is array(0 to 10) of std_logic_vector(7 downto 0); --11 numeros de teste
signal numbers : numeros_teste := ( 0 => "00010101", -- 21
									1 => "00001111", -- 15
                                    2 => "00000101", -- 5
									3 => "00011011", -- 27
                                    4 => "01110011", -- 115
									5 => "00001001", -- 9
                                    6 => "00101010", -- 42
									7 => "10000001", -- 129
                                    8 => "11111111", -- 255
									9 => "11111110", -- 254 
                                    10 => "00000001" -- 1
                                    );
signal number : std_logic_vector(7 downto 0) := numbers(9);
signal reset, done, clk : std_logic := '0';
signal unit, dez, cent : std_logic_vector(3 downto 0);

begin

dut: doubledabble port map(
	binary => number,
    reset => reset,
    done => done,
    unidade => unit,
    dezena => dez,
    centena => cent,
    clk => clk
);

process is
begin
	for i in 0 to 10 loop
        reset <= '1'; --reseta pra iniciar nova conversao
        wait for 5 ns;
        reset <= '0';
    	number <= numbers(i); --coloca em number o numero a ser convertido
        for j in 0 to 25 loop --ciclos de clock
          clk <= '1';
          wait for 5 ns;
          clk <= '0';
          wait for 5 ns;
    	end loop;
    end loop;
wait;
end process;

end architecture test;