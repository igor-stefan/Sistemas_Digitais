library IEEE;
use IEEE.std_logic_1164.all;

entity testbench is
end entity testbench;

architecture makingSum of testbench is
component fullAdder is
	port(
	a: in std_logic;
	b: in std_logic;
	cin: in std_logic;
	cout: out std_logic;
	s: out std_logic
);
end component fullAdder;

signal a_in, b_in, c_in: std_logic := '0';
signal c_out, sum: std_logic;

begin
DUT : fullAdder port map(a_in, b_in, c_in, c_out, sum);
starting_simulation: process
	begin
wait for 15 ns;
		
 a_in <= '1';
 b_in <= '0';
 c_in <= '0';
 WAIT FOR 10 ns;
  
 a_in <= '0';
 b_in <= '1';
 c_in <= '0';
 WAIT FOR 10 ns;
 
 a_in <= '1';
 b_in <= '1';
 c_in <= '0';
 WAIT FOR 10 ns;
 
 a_in <= '0';
 b_in <= '0';
 c_in <= '1';
 WAIT FOR 10 ns;
 
 a_in <= '1';
 b_in <= '0';
 c_in <= '1';
 WAIT FOR 10 ns;
 
 a_in <= '0';
 b_in <= '1';
 c_in <= '1';
 WAIT FOR 10 ns;
 
 a_in <= '1';
 b_in <= '1';
 c_in <= '1';
 WAIT FOR 10 ns;

 ASSERT false REPORT "Test done." SEVERITY note;
 
 --USAR COMANDO WAIT PARA QUE O PROGRAMA ESPERE GERAR O ARQUIVO COM A FORMA DE ONDA
 
wait;

end process;
end architecture makingSum;

	

