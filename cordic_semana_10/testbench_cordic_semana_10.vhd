-- Code your testbench here
library IEEE;
use IEEE.std_logic_1164.all;

entity testbench is
end entity testbench;

architecture test of testbench is

component cordic is
port(
    x1, y1, theta: in std_logic_vector(15 downto 0);
    x2, y2 : out std_logic_vector(15 downto 0)
);
end component cordic;

constant x1 : std_logic_vector(15 downto 0) := "0000000010011011";
constant y1: std_logic_vector(15 downto 0) := "0000000000000000"; 
signal theta, cos_theta, sin_theta: std_logic_vector(15 downto 0) := (others => '0');

begin

dut: cordic port map(
	x1 => x1,
    y1 => y1,
    theta => theta,
    x2 => cos_theta,
    y2 => sin_theta
);


theta <= 
------ Angulos do material semana 10 ------
         x"0070", --25º sin(25) = 0.42262 cos(25) = 0.90631
		 x"00DF" after 10 ns, --50º sin(50) = 0.76604 cos(50) = 0.64279
         x"009C" after 20 ns, --35º sin(35) = 0.57358 cos(35) = 0.81915
         x"002D" after 30 ns, --10º sin(10) = 0.17365 cos(10) = 0.98481
------ Angulos notáveis ------
         x"0086" after 40 ns, --30º sin(30) = 0.50000 cos(30) = 0.86603
         x"00C9" after 50 ns, --45º sin(45) = 0.70711 cos(45) = 0.70711
         x"010C" after 60 ns, --60º sin(60) = 0.86603 cos(60) = 0.50000
------ Casos extremos ------
         x"018E" after 70 ns, --89º sin(89) = 0.99985 cos(89) = 0.01745
         x"0192" after 80 ns, --90º sin(90) = 1.00000 cos(90) = 0.00000
         x"0004" after 90 ns, --1º sin(1) = 0.01745 cos(1) = 0.99985
         x"0000" after 100 ns, --0º sin(0) = 0.00000 cos(0) = 1.00000
------ Casos aleatorios ------
         x"003B" after 110 ns, --13,2º sin(13.2) = 0.22835 cos(13.2) = 0.97358
         x"013B" after 120 ns, --70,4º sin(70.4) = 0.94206 cos(70.4) = 0.33545
         x"014F" after 130 ns, --75º sin(75) = 0.96593 cos(75) = 0.25882
         x"0068" after 140 ns, --23,3º sin(23.3) = 0.39555 cos(23.3) = 0.91845
         x"0121" after 150 ns, --64,7º sin(64.7) = 0.90408 cos(64.7) = 0.42736
         x"00CB" after 160 ns, --45,4º sin(45.4) = 0.71203 cos(45.4) = 0.70215
         x"0086" after 170 ns; --30º este teste nao aparece no epWave
end architecture test;