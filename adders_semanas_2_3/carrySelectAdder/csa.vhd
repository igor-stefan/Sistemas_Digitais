-- Code your design here
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity carry_select_adder is
generic(n : integer := 8;
		devo_subtrair : std_logic := '0');
port(a, b: in std_logic_vector(n - 1 downto 0);
sum: out std_logic_vector(n downto 0));
end entity carry_select_adder;

architecture work of carry_select_adder is
constant tamanho_k: integer := n;

component rca is
  generic(n : integer;
          ci: std_logic);
  port(
      a: in std_logic_vector(n - 1 downto 0);
      b: in std_logic_vector(n - 1 downto 0);
      sum: out std_logic_vector(n downto 0)
  );
end component rca;

component muxV_1 is
  generic(n: integer);
  port(
  a, b : in std_logic_vector(n downto 0);
  s: in std_logic;
  z: out std_logic_vector(n downto 0)
  );
end component muxV_1;

signal carry_c: std_logic := devo_subtrair;
signal carry_a: std_logic := '0';
signal carry_b: std_logic := '1';
signal v0_a, v1_a, v0_b, v1_b: std_logic_vector((tamanho_k / 2) - 1 downto 0);
signal res_a, res_b, res_c, res_selecionado: std_logic_vector(tamanho_k / 2 downto 0);

begin

  v1_a <= a(n - 1 downto n / 2);
  v0_a <= a((n / 2) - 1 downto 0);

	xor_vetor_b1: for x in (n / 2) - 1 downto 0 generate
	v1_b(x) <= carry_c xor b(x + n / 2);
    end generate;

	xor_vetor_b0: for x in (n / 2) - 1 downto 0 generate
	v0_b(x) <= carry_c xor b(x);
    end generate;


      instanciar_rca1: rca generic map(
      n => tamanho_k / 2,
      ci => carry_a)
      port map(
      a => v1_a,
      b => v1_b,
      sum => res_a 
      );
      
      instanciar_rca2: rca generic map(
      n => tamanho_k / 2,
      ci => carry_b)
      port map(
      a => v1_a,
      b => v1_b,
      sum => res_b 
      );
      
      instanciar_rca3: rca generic map(
      n => tamanho_k / 2,
      ci => devo_subtrair)
      port map(
      a => v0_a,
      b => v0_b,
      sum => res_c  
      );
      
    instanciar_mux: muxV_1 generic map(
    	n => tamanho_k / 2)
        port map(
        a => res_a,
        b => res_b,
        s => res_c(tamanho_k / 2),
        z => res_selecionado
        );
        
     sum <= res_selecionado & res_c((tamanho_k / 2) - 1 downto 0);   
      
end architecture work;

