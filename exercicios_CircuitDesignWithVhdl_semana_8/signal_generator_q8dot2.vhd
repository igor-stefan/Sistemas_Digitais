-- Code your design here
library IEEE;
use IEEE.std_logic_1164.all;

entity signal_generator is
port(
	clk : in std_logic;
    out1, out2 : out std_logic
);
end entity signal_generator;

architecture fsm of signal_generator is

type states is (st1, st2, st3, st4);
signal f, s: std_logic := '0';
signal at_state1, nx_state1, at_state2, nx_state2: states := st4;

begin

----- Lower section of machine #1: ---
process(clk) is
	begin
		if(rising_edge(clk)) then
    		at_state1 <= nx_state1;
    	end if;
end process;

----- Lower section of machine #2: ---
process(clk) is
begin
	if(falling_edge(clk)) then
    	at_state2 <= nx_state2;
    end if;
end process;

----- Upper section of machine #1: ---
process(at_state1) is
	begin
    	case at_state1 is
        	when st1 =>
            	f <= '1';
                nx_state1 <= st2;
            when st2 =>
            	f <= '0';
                nx_state1 <= st3;
            when st3 =>
            	f <= '1';
                nx_state1 <= st4;
            when st4 =>
            	f <= '0';
                nx_state1 <= st1;
        end case;
end process;

----- Upper section of machine #2: ---
process(at_state2, at_state1) is
	variable troca: boolean := false;
	begin
    	case at_state2 is
        	when st1 =>
            	s <= '1';
                nx_state2 <= st2;
            when st2 =>
            	s <= '0';
                nx_state2 <= st3;
            when st3 =>
            	s <= '0';
                if(at_state1 = st4) then
                	s <= '1';
                end if;
				nx_state2 <= st4;
            when st4 =>
            	s <= '1';
                nx_state2 <= st1;
        end case;
end process;

out1 <= f and s;
out2 <= not(f xor s);

end architecture fsm;