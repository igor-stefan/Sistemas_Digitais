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
    signal square_root : std_logic_vector(t / 2 - 1 downto 0) := (others => '0');
    signal resto: std_logic_vector(t - 1 downto 0) := (others => '0');
    signal clk, reset : std_logic := '0';
    type numeros_teste is array(0 to 14) of std_logic_vector(t - 1 downto 0); --15 numeros de teste
    signal numbers : numeros_teste := ( 0 => "00000000000000000000001010011111",
                                        1 => "00000000000000000000001110000100",
                                        2 => "00000000000000000000011001101010",
                                        3 => "00000000000000000000000101101001",
                                        4 => "00000000000000000000000011011101",
                                        5 => "00000000000000000000010000000000",
                                        6 => "00000000000000000000001001111011",
                                        7 => "00000000000000000000001111000001",
                                        8 => "00000000000000000000000100011110",
                                        9 => "00000000000000000000010001000001",
                                        10 => "00000000000000000000011110110010",
                                        11 => "00000000000000000000010001000001",
                                        12 => "00000000000000000000010011001010",
                                        13 => "00000000000000000000000010010000",
                                        14 => "00000000000000000000000100110100"
                                        );
    signal num : std_logic_vector(t - 1 downto 0) := (others => '0');
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