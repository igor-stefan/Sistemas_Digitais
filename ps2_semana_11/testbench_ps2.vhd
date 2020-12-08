library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;


entity testbench is
end entity testbench;

architecture test of testbench is

function parity_generator(a: std_logic_vector) return std_logic is
    variable cont: integer := 0;
    constant k: std_logic_vector(7 downto 0) := a;
    begin
    for i in 7 downto 0 loop
        if k(i) = '1' then
            cont := cont + 1;
        end if;
    end loop;
    if (cont rem 2) = 1 then
        return '0';
    else
        return '1';
    end if;
end function parity_generator;

component PS_2_Host is
    port(
        clk: in std_logic;
        data: in std_logic;
        ascii: out std_logic_vector(7 downto 0)
    );
end component PS_2_Host;

signal clk, data, parity : std_logic := '0';
signal ascii : std_logic_vector(7 downto 0) := (others => 'Z');
signal to_send : std_logic_vector(10 downto 0) := (others => '0');
type testes is array(0 to 5) of std_logic_vector(7 downto 0);
constant myCases : testes := (0 => x"1C", --a
                              1 => x"32", --b
                              2 => x"21", --c
                              3 => x"23", --d
                              4 => x"24", --e
                              5 => x"2B"); --f
constant f0 : std_logic_vector(7 downto 0) := x"F0";
constant start_bit : std_logic  := '0';
constant stop_bit : std_logic  := '1';

begin

dut: PS_2_Host port map(
    clk => clk,
    data => data,
    ascii => ascii
);

process is
begin
------------------- Apertando tecla a -----------------
    clk <= '1';
    data <= '1';
    wait for 5 ns;
    parity <= parity_generator(myCases(0));
    to_send <= stop_bit & parity & myCases(0) & start_bit;
    for i in 0 to 10 loop
        clk <= '0';
        data <= to_send(i);
        wait for 5 ns;
        clk <= '1';
        wait for 5 ns;
    end loop;
------------------- Liberando tecla a -----------------
    parity <= parity_generator(f0);
    to_send <= stop_bit & parity & f0 & start_bit;
    for i in 0 to 10 loop
        clk <= '0';
        data <= to_send(i);
        wait for 5 ns;
        clk <= '1';
        wait for 5 ns;
    end loop;
    parity <= parity_generator(myCases(0));
    to_send <= stop_bit & parity & myCases(0) & start_bit;
    for i in 0 to 10 loop
        clk <= '0';
        data <= to_send(i);
        wait for 5 ns;
        clk <= '1';
        wait for 5 ns;
    end loop;
------------------- Apertando tecla b -----------------
    clk <= '1';
    data <= '1';
    wait for 5 ns;
    parity <= parity_generator(myCases(1));
    to_send <= stop_bit & parity & myCases(1) & start_bit;
    for i in 0 to 10 loop
        clk <= '0';
        data <= to_send(i);
        wait for 5 ns;
        clk <= '1';
        wait for 5 ns;
    end loop;
------------------- Apertando tecla c -----------------
    clk <= '1';
    data <= '1';
    wait for 5 ns;
    parity <= parity_generator(myCases(2));
    to_send <= stop_bit & parity & myCases(2) & start_bit;
    for i in 0 to 10 loop
        clk <= '0';
        data <= to_send(i);
        wait for 5 ns;
        clk <= '1';
        wait for 5 ns;
    end loop;
------------------- Liberando tecla b -----------------
    parity <= parity_generator(f0);
    to_send <= stop_bit & parity & f0 & start_bit;
    for i in 0 to 10 loop
        clk <= '0';
        data <= to_send(i);
        wait for 5 ns;
        clk <= '1';
        wait for 5 ns;
    end loop;
    parity <= parity_generator(myCases(1));
    to_send <= stop_bit & parity & myCases(1) & start_bit;
    for i in 0 to 10 loop
        clk <= '0';
        data <= to_send(i);
        wait for 5 ns;
        clk <= '1';
        wait for 5 ns;
    end loop;
------------------- Liberando tecla c -----------------
    parity <= parity_generator(f0);
    to_send <= stop_bit & parity & f0 & start_bit;
    for i in 0 to 10 loop
        clk <= '0';
        data <= to_send(i);
        wait for 5 ns;
        clk <= '1';
        wait for 5 ns;
    end loop;
    parity <= parity_generator(myCases(2));
    to_send <= stop_bit & parity & myCases(2) & start_bit;
    for i in 0 to 10 loop
        clk <= '0';
        data <= to_send(i);
        wait for 5 ns;
        clk <= '1';
        wait for 5 ns;
    end loop;
------------------- Apertando tecla d -----------------
    clk <= '1';
    data <= '1';
    wait for 5 ns;
    parity <= parity_generator(myCases(3));
    to_send <= stop_bit & parity & myCases(3) & start_bit;
    for i in 0 to 10 loop
        clk <= '0';
        data <= to_send(i);
        wait for 5 ns;
        clk <= '1';
        wait for 5 ns;
    end loop;
------------------- Liberando tecla d -----------------
    parity <= parity_generator(f0);
    to_send <= stop_bit & parity & f0 & start_bit;
    for i in 0 to 10 loop
        clk <= '0';
        data <= to_send(i);
        wait for 5 ns;
        clk <= '1';
        wait for 5 ns;
    end loop;
    parity <= parity_generator(myCases(3));
    to_send <= stop_bit & parity & myCases(3) & start_bit;
    for i in 0 to 10 loop
        clk <= '0';
        data <= to_send(i);
        wait for 5 ns;
        clk <= '1';
        wait for 5 ns;
    end loop;
------------------- Apertando tecla e -----------------
    clk <= '1';
    data <= '1';
    wait for 5 ns;
    parity <= parity_generator(myCases(4));
    to_send <= stop_bit & parity & myCases(4) & start_bit;
    for i in 0 to 10 loop
        clk <= '0';
        data <= to_send(i);
        wait for 5 ns;
        clk <= '1';
        wait for 5 ns;
    end loop;
------------------- Apertando tecla f -----------------
    clk <= '1';
    data <= '1';
    wait for 5 ns;
    parity <= parity_generator(myCases(5));
    to_send <= stop_bit & parity & myCases(5) & start_bit;
    for i in 0 to 10 loop
        clk <= '0';
        data <= to_send(i);
        wait for 5 ns;
        clk <= '1';
        wait for 5 ns;
    end loop;
------------------- Liberando tecla f -----------------
    parity <= parity_generator(f0);
    to_send <= stop_bit & parity & f0 & start_bit;
    for i in 0 to 10 loop
        clk <= '0';
        data <= to_send(i);
        wait for 5 ns;
        clk <= '1';
        wait for 5 ns;
    end loop;
    parity <= parity_generator(myCases(5));
    to_send <= stop_bit & parity & myCases(5) & start_bit;
    for i in 0 to 10 loop
        clk <= '0';
        data <= to_send(i);
        wait for 5 ns;
        clk <= '1';
        wait for 5 ns;
    end loop;
------------------- Liberando tecla e -----------------
    parity <= parity_generator(f0);
    to_send <= stop_bit & parity & f0 & start_bit;
    for i in 0 to 10 loop
        clk <= '0';
        data <= to_send(i);
        wait for 5 ns;
        clk <= '1';
        wait for 5 ns;
    end loop;
    parity <= parity_generator(myCases(4));
    to_send <= stop_bit & parity & myCases(4) & start_bit;
    for i in 0 to 10 loop
        clk <= '0';
        data <= to_send(i);
        wait for 5 ns;
        clk <= '1';
        wait for 5 ns;
    end loop;
    for i in 0 to 4 loop
        clk <= '0';
        wait for 5 ns;
        clk <= '1';
        wait for 5 ns;
    end loop;

wait;
end process;

end architecture test;