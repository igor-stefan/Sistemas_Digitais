library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity operador_q is
    generic(n: natural := 32);
    port(
        q_op: in std_logic_vector(n - 1 downto 0);
        rp_signal: in std_logic;
        q_parcial_op: out std_logic_vector(n - 1 downto 0)
    );
end entity operador_q;

architecture operando_q of operador_q is
    signal s: std_logic_vector(n - 1 downto 0) := (others => '0');
    begin
        s(n - 1 downto 1) <= q_op(n - 2 downto 0);
        s(0) <= '1' when rp_signal = '0' else '0';
        q_parcial_op <= s;
end architecture operando_q;