-- Code your design here
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity divisor is
generic(n : natural := 8);
port(
a, b : in std_logic_vector(n - 1 downto 0);
clear, clock : in std_logic;
resto1, resto2, q1, q2 : out std_logic_vector(n - 1 downto 0)
);
end entity divisor;

architecture behavior of divisor is

signal ans: std_logic_vector(n - 1 downto 0) := (others => '0');

begin

--divisor otimizado
process(clear, clock) is
variable a_in : std_logic_vector(2 * n - 1 downto 0) := (others => '0');
variable b_in : std_logic_vector(2 * n - 1 downto 0) := (others => '0');
variable cont : natural := 0;
--variable ready : boolean := false;

begin
	if(clear = '1') then
    	ans <= (others => '0');
        q1 <= (others => '0');
        resto1 <= (others => '0');
        a_in(n - 1 downto 0) := a;
        b_in(2 * n - 1 downto n) := b;
        cont := n + 1;
        --ready := false;
    else
		if rising_edge(clock) then
        	if(cont /= 0) then
            	if(unsigned(b_in) > unsigned(a_in)) then
                    b_in(2 * n - 2 downto 0) := b_in(2 * n - 1 downto 1);
                    b_in(2 * n - 1) := '0';
                    ans(n - 1 downto 1) <= ans(n - 2 downto 0);
                    ans(0) <= '0';
                else
                    a_in := std_logic_vector(unsigned(a_in) - unsigned(b_in));
                    b_in(2 * n - 2 downto 0) := b_in(2 * n - 1 downto 1);
                    b_in(2 * n - 1) := '0';
                    ans(n - 1 downto 1) <= ans(n - 2 downto 0);
                    ans(0) <= '1';
                end if;
             	cont := cont - 1;
          	else
          		q1 <= ans;
          		resto1 <= a_in(n - 1 downto 0);
          	end if; -- cont
         --report "a_in = " & integer'image(to_integer(unsigned(a_in))) & " b_in = " & integer'image(to_integer(unsigned(b_in))) & " cont = " & integer'image(cont) severity note;
        end if; -- rising edge
    end if; -- clear
end process;

--divisor nao otimizado
process(clock, clear) is
variable w : integer := 0;
variable x : integer := 0;
variable acc : natural := 0;
begin
	if(clear = '1') then
    	w := to_integer(unsigned(a));
        x := to_integer(unsigned(b));
        acc := 0;
        q2 <= (others => '0');
        resto2 <= (others => '0');
    else
    	if(rising_edge(clock)) then
        	if(w >= x) then
            	w := w - x;
                acc := acc + 1;
            else
            	q2 <= std_logic_vector(to_unsigned(acc, n));
                resto2 <= std_logic_vector(to_unsigned(w, n));
            end if; -- w >= x
        end if; --rising edge
    end if; --clear
end process;

end architecture behavior;