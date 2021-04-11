-- Code your testbench here
library IEEE;
use IEEE.std_logic_1164.all;

entity testbench is
end entity testbench;

architecture test of testbench is

component CD4021B is
generic(n : natural := 8);
port(
serial_in, clock, psc : in std_logic; --psc --> parallel/serial control
parallel_in: in std_logic_vector(n - 1 downto 0);
q8, q7, q6: out std_logic );
end component CD4021B;

constant k: natural := 8; --constante para prevenir erro
type q is array(0 to 2) of std_logic_vector(k - 1 downto 0); --numeros para teste

signal serial_in, clock, psc : std_logic := '1';
signal numeros : q := (0 => "10110110",
					   1 => "11110000",
                       2 => "10010101");
signal parallel_in: std_logic_vector(k - 1 downto 0) := (others => '0');
signal q8, q7, q6: std_logic;


begin

dut:CD4021B port map
	(
	serial_in => serial_in,
    clock => clock,
    psc => psc,
    parallel_in => parallel_in,
    q8 => q8,
    q7 => q7,
    q6 => q6
	);
	
    
 process
 begin
 	--controle dos sinais de clock e das entradas paralelas e a serial
 	for i in 0 to 2 loop 
    	parallel_in <= numeros(i);
   		for j in k - 1 downto 0 loop
      		serial_in <= numeros(i)(j);
      		clock <= '0';
      		wait for 5 ns;
      		clock <= '1';
      		wait for 5 ns;
      	end loop;
    end loop;
 wait;
 end process;

 --controle da entrada psc -> parallel / serial control
 
 psc <= '0', --inicia registrando apenas pela serial;
 	 	'1' after 15 ns, --registra o número paralelo;
		'0' after 25 ns, --saída serial de todo o número paralelo registrado
        '1' after 110 ns, --apos todo o número ter saído na serial novo numero registrado
		'0' after 150 ns,
        '1' after 210 ns,
        '0' after 215 ns;
        
end architecture test;