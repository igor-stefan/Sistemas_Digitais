-- Code your testbench here
library IEEE;
use IEEE.std_logic_1164.all;

entity testbench is
end entity testbench;

architecture test of testbench is

component signal_generator is
port(
	clk, stop, go : in std_logic;
    up, down : out std_logic
);
end component signal_generator;

signal clk, stop, go, up, down : std_logic := '0';
begin

dut: signal_generator port map(
	clk => clk,
    stop => stop,
    go => go,
    up => up,
    down => down
);

process is
begin
	for i in 0 to 80 loop
    	clk <= '0';
        wait for 5 ns;
        clk <= '1';
        wait for 5 ns;
    end loop;
wait;
end process;

go <= '0',
	  '1' after 100 ns,
      '0' after 150 ns,
      '1' after 200 ns,
      '0' after 250 ns,
      '1' after 400 ns,
      '0' after 450 ns,
      '1' after 500 ns,
      '0' after 550 ns;

stop <= '1',
		'0' after 10 ns,
		'1' after 350 ns,
        '0' after 400 ns,
        '1' after 700 ns;


end architecture test;