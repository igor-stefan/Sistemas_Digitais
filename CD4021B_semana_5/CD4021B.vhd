-- Code your design here
library IEEE;
use IEEE.std_logic_1164.all;

entity CD4021B is
generic(n : natural := 8);
port(
serial_in, clock, psc : in std_logic; --psc --> parallel/serial control
parallel_in: in std_logic_vector(n - 1 downto 0);
q8, q7, q6: out std_logic );
end entity CD4021B;

architecture behavior of CD4021B is

signal reg : std_logic_vector(n - 1 downto 0) := (others => '0'); --registrador

begin

q8 <= reg(n - 1);
q7 <= reg(n - 2);
q6 <= reg(n - 3);

  process(clock, psc) is
  begin
  	if(psc = '1') then -- registra todos os valores
     	reg <= parallel_in;
  	elsif(clock'event and clock = '1') then
    	reg(n - 1 downto 1) <= reg(n - 2 downto 0); -- << sentido do deslocamento <<
        reg(0) <= serial_in;
    end if;
  end process;

end architecture behavior;