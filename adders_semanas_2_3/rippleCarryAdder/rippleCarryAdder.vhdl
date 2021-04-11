library ieee;
use ieee.std_logic_1164.all;

entity n_bits_adder is
	generic(length: integer := 8);
	port(
		a, b: in std_logic_vector(length - 1 downto 0);
		s: out std_logic_vector(length - 1 downto 0);
       		cin: in std_logic;
		cout: out std_logic);
end entity n_bits_adder;

architecture connecting_adders of n_bits_adder is
	component fullAdder is
		port(
			a, b, c_in: in std_logic := '0';
			s, c_out: out std_logic);
	end component;

signal carry: std_logic_vector(length downto 0);

begin
	connecting: for j in 0 to length - 1 generate
	x: fullAdder port map(
		a =>  a(j),
		b => b(j),
	        c_in =>	carry(j),
	       	s => s(j),
	        c_out => carry(j + 1));
	end generate;
carry(0) <= cin;
cout <= carry(length);
end architecture connecting_adders;

