-- Code your design here
library IEEE;
use IEEE.std_logic_1164.all;

entity signal_generator is
port(
	clk, stop, go : in std_logic;
    up, down : out std_logic
);
end entity signal_generator;

architecture fsm of signal_generator is

type states is (stateA, stateB, stateC);
constant T : integer := 3; --numero de ciclos de clock do delay de transição
signal at_state, nx_state : states;

begin

process(clk, stop, go) is
variable cont : integer range 0 to T;
begin
	if (go'event) then --se houve alguma transição, zero a variável de contagem
        	cont := 0;
        end if;
	if(stop = '1') then
    	at_state <= stateA;
        cont := 0;
    elsif(clk'event and clk = '1') then
    	cont := cont + 1;
        if(cont = T) then
        	at_state <= nx_state;
            cont := 0;
        end if;
     end if;
end process;

process(go, at_state) is
begin
	case at_state is
    	when stateA =>
        	down <= '0';
            up <= '0';
            if(go = '1') then
            	down <= '0';
            	nx_state <= stateB;
            elsif(go = '0') then
            	up <= '0';
            	nx_state <= stateC;
            end if;
        when stateB =>
            up <= '1';
            if(go'event and go = '0') then
            	up <= '0';
                nx_state <= stateC;
            end if;
        when stateC =>
        	down <= '1';
            if(go'event and go = '1') then
            	down <= '0';
                nx_state <= stateB;
            end if;
    end case;
end process;
end architecture fsm;