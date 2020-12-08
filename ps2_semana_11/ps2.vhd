library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity PS_2_Host is
    port(
        clk: in std_logic;
        data: in std_logic;
        ascii: out std_logic_vector(7 downto 0)
    );
end entity PS_2_Host;

architecture host of PS_2_Host is

function scanCode2ascii(a: std_logic_vector) return std_logic_vector is
    variable converted2ascii: std_logic_vector(7 downto 0) := (others => '0');
    constant k: std_logic_vector(7 downto 0) := a;
    begin
        case k is
            when x"1C" => converted2ascii := x"61"; -- a
            when x"32" => converted2ascii := x"62"; -- b
            when x"21" => converted2ascii := x"63"; -- c
            when x"23" => converted2ascii := x"64"; -- d
            when x"24" => converted2ascii := x"65"; -- e 
            when x"2B" => converted2ascii := x"66"; -- f
            when x"34" => converted2ascii := x"67"; -- g
            when x"33" => converted2ascii := x"68"; -- h
            when x"43" => converted2ascii := x"69"; -- i
            when x"3B" => converted2ascii := x"6A"; -- j
            when x"42" => converted2ascii := x"6B"; -- k 
            when x"4B" => converted2ascii := x"6C"; -- l
            when x"3A" => converted2ascii := x"6D"; -- m
            when others => converted2ascii := x"3F"; --?
        end case;
    return converted2ascii;
end function scanCode2ascii;

constant f0: std_logic_vector(7 downto 0) := x"F0";
signal message : std_logic_vector(7 downto 0);

begin

process(clk, data) is
    variable cont : natural := 0;
    variable convert, s_release : boolean := false;
    begin
        if(s_release = false) then
            ascii <= (others => 'Z');
        end if;
        if(clk'event and clk = '0') then
            cont := cont + 1;
            if(cont > 1 and cont <= 9) then    
                message(6 downto 0) <= message(7 downto 1);
                message(7) <= data;
            end if;
            if(cont = 11) then
                cont := 0;
                if(convert = true) then
                    ascii <= scanCode2ascii(message);
                    s_release := true;
                    convert := false;
                end if;
                if(message = f0) then
                    convert := true;
                end if;
            end if;
        end if;
end process;

end architecture host;