library ieee;
use ieee.std_logic_1164.all;

entity testRCA is
	generic(length: integer := 8);
end entity testRCA;

architecture testingRCA of testRCA is
	component n_bits_adder
		port(
			a, b: in std_logic_vector(length - 1 downto 0);
			s: out std_logic_vector(length - 1 downto 0);
       			cin: in std_logic;
			cout: out std_logic);
	end component n_bits_adder;

signal a_in, b_in, sum: std_logic_vector(length - 1 downto 0);
signal c_in: std_logic := '0';
signal c_out:  std_logic;

begin
	dut: n_bits_adder port map(
		a => a_in,
		b => b_in,
		cin => c_in,
		s => sum,
		cout => c_out
	);
	
starting_simulation: process
	begin
	
	wait for 10 ns;

	a_in <= "1000";
	b_in <= "0010";
	wait for 10 ns;

	a_in <= "1000";
	b_in <= "0110";
	wait for 10 ns;

	a_in <= "1001";
	b_in <= "0010"; 
	wait for 10 ns;

	a_in <= "1001";
	b_in <= "0110";
	wait for  10 ns;

	a_in <= "1110";
	b_in <= "0110";
	wait for 10 ns;
	
	ASSERT false REPORT "Test done." SEVERITY note;
	wait;
	end process;
end architecture testingRCA;
