-- Code your testbench here
library IEEE;
use IEEE.std_logic_1164.all;

entity testbench is
end entity testbench;

architecture test of testbench is

component signal_generator is
port(
	clk : in std_logic;
    out1, out2 : out std_logic
);
end component signal_generator;

signal clk, out1, out2 : std_logic := '0';

begin

dut: signal_generator port map(
	clk => clk,
    out1 => out1,
    out2 => out2
);

process is
begin
	for i in 0 to 15 loop
    	clk <= '0';
        wait for 5 ns;
        clk <= '1';
        wait for 5 ns;
    end loop;
wait;
end process;

end architecture test;