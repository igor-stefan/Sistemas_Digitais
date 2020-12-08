library IEEE;
use IEEE.std_logic_1164.all;

entity testbench is
end entity testbench;

architecture test of testbench is
    component psqrt_calculator is
        generic(
            n: natural := 32
        );
        port(
            a: in std_logic_vector(n - 1 downto 0);
            s: out std_logic_vector(n / 2 - 1 downto 0);
            r: out std_logic_vector(n - 1 downto 0)
        );
    end component psqrt_calculator;
    
    constant t : natural := 32;
    signal square_root : std_logic_vector(t / 2 - 1 downto 0);
    signal resto: std_logic_vector(t - 1 downto 0);
    type numeros_teste is array(0 to 14) of std_logic_vector(t - 1 downto 0); --15 numeros de teste
    signal numbers : numeros_teste := ( 0 => "00000000000000000000001101010110",
                                        1 => "00000000000000000000000100000010",
                                        2 => "00000000000000000000000110001110",
                                        3 => "00000000000000000000001000100000",
                                        4 => "00000000000000000000001010001101",
                                        5 => "00000000000000000000001100001100",
                                        6 => "00000000000000000000001101010110",
                                        7 => "00000000000000000000001001100110",
                                        8 => "00000000000000000000001110110011",
                                        9 => "00000000000000000000000110000001",
                                        10 => "00000000000000000000000101010110",
                                        11 => "00000000000000000000000000010101",
                                        12 => "00000000000000000000000111011001",
                                        13 => "00000000000000000000000100100011",
                                        14 => "00000000000000000000001000111001"
                                        );
    signal num : std_logic_vector(t - 1 downto 0);
    begin
        dut: psqrt_calculator port map(
            a => num,
            s => square_root,
            r => resto
        );
        process is
        begin
        for j in 0 to 14 loop
            num <= numbers(j);
            wait for 10 ns;
        end loop;
        wait;
        end process;
end architecture test;