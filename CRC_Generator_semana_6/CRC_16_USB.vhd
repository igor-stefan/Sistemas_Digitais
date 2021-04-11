-- Code your design here
library IEEE;
use IEEE.std_logic_1164.all;

entity CRC_16_USB is
generic(n : natural := 16);
port(
CLK: in std_logic;-- Sinal de Clock. Para esse projeto, trabalhando em borda de subida.
DATA_IN: in std_logic;-- Serial Input.
CLR: in std_logic;-- Sinal assíncrono para limpar todos os FFs. Active High
CRC_OUT: out std_logic_vector(n - 1 downto 0);-- Saída paralela dos FFs
CRC_STATUS: out std_logic -- ‘1’ quando CRC_OUT for igual à 0, ‘0’ caso contrário.
);
end entity CRC_16_USB;

architecture crc16 of CRC_16_USB is
constant comp : std_logic_vector(n - 1 downto 0) := (others => '0');
signal reg: std_logic_vector(n - 1 downto 0) := (others => '0');

begin

CRC_OUT <= reg;

CRC_STATUS <= '0' when reg /= comp else '1';

process(CLK, CLR) is
	variable next_0, next_2, next_15 : std_logic := '0';
	begin
    if(CLR = '1') then
    	reg <= (others => '0');
    elsif rising_edge(CLK) then
    	next_0 := DATA_IN xor reg(n - 1);
        next_2 := reg(1) xor reg(n - 1);
        next_15 := reg(n - 2) xor reg(n - 1);
        reg(n - 1 downto 1) <= reg(n - 2 downto 0);
        reg(n - 1) <= next_15;
        reg(n - 14) <= next_2;
        reg(0) <= next_0;
    end if;
end process;
end architecture crc16;
