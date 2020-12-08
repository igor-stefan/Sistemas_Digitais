library IEEE;
use IEEE.std_logic_1164.all;

entity testbench is
end entity testbench;

architecture test of testbench is
    component sqrt_calculator is
        generic(
            n: natural := 32
        );
        port(
            a: in std_logic_vector(n - 1 downto 0);
            clk, reset: in std_logic;
            s: out std_logic_vector(n / 2 - 1 downto 0);
            r: out std_logic_vector(n - 1 downto 0)
        );
    end component sqrt_calculator;
    
    constant t : natural := 32;
    signal square_root : std_logic_vector(t / 2 - 1 downto 0);
    signal resto: std_logic_vector(t - 1 downto 0);
    signal clk, reset : std_logic := '0';
    type numeros_teste is array(0 to 14) of std_logic_vector(t - 1 downto 0); --15 numeros de teste
    signal numbers : numeros_teste := ( 0 => "00000000000000000000111100000100",
                                        1 => "00000000000000000000000110111001",
                                        2 => "00000000000000000000110100100100",
                                        3 => "00000000000000000000001001110001",
                                        4 => "00000000000000000000100010100001",
                                        5 => "00000000000000000000101101100100",
                                        6 => "00000000000000000000001101001001",
                                        7 => "00000000000000000000111010001001",
                                        8 => "00000000000000000000111110000001",
                                        9 => "00000000000000000000000111100100",
                                        10 => "00000000000000000000110100100100",
                                        11 => "00000000000000000000101011111001",
                                        12 => "00000000000000000000010100010000",
                                        13 => "00000000000000000000001001000000",
                                        14 => "00000000000000000000000100100001"  
                                        );
    signal num : std_logic_vector(t - 1 downto 0);
    begin
        dut: sqrt_calculator port map(
            a => num,
            clk => clk,
            s => square_root,
            r => resto,
            reset => reset
        );
        process is
        begin
        for j in 0 to 14 loop
            reset <= '1';
            wait for 5 ns;
            reset <= '0';
            num <= numbers(j);
            for i in 20 downto 0 loop
                clk <= '1';
                wait for 5 ns;
                clk <= '0';
                wait for 5 ns;
            end loop;
        end loop;
        wait;
        end process;
end architecture test;