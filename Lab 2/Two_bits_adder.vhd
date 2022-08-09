
library ieee;					
use ieee.std_logic_1164.all;	
-- use ieee.numeric_std.all;

entity Two_bits_adder is 	-- entity definition 
	port(	SW: 		in 	std_logic_vector(9 downto 0); 	-- Toggle switches 
			LEDR:		out 	std_logic_vector(9 downto 0));   -- Red switches
end entity; 

architecture RTL of Two_bits_adder is 
signal a0, b0, a1, b1:	std_logic;	-- Naming inputs
signal cout1: std_logic; 
signal s0, s1, cout2: std_logic; 

component Full_adder is 
	port (a, b, cin: 	in  std_logic; 
			s, cout: 	out std_logic); 
end component; 

begin 
a0 <= SW(0); 
a1 <= SW(1); 
b0 <= SW(2); 
b1 <= SW(3);

component_1: entity work.Full_adder(RTL) port map(a0, b0, '0', s0, cout1); 
component_2: entity work.Full_adder(RTL) port map(a1, b1, cout1, s1, cout2); 
 

LEDR(0) <= s0;
LEDR(1) <= s1;
LEDR(2) <= cout2;

end architecture; 

			