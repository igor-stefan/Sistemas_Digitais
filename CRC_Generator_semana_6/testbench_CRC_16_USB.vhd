-- Code your testbench here
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity testbench is
end entity testbench;

architecture test of testbench is

component CRC_16_USB is
generic(n : natural := 16);
port(
CLK: in std_logic;-- Sinal de Clock. Para esse projeto, trabalhando em borda de subida.
DATA_IN: in std_logic;-- Serial Input.
CLR: in std_logic;-- Sinal assíncrono para limpar todos os FFs. Active High
CRC_OUT: out std_logic_vector(n - 1 downto 0);-- Saída paralela dos FFs
CRC_STATUS: out std_logic -- ‘1’ quando CRC_OUT for igual à 0, ‘0’ caso contrário.
);
end component CRC_16_USB;


constant k: natural := 16; --constante para prevenir erro
type q is array(0 to 4) of std_logic_vector((k*2) - 1 downto 0); --numeros para teste

signal numeros : q := ( 0 => "01010100101110101001001010100101",
						1 => "01001100101110101001001010100110",
                     	2 => "11101100101110101001001010101000",
                        3 => "01100110001110101001001010100101",
                        4 => "11111110001110101001001111101010"
						);

signal crc_status, clear, serial_in, clock: std_logic := '0';
signal message: std_logic_vector(k * 2 + k - 1 downto 0) := (others => '0');
signal saida: std_logic_vector(k - 1 downto 0) := (others => '0');

begin

dut: CRC_16_USB port map(
	CLK => clock,
    DATA_IN => serial_in,
    CLR => clear,
    CRC_OUT => saida,
    CRC_STATUS => crc_status
    );
    
process
	begin
    	for i in 0 to 4 loop
        	message(k * 2 + k - 1 downto k) <= numeros(i);
            wait for 10 ns;
            
        	--passando a mensagem no crc para gerar os bits extras
            for j in k * 2 + k - 1 downto 0 loop
            	serial_in <= message(j);
                clock <= '0';
                wait for 5 ns;
                clock <= '1';
                wait for 5 ns;
             end loop;
            message(k - 1 downto 0) <= saida;
            
            --limpa o crc para fazer a conferencia da mensagem
            clear <= '1';
            wait for 5 ns;
            clear <= '0';
            wait for 5 ns;
            
            -- conferindo se a mensagem está íntegra
            for x in k * 2 + k - 1 downto 0 loop
            	serial_in <= message(x);
                clock <= '0';
                wait for 5 ns;
                clock <= '1';
                wait for 5 ns;
             end loop;
             
             --se a saida for zero, entao está ok, o que implica em crc_status = 1;
            assert crc_status = '0' report "Teste " & integer'image(i + 1) & " ---> O pacote esta integro! -> Dado enviado = " & to_hex_string(message(k * 2 + k - 1 downto k)) & " -> CRC gerado = " & to_hex_string(message(k - 1 downto 0)) severity note;
            assert crc_status = '1' report "Teste " & integer'image(i + 1) & " ---> O pacote esta CORROMPIDO! -> Dado enviado = " & to_hex_string(message(k * 2 + k - 1 downto k)) & " -> CRC gerado = " & to_hex_string(message(k - 1 downto 0)) severity note;
            
            message <= (others => '0'); --zerando vetor para próxima mensagem de teste
        end loop;
     	wait;
   end process;
end architecture test;